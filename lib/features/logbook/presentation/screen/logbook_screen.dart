import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../../provider/logbook_provider.dart';
import '../widgets/flight_entry_card.dart';
import '../widgets/logbook_summary_cards.dart';

class LogbookScreen extends StatefulWidget {
  const LogbookScreen({super.key});

  @override
  State<LogbookScreen> createState() => _LogbookScreenState();
}

class _LogbookScreenState extends State<LogbookScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LogbookProvider>().fetchLogbook();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LogbookProvider>();

    return Scaffold(
      backgroundColor: AppColors.primarybackground,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(provider),

          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.whitebackground,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
                child: _buildBody(provider),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(LogbookProvider provider) {
    return Container(
      color: AppColors.primarybackground,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Pilot Logbook',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textwhite,
                ),
              ),
              const SizedBox(height: 24),
              if (provider.summary != null)
                LogbookSummaryCards(summary: provider.summary!),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody(LogbookProvider provider) {
    if (provider.isLoading && provider.summary == null) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.secondary),
      );
    }

    if (provider.error != null && provider.summary == null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline_rounded,
              color: AppColors.textHint,
              size: 48,
            ),
            const SizedBox(height: 12),
            Text(
              provider.error!,
              style: const TextStyle(color: AppColors.textHint),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.read<LogbookProvider>().fetchLogbook(),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (provider.summary == null) {
        return const SizedBox.shrink();
    }

    final summary = provider.summary!;
    final entries = summary.recentEntries;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'RECENT FLIGHTS',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textSecondary,
                  letterSpacing: 1.4,
                ),
              ),
              Text(
                '${entries.length} entries',
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: entries.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              return FlightEntryCard(entry: entries[index]);
            },
          ),
          const SizedBox(height: 24),
          _buildAddEntryButton(),
        ],
      ),
    );
  }

  Widget _buildAddEntryButton() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.textSecondary.withValues(alpha: 0.3),
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.add,
              color: AppColors.secondary,
              size: 20,
            ),
            const SizedBox(width: 8),
            const Text(
              'Add Logbook Entry',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


