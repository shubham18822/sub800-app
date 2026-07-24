import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../models/category_model.dart';
import '../utils/responsive.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;
  final VoidCallback? onAddTap;
  final bool isGrid;
  final bool isListRow;
  final bool showAddButton;
  final bool showFavoriteIcon;

  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
    this.onAddTap,
    this.isGrid = false,
    this.isListRow = false,
    this.showAddButton = true,
    this.showFavoriteIcon = true,
  });

  Color _parseHexColor(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    if (isListRow) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: context.rh(115),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.grey.withValues(alpha: 0.15)),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4),
                  bottomLeft: Radius.circular(4),
                ),
                child: SizedBox(
                  width: context.rw(110),
                  height: double.infinity,
                  child: Image.asset(
                    product.image,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Icon(
                          Icons.image_not_supported,
                          color: Colors.grey[400],
                        ),
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(context.rw(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTheme.dmSans(
                          fontSize: context.rf(9),
                          fontWeight: FontWeight.w400,
                          color: Colors.black87,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: const Color(0xFF6F8E95),
                            size: context.rw(9),
                          ),
                          SizedBox(width: context.rw(4)),
                          Text(
                            '5.0 Rating',
                            style: AppTheme.dmSans(
                              fontSize: context.rf(8),
                              color: Colors.black87,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            product.price,
                            style: AppTheme.dmSans(
                              fontSize: context.rf(11),
                              fontWeight: FontWeight.w500,
                              color: AppTheme.primaryTeal,
                            ),
                          ),
                        ],
                      ),
                      if (showAddButton)
                        SizedBox(
                          width: double.infinity,
                          height: context.rh(24),
                          child: ElevatedButton(
                            onPressed: onAddTap ?? () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryTeal,
                              padding: EdgeInsets.zero,
                              elevation: 0,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                            child: Text(
                              'Add',
                              style: AppTheme.dmSans(
                                fontSize: context.rf(10),
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    final cardWidth = isGrid ? double.infinity : context.rw(145);
    final imageHeight = isGrid ? context.rh(130) : context.rh(115);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: cardWidth,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 0,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Product image + Favorite heart badge
            Stack(
              children: [
                Container(
                  height: imageHeight,
                  width: isGrid ? double.infinity : context.rw(140),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0),
                    ),
                    child: Image.asset(
                      product.image,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Icon(
                            Icons.image_not_supported,
                            color: Colors.grey[400],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                if (showFavoriteIcon)
                  Positioned(
                    top: context.rh(8),
                    right: context.rw(8),
                    child: Container(
                      width: context.rw(20),
                      height: context.rw(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.85),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.favorite_border,
                        size: context.rw(12),
                        color: Colors.grey,
                      ),
                    ),
                  ),
              ],
            ),

            // Product Details
            Padding(
              padding: EdgeInsets.all(context.rw(8)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.dmSans(
                      fontSize: context.rf(8),
                      fontWeight: FontWeight.w400,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: context.rh(3)),

                  if (showAddButton) ...[
                    // Rating Row
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: const Color(0xFF6F8E95),
                          size: context.rw(8),
                        ),
                        SizedBox(width: context.rw(4)),
                        Text(
                          '5.0 Rating',
                          style: AppTheme.dmSans(
                            fontSize: context.rf(7),
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: context.rh(4)),

                    // Notice Text
                    Text(
                      'Requires 2 days notice',
                      style: AppTheme.dmSans(
                        fontSize: context.rf(7),
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: context.rh(8)),
                  ],

                  // Price & Colors row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.price,
                        style: AppTheme.dmSans(
                          fontSize: context.rf(10),
                          fontWeight: FontWeight.w500,
                          color: AppTheme.primaryTeal,
                        ),
                      ),
                      if (product.colors != null && product.colors!.isNotEmpty)
                        Row(
                          children: product.colors!.map((colorHex) {
                            return Container(
                              margin: EdgeInsets.only(left: context.rw(2)),
                              width: context.rw(8),
                              height: context.rw(8),
                              decoration: BoxDecoration(
                                color: _parseHexColor(colorHex),
                                shape: BoxShape.circle,
                              ),
                            );
                          }).toList(),
                        ),
                    ],
                  ),
                  if (showAddButton) ...[
                    SizedBox(height: context.rh(6)),
                    // Add Button
                    SizedBox(
                      width: double.infinity,
                      height: context.rh(24),
                      child: ElevatedButton(
                        onPressed: onAddTap ?? () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryTeal,
                          padding: EdgeInsets.zero,
                          elevation: 0,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                        child: Text(
                          'Add',
                          style: AppTheme.dmSans(
                            fontSize: context.rf(10),
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
