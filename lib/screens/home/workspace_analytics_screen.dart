import 'package:flutter/material.dart';

import '../../config/theme.dart';
import '../../utils/responsive.dart';
import '../../widgets/app_bottom_nav_bar.dart';
import '../../widgets/app_header_search.dart';

class WorkspaceAnalyticsScreen extends StatelessWidget {
  final int currentNavIndex;
  final Function(int) onNavTap;

  const WorkspaceAnalyticsScreen({
    super.key,
    required this.currentNavIndex,
    required this.onNavTap,
  });

  static const List<_MetricData> _topMetrics = [
    _MetricData(
      title: 'Spending',
      value: '£12,000',
      indicatorColor: Color(0xFF5F7F82),
    ),
    _MetricData(
      title: 'Cost Savings',
      value: '£,1450',
      indicatorColor: Color(0xFFC39A77),
    ),
    _MetricData(
      title: 'Most purchased item',
      value: 'Sushi Platter',
      indicatorColor: Color(0xFF8F8A76),
      isHeadlineValue: false,
    ),
    _MetricData(
      title: 'Total Suppliers Used',
      value: '12',
      indicatorColor: Color(0xFFE2D6CB),
    ),
  ];

  static const List<_MetricData> _bottomMetrics = [
    _MetricData(
      title: 'Average Order Value',
      value: '£100',
      indicatorColor: Color(0xFF5F7F82),
    ),
    _MetricData(
      title: 'Number of Orders',
      value: '3',
      indicatorColor: Color(0xFFC39A77),
    ),
    _MetricData(
      title: 'Items Viewed',
      value: '92',
      indicatorColor: Color(0xFF8F8A76),
    ),
    _MetricData(
      title: 'Team Members',
      value: '8',
      indicatorColor: Color(0xFFE2D6CB),
    ),
  ];

  static const List<_BarData> _spendingData = [
    _BarData(label: 'Concierge', value: 320),
    _BarData(label: 'F&B', value: 390),
    _BarData(label: 'Technology', value: 240),
    _BarData(label: 'Office', value: 290),
    _BarData(label: 'Furniture', value: 360),
    _BarData(label: 'Other', value: 360),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            // padding: EdgeInsets.symmetric(horizontal: context.rw(12)),
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
                _buildMetricGrid(context, _topMetrics),
                SizedBox(height: context.rh(16)),
                _buildSpendingChartCard(context),
                SizedBox(height: context.rh(14)),
                _buildMetricGrid(context, _bottomMetrics),
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

  Widget _buildMetricGrid(BuildContext context, List<_MetricData> metrics) {
    return Column(
      children: [
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: _buildMetricTile(context, metrics[0])),
              SizedBox(width: context.rw(10)),
              Expanded(child: _buildMetricTile(context, metrics[1])),
            ],
          ),
        ),
        SizedBox(height: context.rh(10)),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: _buildMetricTile(context, metrics[2])),
              SizedBox(width: context.rw(10)),
              Expanded(child: _buildMetricTile(context, metrics[3])),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMetricTile(
    BuildContext context,
    _MetricData metric,
  ) {
    return Container(
      constraints: BoxConstraints(minHeight: context.rh(88)),
      padding: EdgeInsets.symmetric(
        horizontal: context.rw(12),
        vertical: context.rh(12),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE8E8E8), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.29),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: context.rw(14),
                height: context.rw(14),
                color: metric.indicatorColor,
              ),
              SizedBox(width: context.rw(8)),
              Expanded(
                child: Text(
                  metric.title,
                  style: AppTheme.dmSans(
                    fontSize: context.rf(9),
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF2E2E2E),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: context.rh(8)),
          Text(
            metric.value,
            style: AppTheme.dmSans(
              fontSize: context.rf(metric.isHeadlineValue ? 28 / 2 : 25 / 2),
              fontWeight: metric.isHeadlineValue
                  ? FontWeight.w500
                  : FontWeight.w400,
              color: const Color(0xFF111111),
            ),
          ),
          SizedBox(height: context.rh(8)),
          Row(
            children: [
              Container(
                width: context.rw(9),
                height: context.rw(9),
                decoration: const BoxDecoration(
                  color: Color(0xFF9A8F79),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_upward,
                  size: context.rw(6),
                  color: Colors.white,
                ),
              ),
              SizedBox(width: context.rw(4)),
              Text(
                '202%',
                style: AppTheme.dmSans(
                  fontSize: context.rf(7),
                  color: const Color(0xFFB0A48F),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSpendingChartCard(BuildContext context) {
    const maxValue = 400.0;
    final chartHeight = context.rh(160);
    final drawableBarHeight = context.rh(102);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: context.rw(12),
        vertical: context.rh(12),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Spending by Categories',
            style: AppTheme.dmSans(
              fontSize: context.rf(11),
              fontWeight: FontWeight.w400,
              color: const Color(0xFF222222),
            ),
          ),
          SizedBox(height: context.rh(10)),
          SizedBox(
            height: chartHeight,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: context.rw(24),
                  child: _buildChartAxis(context),
                ),
                SizedBox(width: context.rw(10)),
                Expanded(
                  child: Stack(
                    children: [
                      Positioned(
                        top: context.rh(8),
                        left: 0,
                        right: 0,
                        child: Column(
                          children: [
                            _buildHorizontalGuide(context),
                            SizedBox(height: drawableBarHeight / 4),
                            _buildHorizontalGuide(context),
                            SizedBox(height: drawableBarHeight / 4),
                            _buildHorizontalGuide(context),
                            SizedBox(height: drawableBarHeight / 4),
                            _buildHorizontalGuide(context),
                            SizedBox(height: drawableBarHeight / 4),
                            _buildHorizontalGuide(context),
                          ],
                        ),
                      ),
                      Positioned.fill(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: _spendingData.map((bar) {
                            final barHeight =
                                (bar.value / maxValue) * drawableBarHeight;
                            return Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(height: context.rh(8)),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        width: context.rw(10),
                                        height: barHeight,
                                        color: const Color(0xFF5F7F82),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: context.rh(12)),
                                  SizedBox(
                                    width: context.rw(48),
                                    child: Text(
                                      bar.label,
                                      maxLines: 2,
                                      overflow: TextOverflow.visible,
                                      textAlign: TextAlign.center,
                                      style: AppTheme.dmSans(
                                        fontSize: context.rf(6.8),
                                        color: const Color(0xFF2E2E2E),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAxisLabel(BuildContext context, String label) {
    return Text(
      label,
      style: AppTheme.dmSans(
        fontSize: context.rf(7.5),
        color: const Color(0xFF2E2E2E),
      ),
    );
  }

  Widget _buildChartAxis(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: context.rh(1), bottom: context.rh(32)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAxisLabel(context, '400'),
          _buildAxisLabel(context, '300'),
          _buildAxisLabel(context, '200'),
          _buildAxisLabel(context, '100'),
        ],
      ),
    );
  }

  Widget _buildHorizontalGuide(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 1,
      color: const Color(0xFFE3DDD7),
    );
  }
}

class _MetricData {
  final String title;
  final String value;
  final Color indicatorColor;
  final bool isHeadlineValue;

  const _MetricData({
    required this.title,
    required this.value,
    required this.indicatorColor,
    this.isHeadlineValue = true,
  });
}

class _BarData {
  final String label;
  final double value;

  const _BarData({required this.label, required this.value});
}
