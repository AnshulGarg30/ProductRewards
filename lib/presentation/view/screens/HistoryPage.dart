import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/HistoryProvider.dart';
import 'package:intl/intl.dart';

class HistoryPage extends StatefulWidget {

  final String? userID;
  const HistoryPage({Key? key, required this.userID}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    super.initState();
    // Call API on page load
    Future.microtask(() {
      Provider.of<HistoryProvider>(context, listen: false).fetchHistory(widget.userID.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('History')),
      body: Consumer<HistoryProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.errorMessage != null) {
            return Center(child: Text(provider.errorMessage!));
          }

          if (provider.items.isEmpty) {
            return const Center(child: Text('No history found.'));
          }

          // Group by date (yyyy-MM-dd)
          final grouped = <String, List<dynamic>>{};
          for (var item in provider.items) {
            final date = item.createdAt.split('T')[0];
            grouped.putIfAbsent(date, () => []).add(item);
          }

          // Sort dates descending
          final sortedDates = grouped.keys.toList()
            ..sort((a, b) => b.compareTo(a));

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: sortedDates.length,
            itemBuilder: (context, dateIndex) {
              final date = sortedDates[dateIndex];
              final itemsForDate = grouped[date]!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat('MMMM dd, yyyy').format(DateTime.parse(date)),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ...itemsForDate.map((item) => Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Des: ${item.description}',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 3),
                        Row(
                          children: [
                            if (item.debit != 0 && item.debit != null)
                              Text(
                                'Redeemed: -${item.debit} pts',
                                style: const TextStyle(color: Colors.red, fontSize: 14),
                              ),
                            if (item.credit != 0 && item.credit != null)
                              Text(
                                'Earned: +${item.credit} pts',
                                style: const TextStyle(color: Colors.green, fontSize: 14),
                              ),
                          ],
                        ),
                        const SizedBox(height: 3),
                        Text(
                          'Total Points: ${item.total}',
                          style: const TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                        // Text(
                        //   'Time: ${item.createdAt.split("T")[1].split(".")[0]}',
                        //   style: const TextStyle(fontSize: 12, color: Colors.black38),
                        // ),
                      ],
                    ),
                  )),
                  const SizedBox(height: 20),
                ],
              );
            },
          );
        },
      ),
    );
  }

}
