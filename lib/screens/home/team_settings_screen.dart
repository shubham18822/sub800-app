import 'package:flutter/material.dart';

import '../../config/theme.dart';
import '../../utils/responsive.dart';
import '../../widgets/app_bottom_nav_bar.dart';
import '../../widgets/app_header_search.dart';

class TeamSettingsScreen extends StatelessWidget {
  final int currentNavIndex;
  final Function(int) onNavTap;

  const TeamSettingsScreen({
    super.key,
    required this.currentNavIndex,
    required this.onNavTap,
  });

  static const List<_TeamMember> _admins = [
    _TeamMember(
      name: 'Alex Gastie',
      role: 'CEO',
      email: 'alex@sub800.com',
      showDelete: true,
    ),
    _TeamMember(
      name: 'Alex Gastie',
      role: 'CEO',
      email: 'alex@sub800.com',
      showDelete: true,
    ),
  ];

  static const List<_TeamMember> _users = [
    _TeamMember(
      name: 'Alex Gastie',
      role: 'CEO',
      email: 'alex@sub800.com',
      showDelete: true,
    ),
    _TeamMember(
      name: 'Alex Gastie',
      role: 'CEO',
      email: 'alex@sub800.com',
      showDelete: true,
    ),
    _TeamMember(
      name: 'Alex Gastie',
      role: 'CEO',
      email: 'alex@sub800.com',
      showDelete: true,
    ),
    _TeamMember(
      name: 'Alex Gastie',
      role: 'CEO',
      email: 'alex@sub800.com',
      showDelete: true,
    ),
    _TeamMember(
      name: 'Alex Gastie',
      role: 'CEO',
      email: 'alex@sub800.com',
      showDelete: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.rw(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppHeaderSearch(
                  padding: EdgeInsets.zero,
                ),
                SizedBox(height: context.rh(10)),
                _buildSection(
                  context,
                  title: 'Admins',
                  members: _admins,
                ),
                SizedBox(height: context.rh(14)),
                _buildSection(
                  context,
                  title: 'Users',
                  members: _users,
                ),
                SizedBox(height: context.rh(24)),
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

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required List<_TeamMember> members,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTheme.dmSans(
            fontSize: context.rf(14),
            fontWeight: FontWeight.w400,
            color: AppTheme.textDark,
          ),
        ),
        SizedBox(height: context.rh(18)),
        ...members.map(
          (member) => Padding(
            padding: EdgeInsets.only(bottom: context.rh(6)),
            child: _TeamMemberRow(member: member),
          ),
        ),
      ],
    );
  }
}

class _TeamMemberRow extends StatelessWidget {
  final _TeamMember member;

  const _TeamMemberRow({required this.member});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.rh(4)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: context.rw(48),
            height: context.rw(48),
            decoration: const BoxDecoration(
              color: Color(0xFFD6D6D6),
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: context.rw(14)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  member.name,
                  style: AppTheme.dmSans(
                    fontSize: context.rf(14),
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF87969A),
                  ),
                ),
                SizedBox(height: context.rh(2)),
                Text(
                  member.role,
                  style: AppTheme.dmSans(
                    fontSize: context.rf(12),
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFFB0B9BB),
                  ),
                ),
                SizedBox(height: context.rh(2)),
                Text(
                  member.email,
                  style: AppTheme.dmSans(
                    fontSize: context.rf(8),
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFFB0B9BB),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: context.rw(8)),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.edit_outlined,
                size: context.rw(13),
                color: const Color(0xFF8FA2A6),
              ),
              if (member.showDelete) ...[
                SizedBox(height: context.rh(7)),
                Icon(
                  Icons.delete_outline,
                  size: context.rw(13),
                  color: const Color(0xFF8FA2A6),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _TeamMember {
  final String name;
  final String role;
  final String email;
  final bool showDelete;

  const _TeamMember({
    required this.name,
    required this.role,
    required this.email,
    required this.showDelete,
  });
}

