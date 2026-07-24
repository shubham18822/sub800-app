import 'package:flutter/material.dart';

import '../../config/routes.dart';
import '../../config/theme.dart';
import '../../models/category_model.dart';
import '../../utils/responsive.dart';
import '../../widgets/app_bottom_nav_bar.dart';
import '../../widgets/app_header_search.dart';
import '../../widgets/product_card.dart';


class ProductDetailScreen extends StatefulWidget {
  final Product product;
  final int currentNavIndex;
  final Function(int) onNavTap;
  final List<Product> relatedProducts;

  const ProductDetailScreen({
    super.key,
    required this.product,
    required this.currentNavIndex,
    required this.onNavTap,
    required this.relatedProducts,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late final PageController _pageController;
  int _activeImageIndex = 0;

  bool _allergensExpanded = false;
  bool _deliveryExpanded = false;
  bool _storageExpanded = false;

  late final List<String> _carouselImages;
  int? _selectedColorIndex = 0; // Track selected color

  CartItem? _getCartItem() {
    try {
      return globalCart.firstWhere(
        (item) => item.product.name == widget.product.name,
      );
    } catch (e) {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _carouselImages = _buildCarouselImages();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  List<String> _buildCarouselImages() {
    final source = <String>[widget.product.image];

    for (final item in widget.relatedProducts) {
      if (!source.contains(item.image)) {
        source.add(item.image);
      }
    }

    if (source.isEmpty) {
      source.add(widget.product.image);
    }

    final images = <String>[];
    for (var i = 0; i < 5; i++) {
      images.add(source[i % source.length]);
    }
    return images;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppHeaderSearch(),
              Padding(
                padding: EdgeInsets.only(left: context.rw(12), bottom: context.rh(8)),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Icon(
                    Icons.chevron_left_rounded,
                    size: context.rw(24),
                    color: const Color(0xFF587B7F),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: context.rw(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: context.rh(345),
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: _carouselImages.length,
                        onPageChanged: (index) {
                          setState(() => _activeImageIndex = index);
                        },
                        itemBuilder: (context, index) {
                          return Image.asset(
                            _carouselImages[index],
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Center(
                                child: Icon(
                                  Icons.image_not_supported,
                                  color: Colors.grey[400],
                                  size: context.rw(26),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    SizedBox(height: context.rh(10)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(_carouselImages.length, (index) {
                        final isActive = index == _activeImageIndex;
                        return Container(
                          width: isActive ? context.rw(10) : context.rw(8),
                          height: context.rw(8),
                          margin: EdgeInsets.symmetric(horizontal: context.rw(3)),
                          decoration: BoxDecoration(
                            color: isActive ? const Color(0xFF5D7F84) : const Color(0xFFC0C5C8),
                            shape: BoxShape.circle,
                          ),
                        );
                      }),
                    ),
                    SizedBox(height: context.rh(18)),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Victoria Sponge Cake',
                            style: AppTheme.dmSans(
                              fontSize: context.rf(24),
                              color: const Color(0xFF1F2023),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.favorite_border,
                          color: const Color(0xFF5D6062),
                          size: context.rw(20),
                        ),
                      ],
                    ),
                    SizedBox(height: context.rh(8)),
                    Text(
                      widget.product.price,
                      style: AppTheme.dmSans(
                        fontSize: context.rf(30),
                        color: const Color(0xFF1F2023),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: context.rh(6)),
                    Text(
                      'Serving Numbers: 12',
                      style: AppTheme.dmSans(
                        fontSize: context.rf(12),
                        color: const Color(0xFF1F2023),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    if (widget.product.colors != null && widget.product.colors!.isNotEmpty)
                      ...[
                        SizedBox(height: context.rh(16)),
                        Row(
                          children: List.generate(widget.product.colors!.length, (index) {
                            final colorHex = widget.product.colors![index];
                            final isSelected = index == _selectedColorIndex;
                            return GestureDetector(
                              onTap: () {
                                setState(() => _selectedColorIndex = index);
                              },
                              child: Container(
                                width: context.rw(28),
                                height: context.rw(28),
                                margin: EdgeInsets.only(right: context.rw(8)),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(int.parse('0xff${colorHex.replaceFirst('#', '')}')),
                                  border: isSelected
                                      ? Border.all(
                                          color: Colors.black,
                                          width: 2,
                                        )
                                      : Border.all(
                                          color: Colors.grey[300] ?? Colors.grey,
                                          width: 1,
                                        ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ],
                    SizedBox(height: context.rh(20)),
                    SizedBox(
                      width: double.infinity,
                      height: context.rh(36),
                      child: _getCartItem() == null
                          ? ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  globalCart.add(CartItem(product: widget.product, quantity: 1));
                                });
                                notifyCartChanged();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('${widget.product.name} added to basket'),
                                    duration: const Duration(seconds: 1),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF587B7F),
                                padding: EdgeInsets.zero,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                ),
                                elevation: 2,
                              ),
                              child: Text(
                                'Add to Basket',
                                style: AppTheme.dmSans(
                                  fontSize: context.rf(13),
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        final cartItem = _getCartItem();
                                        if (cartItem != null && cartItem.quantity > 0) {
                                          cartItem.quantity--;
                                          if (cartItem.quantity == 0) {
                                            globalCart.remove(cartItem);
                                          }
                                        }
                                      });
                                      notifyCartChanged();
                                    },
                                    child: Container(
                                      color: const Color(0xFF587B7F),
                                      alignment: Alignment.center,
                                      child: Text(
                                        '−',
                                        style: AppTheme.dmSans(
                                          fontSize: context.rf(20),
                                          color: Colors.white,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: context.rw(84),
                                  color: Colors.white,
                                  alignment: Alignment.center,
                                  child: Text(
                                    '${_getCartItem()?.quantity ?? 0}',
                                    style: AppTheme.dmSans(
                                      fontSize: context.rf(15),
                                      color: const Color(0xFF1F2023),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        final cartItem = _getCartItem();
                                        if (cartItem != null) {
                                          cartItem.quantity++;
                                        }
                                      });
                                      notifyCartChanged();
                                    },
                                    child: Container(
                                      color: const Color(0xFF587B7F),
                                      alignment: Alignment.center,
                                      child: Text(
                                        '+',
                                        style: AppTheme.dmSans(
                                          fontSize: context.rf(20),
                                          color: Colors.white,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ),
                    SizedBox(height: context.rh(20)),
                    Text(
                      'With three layers of light, fluffy sponge, and filled with smooth Madagascan vanilla buttercream and sweet seeded strawberry jam, this cake is perfect for sharing. Finished with a delicate dusting of fine sugar for a touch of elegance, it comes pre-sliced for convenience, and serves up to 14. To enjoy this cake at its best we recommend serving at room temperature.',
                      style: AppTheme.dmSans(
                        fontSize: context.rf(11),
                        color: const Color(0xFF1F2023),
                        height: 1.35,
                      ),
                    ),
                    SizedBox(height: context.rh(14)),
                    Text(
                      'x1 Victoria Sponge Cake with Raspberry Jam',
                      style: AppTheme.dmSans(
                        fontSize: context.rf(11),
                        color: const Color(0xFF1F2023),
                      ),
                    ),
                    SizedBox(height: context.rh(12)),
                    _buildAccordion(
                      title: 'Allergens',
                      expanded: _allergensExpanded,
                      content: 'Contains: Wheat (gluten), eggs, milk. May contain traces of nuts.',
                      onTap: () {
                        setState(() => _allergensExpanded = !_allergensExpanded);
                      },
                    ),
                    _buildAccordion(
                      title: 'Delivery and Returns',
                      expanded: _deliveryExpanded,
                      content: 'Requires 2 days notice. Non-refundable once prepared.',
                      onTap: () {
                        setState(() => _deliveryExpanded = !_deliveryExpanded);
                      },
                    ),
                    _buildAccordion(
                      title: 'Serving and Storage Advice',
                      expanded: _storageExpanded,
                      content: 'Best enjoyed at room temperature. Store chilled and consume within 48 hours.',
                      onTap: () {
                        setState(() => _storageExpanded = !_storageExpanded);
                      },
                    ),
                    SizedBox(height: context.rh(20)),
                    Row(
                      children: List.generate(5, (index) {
                        final isFilled = index < 4;
                        return Padding(
                          padding: EdgeInsets.only(right: context.rw(2)),
                          child: Icon(
                            Icons.star,
                            size: context.rw(16),
                            color: isFilled ? const Color(0xFF587B7F) : const Color(0xFFC2C6C9),
                          ),
                        );
                      }),
                    ),
                    SizedBox(height: context.rh(10)),
                    Text(
                      'So fluffy, went down a treat!',
                      style: AppTheme.dmSans(
                        fontSize: context.rf(16),
                        color: const Color(0xFF1F2023),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: context.rh(8)),
                    Text(
                      'With three layers of light, fluffy sponge, and filled with smooth Madagascan vanilla buttercream and sweet seeded strawberry jam, this cake is perfect for sharing. Finished with a delicate dusting of fine sugar for a touch of elegance, it comes pre-sliced for convenience, and serves up to 14. To enjoy this cake at its best we recommend serving at room temperature.',
                      style: AppTheme.dmSans(
                        fontSize: context.rf(12),
                        color: const Color(0xFF1F2023),
                        height: 1.35,
                      ),
                    ),
                    SizedBox(height: context.rh(16)),
                    Center(
                      child: Container(
                        width: context.rw(195),
                        height: context.rh(26),
                        alignment: Alignment.center,
                        color: const Color(0xFFB68460),
                        child: Text(
                          'See More Reviews',
                          style: AppTheme.dmSans(
                            fontSize: context.rf(14),
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: context.rh(30)),
                    Text(
                      "We Think You'll Like...",
                      style: AppTheme.dmSans(
                        fontSize: context.rf(25),
                        color: const Color(0xFF1F2023),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: context.rh(12)),
                    _buildProductScroller(widget.relatedProducts),
                    SizedBox(height: context.rh(25)),
                    Text(
                      'Recently Viewed',
                      style: AppTheme.dmSans(
                        fontSize: context.rf(25),
                        color: const Color(0xFF1F2023),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: context.rh(12)),
                    _buildProductScroller(widget.relatedProducts.reversed.toList()),
                    SizedBox(height: context.rh(22)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: widget.currentNavIndex,
        onTap: (i) {
          widget.onNavTap(i);
          Navigator.of(context).popUntil(ModalRoute.withName(Routes.home));
        },
      ),
    );
  }

  Widget _buildAccordion({
    required String title,
    required bool expanded,
    required String content,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: context.rh(10)),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: AppTheme.dmSans(
                      fontSize: context.rf(15),
                      color: const Color(0xFF1F2023),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Icon(
                  expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  size: context.rw(18),
                  color: const Color(0xFF1F2023),
                ),
              ],
            ),
          ),
        ),
        Divider(height: 1, thickness: 1, color: const Color(0xFF1F2023)),
        if (expanded)
          Padding(
            padding: EdgeInsets.only(top: context.rh(8), bottom: context.rh(12)),
            child: Text(
              content,
              style: AppTheme.dmSans(
                fontSize: context.rf(11),
                color: const Color(0xFF1F2023),
                height: 1.35,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildProductScroller(List<Product> products) {
    return SizedBox(
      height: context.rh(180),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        separatorBuilder: (_, __) => SizedBox(width: context.rw(12)),
        itemBuilder: (context, index) {
          final product = products[index];
          return ProductCard(
            product: product,
            showAddButton: false,
            showFavoriteIcon: false,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ProductDetailScreen(
                    product: product,
                    currentNavIndex: widget.currentNavIndex,
                    onNavTap: widget.onNavTap,
                    relatedProducts: products,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

}

