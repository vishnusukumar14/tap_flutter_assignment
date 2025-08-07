import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection.dart';
import '../cubit/bond_detail_cubit.dart';
import '../cubit/bond_detail_state.dart';
import '../widgets/bond_detail_header_section.dart';
import '../widgets/error_widget.dart';

class BondDetailPage extends StatelessWidget {
  final String bondId;

  const BondDetailPage({super.key, required this.bondId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<BondDetailCubit>()..loadBondDetail(),
      child: BondDetailView(bondId: bondId),
    );
  }
}

class BondDetailView extends StatelessWidget {
  final String bondId;

  const BondDetailView({super.key, required this.bondId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text(''),
        // backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: BlocConsumer<BondDetailCubit, BondDetailState>(
        listener: (context, state) {
          if (state is BondDetailRefreshing) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Refreshing bond details...'),
                duration: Duration(seconds: 1),
              ),
            );
          }
        },
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () =>
                context.read<BondDetailCubit>().refreshBondDetail(),
            child: _buildBody(context, state),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, BondDetailState state) {
    if (state is BondDetailLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Loading bond details...'),
          ],
        ),
      );
    }

    if (state is BondDetailLoaded || state is BondDetailRefreshing) {
      final bondDetail = state is BondDetailLoaded
          ? state.bondDetail
          : (state as BondDetailRefreshing).previousData;

      return Column(
        children: [
          if (state is BondDetailRefreshing)
            const LinearProgressIndicator(minHeight: 2),
          Expanded(child: BondDetailHeaderSection(bondDetail: bondDetail)),
        ],
      );
    }

    if (state is BondDetailError) {
      return CustomErrorWidget(
        error: state.message,
        onRetry: () => context.read<BondDetailCubit>().loadBondDetail(),
      );
    }

    return const SizedBox.shrink();
  }
}
