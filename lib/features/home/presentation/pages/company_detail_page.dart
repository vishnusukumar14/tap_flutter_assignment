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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text(''),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: BlocConsumer<CompanyDetailCubit, CompanyDetailState>(
        listener: (context, state) {},
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () =>
                context.read<CompanyDetailCubit>().refreshCompanyDetail(),
            child: _buildBody(context, state),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, CompanyDetailState state) {
    if (state is CompanyDetailLoading) {
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
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      );
    }

    if (state is CompanyDetailLoaded || state is CompanyDetailRefreshing) {
      final companyDetail = state is CompanyDetailLoaded
          ? state.companyDetail
          : (state as CompanyDetailRefreshing).previousData;

      return Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: CompanyDetailHeaderSection(companyDetail: companyDetail),
            ),
          ),
        ],
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
