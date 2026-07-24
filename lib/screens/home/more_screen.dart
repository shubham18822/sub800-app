import 'package:flutter/material.dart';

import '../../config/theme.dart';
import '../../utils/responsive.dart';
import '../../widgets/app_header_search.dart';
import 'profile_settings_screen.dart';
import 'payment_methods_screen.dart';
import 'contracts_invoices_receipts_screen.dart';
import 'team_settings_screen.dart';

class MoreScreen extends StatelessWidget {
  final int currentNavIndex;
  final Function(int) onNavTap;

  const MoreScreen({
    super.key,
    required this.currentNavIndex,
    required this.onNavTap,
  });

  static const List<String> _menuItems = [
    'Profile Settings',
    'Payment Methods',
    'Contracts, Invoices & Receipts',
    'Team Settings',
    'Your Workspace Analytics',
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          // padding: EdgeInsets.symmetric(horizontal: context.rw(16), vertical: context.rh(16)),
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05,
            vertical: 0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const AppHeaderSearch(padding: EdgeInsets.zero),
              SizedBox(height: context.rh(20)),
              ..._menuItems.map((title) => _buildMenuItem(context, title)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, String title) {
    return InkWell(
      onTap: () {
        if (title == 'Profile Settings') {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ProfileSettingsScreen(
                currentNavIndex: currentNavIndex,
                onNavTap: onNavTap,
              ),
            ),
          );
        } else if (title == 'Payment Methods') {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => PaymentMethodsScreen(
                currentNavIndex: currentNavIndex,
                onNavTap: onNavTap,
              ),
            ),
          );
        } else if (title == 'Contracts, Invoices & Receipts') {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ContractsInvoicesReceiptsScreen(
                currentNavIndex: currentNavIndex,
                onNavTap: onNavTap,
              ),
            ),
          );
        } else if (title == 'Team Settings') {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => TeamSettingsScreen(
                currentNavIndex: currentNavIndex,
                onNavTap: onNavTap,
              ),
            ),
          );
        } else if (title == 'Your Workspace Analytics') {
          onNavTap(2);
        }
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: context.rh(12)),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: const Color(0xFF7FA3A8).withValues(alpha: 0.75),
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: AppTheme.dmSans(
                  fontSize: context.rf(12),
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF5E7E83),
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              size: context.rw(18),
              color: const Color(0xFF7FA3A8),
            ),
          ],
        ),
      ),
    );
  }
}
