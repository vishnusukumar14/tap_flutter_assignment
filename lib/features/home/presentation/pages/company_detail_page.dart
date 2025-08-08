import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection.dart';
import '../cubit/company_detail_cubit.dart';
import '../cubit/company_detail_state.dart';
import '../widgets/company_detail_header_section.dart';
import '../widgets/error_widget.dart';

class CompanyDetailPage extends StatelessWidget {
  final String companyId;

  const CompanyDetailPage({super.key, required this.companyId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CompanyDetailCubit>()..loadCompanyDetail(),
      child: CompanyDetailView(companyId: companyId),
    );
  }
}

class CompanyDetailView extends StatelessWidget {
  final String companyId;

  const CompanyDetailView({super.key, required this.companyId});

  static Widget _buildBackButton(VoidCallback onPressed) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade200, width: 0.5),
        color: Colors.white,
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: const Icon(Icons.arrow_back, color: Colors.black, size: 18),
        onPressed: onPressed,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Colors.grey.shade50;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        leadingWidth: 76,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: _buildBackButton(() => Navigator.of(context).pop()),
        ),
      ),
      body: SafeArea(
        child: BlocConsumer<CompanyDetailCubit, CompanyDetailState>(
          listener: (context, state) {},
          builder: (context, state) {
            return RefreshIndicator(
              onRefresh: () =>
                  context.read<CompanyDetailCubit>().refreshCompanyDetail(),
              child: _buildBody(context, state),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, CompanyDetailState state) {
    if (state is CompanyDetailLoading) {
      return const _LoadingWidget();
    }

    if (state is CompanyDetailLoaded || state is CompanyDetailRefreshing) {
      final companyDetail = state is CompanyDetailLoaded
          ? state.companyDetail
          : (state as CompanyDetailRefreshing).previousData;

      return SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: CompanyDetailHeaderSection(companyDetail: companyDetail),
      );
    }

    if (state is CompanyDetailError) {
      return SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height - 200,
          child: CustomErrorWidget(
            error: state.message,
            onRetry: () =>
                context.read<CompanyDetailCubit>().loadCompanyDetail(),
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(color: Colors.black),
          ),
          SizedBox(height: 16),
          Text(
            'Loading company details...',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
