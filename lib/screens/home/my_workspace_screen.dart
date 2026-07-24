import 'package:flutter/material.dart';

import '../../config/theme.dart';
import '../../utils/responsive.dart';
import '../../widgets/app_calendar_dialog.dart';
import '../../widgets/app_header_search.dart';
import '../../widgets/app_scheduled_visits_card.dart';

class MyWorkspaceScreen extends StatefulWidget {
  final int currentNavIndex;
  final Function(int) onNavTap;

  const MyWorkspaceScreen({
    super.key,
    required this.currentNavIndex,
    required this.onNavTap,
  });

  @override
  State<MyWorkspaceScreen> createState() => _MyWorkspaceScreenState();
}

class _MyWorkspaceScreenState extends State<MyWorkspaceScreen> {
  int _selectedTab = 1; // 0: Raised, 1: In Progress, 2: Completed
  DateTime _selectedDate = DateTime(2026, 6, 22);
  bool _showScheduledVisits = false; // Hidden by default

  static const List<String> _monthNames = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  static const List<String> _weekdayShorts = [
    'Mon', 'Tue', 'Wed', 'Thur', 'Fri', 'Sat', 'Sun'
  ];

  static const List<Map<String, String>> _inProgressRequests = [
    {'title': 'Extra Cleaning Hours Needed', 'category': 'Cleaning', 'date': '12/06/2026'},
    {'title': 'Extra Cleaning Hours Needed', 'category': 'Cleaning', 'date': '12/06/2026'},
    {'title': 'Extra Cleaning Hours Needed', 'category': 'Cleaning', 'date': '12/06/2026'},
    {'title': 'Extra Cleaning Hours Needed', 'category': 'Cleaning', 'date': '12/06/2026'},
    {'title': 'Extra Cleaning Hours Needed', 'category': 'Cleaning', 'date': '12/06/2026'},
    {'title': 'Extra Cleaning Hours Needed', 'category': 'Cleaning', 'date': '12/06/2026'},
  ];

  List<DateTime> get _currentWeekDates {
    final monday = _selectedDate.subtract(Duration(days: _selectedDate.weekday - 1));
    return List.generate(7, (i) => monday.add(Duration(days: i)));
  }

  void _showCalendarDialog() async {
    final picked = await AppCalendarDialog.show(
      context,
      initialDate: _selectedDate,
      eventDates: [DateTime(2026, 6, 15)],
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _showScheduledVisits = true; // Show schedule when date selected in calendar
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final monthTitle = '${_monthNames[_selectedDate.month - 1]}, ${_selectedDate.year}';
    final weekDates = _currentWeekDates;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.05,
              vertical: 0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                const AppHeaderSearch(padding: EdgeInsets.zero),
                SizedBox(height: context.rh(18)),

                // Month & Calendar Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      monthTitle,
                      style: AppTheme.dmSans(
                        fontSize: context.rf(16),
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF1F2023),
                        height: 1.2,
                      ),
                    ),
                    GestureDetector(
                      onTap: _showCalendarDialog,
                      child: Icon(
                        Icons.calendar_month_outlined,
                        size: context.rw(20),
                        color: const Color(0xFF587B7F),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: context.rh(14)),

                // Calendar Days Strip (Dynamic 7 Days)
                SizedBox(
                  height: context.rh(72),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: weekDates.length,
                    separatorBuilder: (_, __) => SizedBox(width: context.rw(8)),
                    itemBuilder: (context, index) {
                      final date = weekDates[index];
                      final isSelected = date.year == _selectedDate.year &&
                          date.month == _selectedDate.month &&
                          date.day == _selectedDate.day;
                      final hasDot = date.day == 23; // Example event dot

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedDate = date;
                            _showScheduledVisits = true; // Show schedule when date tapped
                          });
                        },
                        child: Container(
                          width: context.rw(54),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.white : const Color(0xFF587B7F),
                            border: Border.all(
                              color: const Color(0xFF587B7F),
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${date.day}',
                                style: AppTheme.dmSans(
                                  fontSize: context.rf(18),
                                  fontWeight: FontWeight.w500,
                                  color: isSelected ? const Color(0xFF587B7F) : Colors.white,
                                  height: 1.2,
                                ),
                              ),
                              SizedBox(height: context.rh(2)),
                              Text(
                                _weekdayShorts[date.weekday - 1],
                                style: AppTheme.dmSans(
                                  fontSize: context.rf(11),
                                  fontWeight: FontWeight.w400,
                                  color: isSelected
                                      ? const Color(0xFF587B7F)
                                      : Colors.white.withValues(alpha: 0.9),
                                  height: 1.2,
                                ),
                              ),
                              if (hasDot) ...[
                                SizedBox(height: context.rh(2)),
                                Container(
                                  width: context.rw(4),
                                  height: context.rw(4),
                                  decoration: BoxDecoration(
                                    color: isSelected ? const Color(0xFF587B7F) : Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: context.rh(28)),

                // Your sub800 Requests Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Your sub800 Requests',
                      style: AppTheme.dmSans(
                        fontSize: context.rf(16),
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF1F2023),
                        height: 1.2,
                      ),
                    ),
                    Icon(
                      Icons.add_circle_outline_rounded,
                      size: context.rw(22),
                      color: const Color(0xFF587B7F),
                    ),
                  ],
                ),
                SizedBox(height: context.rh(14)),

                // Tabs: Raised | In Progress | Completed
                Row(
                  children: [
                    _buildTab(context, 'Raised', 0),
                    _buildTab(context, 'In Progress', 1),
                    _buildTab(context, 'Completed', 2),
                  ],
                ),
                Divider(height: 1, thickness: 1, color: Colors.grey[200]),
                SizedBox(height: context.rh(16)),

                // Dynamic Section: Scheduled Visits Card OR Requests List
                if (_showScheduledVisits)
                  AppScheduledVisitsCard(
                    date: _selectedDate,
                    onClose: () => setState(() => _showScheduledVisits = false),
                  )
                else
                  ..._inProgressRequests.map((req) => _buildRequestCard(context, req)),

                SizedBox(height: context.rh(24)),

                // Your Workspace Details Header
                Text(
                  'Your Workspace Details',
                  style: AppTheme.dmSans(
                    fontSize: context.rf(16),
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF1F2023),
                    height: 1.2,
                  ),
                ),
                SizedBox(height: context.rh(12)),

                // Workspace Details Card
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: context.rw(16),
                    vertical: context.rh(16),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: const Color(0xFFE8E8E8), width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '4th Floor',
                            style: AppTheme.dmSans(
                              fontSize: context.rf(10),
                              color: const Color(0xFF7A9AA0),
                              height: 1.2,
                            ),
                          ),
                          SizedBox(height: context.rh(4)),
                          Text(
                            '20-22 Vestry Street',
                            style: AppTheme.dmSans(
                              fontSize: context.rf(13),
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF1F2023),
                              height: 1.2,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'View Details',
                            style: AppTheme.dmSans(
                              fontSize: context.rf(9),
                              color: const Color(0xFF7A9AA0),
                              height: 1.2,
                            ),
                          ),
                          SizedBox(width: context.rw(4)),
                          Icon(
                            Icons.chevron_right,
                            size: context.rw(14),
                            color: const Color(0xFF7A9AA0),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: context.rh(30)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTab(BuildContext context, String label, int index) {
    final isSelected = index == _selectedTab;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: context.rh(8)),
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: AppTheme.dmSans(
                  fontSize: context.rf(12),
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected ? const Color(0xFF587B7F) : const Color(0xFF9E9E9E),
                  height: 1.2,
                ),
              ),
            ),
            Container(
              height: 2.5,
              color: isSelected ? const Color(0xFF587B7F) : Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRequestCard(BuildContext context, Map<String, String> req) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: context.rh(12)),
      padding: EdgeInsets.symmetric(
        horizontal: context.rw(14),
        vertical: context.rh(12),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE8E8E8), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  req['title']!,
                  style: AppTheme.dmSans(
                    fontSize: context.rf(12),
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF1F2023),
                    height: 1.2,
                  ),
                ),
                SizedBox(height: context.rh(3)),
                Text(
                  req['category']!,
                  style: AppTheme.dmSans(
                    fontSize: context.rf(9),
                    color: const Color(0xFF7A9AA0),
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: context.rw(10)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Date Added: ${req['date']}',
                style: AppTheme.dmSans(
                  fontSize: context.rf(8),
                  color: const Color(0xFF1F2023),
                  height: 1.2,
                ),
              ),
              SizedBox(height: context.rh(6)),
              Container(
                height: context.rh(24),
                padding: EdgeInsets.symmetric(horizontal: context.rw(12)),
                alignment: Alignment.center,
                color: const Color(0xFF587B7F),
                child: Text(
                  'Edit Details',
                  style: AppTheme.dmSans(
                    fontSize: context.rf(9),
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    height: 1.2,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
