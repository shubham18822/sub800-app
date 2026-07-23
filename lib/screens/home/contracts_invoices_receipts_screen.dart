import 'package:flutter/material.dart';

import '../../config/theme.dart';
import '../../utils/responsive.dart';
import '../../widgets/app_bottom_nav_bar.dart';
import '../../widgets/app_header_search.dart';

class ContractsInvoicesReceiptsScreen extends StatelessWidget {
  final int currentNavIndex;
  final Function(int) onNavTap;

  const ContractsInvoicesReceiptsScreen({
    super.key,
    required this.currentNavIndex,
    required this.onNavTap,
  });

  static const List<_DocumentSection> _sections = [
    _DocumentSection(
      title: 'Contracts',
      items: [
        _DocumentItem('Service Agreement', '12/06/2026'),
      ],
    ),
    _DocumentSection(
      title: 'Invoices & Receipts',
      items: [
        _DocumentItem('Sofa Purchase', '12/06/2026'),
        _DocumentItem('Monthly sub800 Invoice', '12/06/2026'),
        _DocumentItem('Sofa Purchase', '12/06/2026'),
        _DocumentItem('Monthly sub800 Invoice', '12/06/2026'),
        _DocumentItem('Sofa Purchase', '12/06/2026'),
        _DocumentItem('Monthly sub800 Invoice', '12/06/2026'),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.rw(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppHeaderSearch(
                  padding: EdgeInsets.zero,
                ),
                SizedBox(height: context.rh(16)),
                ..._sections.expand((section) => [
                      Text(
                        section.title,
                        style: AppTheme.dmSans(
                          fontSize: context.rf(15),
                          fontWeight: FontWeight.w500,
                          color: AppTheme.textDark,
                        ),
                      ),
                      SizedBox(height: context.rh(10)),
                      ...section.items.map(
                        (item) => Padding(
                          padding: EdgeInsets.only(bottom: context.rh(8)),
                          child: _DocumentCard(item: item),
                        ),
                      ),
                      SizedBox(height: context.rh(16)),
                    ]),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: currentNavIndex,
        onTap: onNavTap,
      ),
    );
  }
}

class _DocumentCard extends StatelessWidget {
  final _DocumentItem item;

  const _DocumentCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: context.rw(10),
        vertical: context.rh(8),
      ),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF8B8B8B), width: 1),
        borderRadius: BorderRadius.circular(1),
        color: Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: AppTheme.dmSans(
                    fontSize: context.rf(11),
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF7A9AA0),
                  ),
                ),
                SizedBox(height: context.rh(2)),
                Text(
                  item.date,
                  style: AppTheme.dmSans(
                    fontSize: context.rf(8),
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFFA9B1B3),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: context.rw(8)),
          Padding(
            padding: EdgeInsets.only(top: context.rh(12)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                'View Document',
                style: AppTheme.dmSans(
                  fontSize: context.rf(8),
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF7A9AA0),
                ),
              ),
              Icon(
                Icons.chevron_right,
                size: context.rw(10),
                color: const Color(0xFF7A9AA0),
              ),
            ],
          ),
          ),
        ],
      ),
    );
  }
}

class _DocumentSection {
  final String title;
  final List<_DocumentItem> items;

  const _DocumentSection({required this.title, required this.items});
}

class _DocumentItem {
  final String title;
  final String date;

  const _DocumentItem(this.title, this.date);
}

