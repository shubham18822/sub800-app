import 'package:flutter/material.dart';

import '../../config/theme.dart';
import '../../models/category_model.dart';
import '../../utils/responsive.dart';
import '../../widgets/app_bottom_nav_bar.dart';
import '../../widgets/app_header_search.dart';
import '../../widgets/product_card.dart';
import 'package:sub800_app/screens/home/product_detail_screen.dart';


class ProductBrowsingScreen extends StatefulWidget {
  final String title;
  final String resultsText;
  final List<Product> products;
  final int currentNavIndex;
  final Function(int) onNavTap;

  const ProductBrowsingScreen({
    super.key,
    required this.title,
    required this.resultsText,
    required this.products,
    required this.currentNavIndex,
    required this.onNavTap,
  });

  @override
  State<ProductBrowsingScreen> createState() => _ProductBrowsingScreenState();
}

class _ProductBrowsingScreenState extends State<ProductBrowsingScreen> {
  bool _isGridMode = true;
  RangeValues _priceRange = const RangeValues(1, 100);
  final Set<String> _selectedDietary = {};
  int _selectedRating = 3;

  void _showFilterSheet() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return _FilterBottomSheet(
          initialPriceRange: _priceRange,
          initialDietary: _selectedDietary,
          initialRating: _selectedRating,
          onChanged: (priceRange, dietary, rating) {
            setState(() {
              _priceRange = priceRange;
              _selectedDietary
                ..clear()
                ..addAll(dietary);
              _selectedRating = rating;
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppHeaderSearch(),
            Padding(
              padding: EdgeInsets.only(left: size.width * 0.04, bottom: 4),
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: const Icon(
                  // Keep touch target compact while scaling icon for smaller phones.
                  Icons.chevron_left_rounded,
                  size: 24,
                  // color: Colors.black54,
                  color: Color(0xFF587B7F),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      widget.title,
                      style: AppTheme.newsreader(
                        fontSize: context.rf(18),
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w400,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: context.rh(4)),
                    Text(
                      widget.resultsText,
                      style: AppTheme.dmSans(
                        fontSize: context.rf(10),
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[500] ?? Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                children: [
                  _chip(
                    context: context,
                    icon: Icons.tune_rounded,
                    label: 'Filter',
                    onTap: _showFilterSheet,
                  ),
                  const SizedBox(width: 12),
                  _chip(
                    context: context,
                    icon: Icons.keyboard_arrow_down_rounded,
                    label: 'Sort',
                  ),
                  const Spacer(),
                  _iconButton(
                    context,
                    _isGridMode ? Icons.view_agenda_rounded : Icons.grid_view_rounded,
                    isSelected: false,
                    onTap: () {
                      setState(() {
                        _isGridMode = !_isGridMode;
                      });
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  if (!_isGridMode) {
                    return ListView.separated(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.rw(12),
                        vertical: context.rh(4),
                      ),
                      itemCount: widget.products.length,
                      separatorBuilder: (_, __) => SizedBox(height: context.rh(12)),
                      itemBuilder: (context, index) {
                        final product = widget.products[index];
                        return ProductCard(
                          product: product,
                          isGrid: false,
                          isListRow: true,
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => ProductDetailScreen(
                                  product: product,
                                  currentNavIndex: widget.currentNavIndex,
                                  onNavTap: widget.onNavTap,
                                  relatedProducts: widget.products,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  }

                  final crossAxisCount = constraints.maxWidth < 330 ? 1 : 2;
                  final spacing = context.rw(12);
                  final cardWidth =
                      (constraints.maxWidth -
                          ((crossAxisCount - 1) * spacing)) /
                      crossAxisCount;
                  final childAspectRatio = cardWidth / context.rh(280);

                  return GridView.builder(
                    padding: EdgeInsets.symmetric(horizontal: context.rw(12)),
                    itemCount: widget.products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: spacing,
                      mainAxisSpacing: spacing,
                      childAspectRatio: childAspectRatio,
                    ),
                    itemBuilder: (context, index) {
                      final product = widget.products[index];
                      return ProductCard(
                        product: product,
                        isGrid: true,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => ProductDetailScreen(
                                product: product,
                                currentNavIndex: widget.currentNavIndex,
                                onNavTap: widget.onNavTap,
                                relatedProducts: widget.products,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: widget.currentNavIndex,
        onTap: (i) {
          widget.onNavTap(i);
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
      ),
    );
  }

  Widget _chip({
    required BuildContext context,
    required IconData icon,
    required String label,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.rw(10),
          vertical: context.rh(6),
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: context.rw(14), color: Colors.black54),
            SizedBox(width: context.rw(4)),
            Text(
              label,
              style: AppTheme.dmSans(
                fontSize: context.rf(10),
                fontWeight: FontWeight.w400,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _iconButton(
    BuildContext context,
    IconData icon, {
    bool isSelected = false,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: context.rw(28),
        height: context.rw(28),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF587B7F).withValues(alpha: 0.15)
              : Colors.transparent,
          border: Border.all(
            color: isSelected
                ? const Color(0xFF587B7F)
                : Colors.grey.withValues(alpha: 0.2),
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Icon(
          icon,
          size: context.rw(16),
          color: isSelected ? const Color(0xFF587B7F) : Colors.black54,
        ),
      ),
    );
  }


}

class _FilterBottomSheet extends StatefulWidget {
  final RangeValues initialPriceRange;
  final Set<String> initialDietary;
  final int initialRating;
  final void Function(RangeValues priceRange, Set<String> dietary, int rating)
  onChanged;

  const _FilterBottomSheet({
    required this.initialPriceRange,
    required this.initialDietary,
    required this.initialRating,
    required this.onChanged,
  });

  @override
  State<_FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<_FilterBottomSheet> {
  static const List<String> _dietaryOptions = [
    'Nuts',
    'Milk',
    'Gluten',
    'Meat',
    'Eggs',
  ];

  late RangeValues _priceRange;
  late Set<String> _selectedDietary;
  late int _selectedRating;

  @override
  void initState() {
    super.initState();
    _priceRange = widget.initialPriceRange;
    _selectedDietary = {...widget.initialDietary};
    _selectedRating = widget.initialRating;
  }

  void _emitChanges() {
    widget.onChanged(_priceRange, _selectedDietary, _selectedRating);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.48,
      padding: EdgeInsets.fromLTRB(
        context.rw(16),
          context.rh(16),
          context.rw(16),
          context.rh(18),
        ),
        color: AppTheme.appTheme,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Filter',
                  style: AppTheme.dmSans(
                    fontSize: context.rf(26),
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: context.rw(24),
                  ),
                ),
              ],
            ),
            SizedBox(height: context.rh(22)),
            Text(
              'Price Range',
              style: AppTheme.dmSans(
                fontSize: context.rf(12),
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
            SizedBox(height: context.rh(10)),
            Row(
              children: [
                Text(
                  '£${_priceRange.start.round()}',
                  style: AppTheme.dmSans(
                    fontSize: context.rf(12),
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                Text(
                  '£${_priceRange.end.round()}',
                  style: AppTheme.dmSans(
                    fontSize: context.rf(12),
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: Colors.white,
                inactiveTrackColor: Colors.white.withValues(alpha: 0.42),
                thumbColor: Colors.white,
                overlayColor: Colors.white.withValues(alpha: 0.1),
                trackHeight: 2.5,
                rangeThumbShape: RoundRangeSliderThumbShape(
                  enabledThumbRadius: context.rw(5),
                ),
              ),
              child: RangeSlider(
                values: _priceRange,
                min: 1,
                max: 100,
                divisions: 99,
                onChanged: (values) {
                  setState(() => _priceRange = values);
                  _emitChanges();
                },
              ),
            ),
            SizedBox(height: context.rh(12)),
            Text(
              'Allergens/Dietary Requirements',
              style: AppTheme.dmSans(
                fontSize: context.rf(12),
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
            SizedBox(height: context.rh(10)),
            Wrap(
              spacing: context.rw(8),
              runSpacing: context.rh(8),
              children: _dietaryOptions.map((option) {
                final isSelected = _selectedDietary.contains(option);
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        _selectedDietary.remove(option);
                      } else {
                        _selectedDietary.add(option);
                      }
                    });
                    _emitChanges();
                  },
                  child: Container(
                    width: context.rw(58),
                    height: context.rh(22),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.white.withValues(alpha: 0.18)
                          : Colors.transparent,
                      border: Border.all(color: Colors.white),
                    ),
                    child: Text(
                      option,
                      style: AppTheme.dmSans(
                        fontSize: context.rf(10),
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: context.rh(18)),
            Text(
              'Product Rankings',
              style: AppTheme.dmSans(
                fontSize: context.rf(12),
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
            SizedBox(height: context.rh(10)),
            Row(
              children: List.generate(5, (index) {
                final starNumber = index + 1;
                final isActive = starNumber <= _selectedRating;
                return GestureDetector(
                  onTap: () {
                    setState(() => _selectedRating = starNumber);
                    _emitChanges();
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: context.rw(4)),
                    child: Icon(
                      Icons.star,
                      color: isActive
                          ? Colors.white
                          : Colors.white.withValues(alpha: 0.52),
                      size: context.rw(18),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
    );
  }
}
