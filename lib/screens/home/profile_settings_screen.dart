import 'package:flutter/material.dart';

import '../../config/routes.dart';
import '../../config/theme.dart';
import '../../utils/responsive.dart';
import '../../widgets/app_bottom_nav_bar.dart';
import '../../widgets/app_header_search.dart';

class ProfileSettingsScreen extends StatelessWidget {
  final int currentNavIndex;
  final Function(int) onNavTap;

  const ProfileSettingsScreen({
    super.key,
    required this.currentNavIndex,
    required this.onNavTap,
  });

  static const List<_ProfileField> _fields = [
    _ProfileField(label: 'Your Name', value: 'Lauren Matthews'),
    _ProfileField(label: 'Email Address', value: 'lauren@sub800.com'),
    _ProfileField(label: 'Phone Number', value: '07715 803 330'),
    _ProfileField(label: 'Job Title', value: 'Brand Manager'),
    _ProfileField(label: 'Birthday', value: '12/06/1999'),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                const AppHeaderSearch(
                  padding: EdgeInsets.zero,
                ),
                SizedBox(height: context.rh(28)),
                ..._fields.map((field) => _buildField(context, field)),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: currentNavIndex,
        onTap: (i) {
          onNavTap(i);
          Navigator.of(context).popUntil(ModalRoute.withName(Routes.home));
        },
      ),
    );
  }

  Widget _buildField(BuildContext context, _ProfileField field) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.rh(28)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  field.label,
                  style: AppTheme.dmSans(
                    fontSize: context.rf(32 / 2),
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF1F2023),
                  ),
                ),
                SizedBox(height: context.rh(8)),
                Text(
                  field.value,
                  style: AppTheme.dmSans(
                    fontSize: context.rf(10),
                    color: const Color(0xFF7A9AA0),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: context.rh(2)),
            child: Icon(
              Icons.edit,
              size: context.rw(14),
              color: const Color(0xFF6F8E95),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileField {
  final String label;
  final String value;

  const _ProfileField({required this.label, required this.value});
}

