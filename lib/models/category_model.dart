class Category {
  final String name;
  final String icon;
  final String backgroundImage;

  Category({
    required this.name,
    required this.icon,
    required this.backgroundImage,
  });
}

class Product {
  final String name;
  final String price;
  final String image;
  final String category;

  Product({
    required this.name,
    required this.price,
    required this.image,
    required this.category,
  });
}

// Mock data matching Figma screenshot
final List<Category> mockCategories = [
  Category(name: 'Concierge', icon: '🏢', backgroundImage: 'assets/category_concierge.png'),
  Category(name: 'Food &\nBeverages', icon: '🍽️', backgroundImage: 'assets/category_food.png'),
  Category(name: 'Internet &\nTechnology', icon: '💻', backgroundImage: 'assets/category_tech.png'),
  Category(name: 'Office\nKeeping', icon: '🏢', backgroundImage: 'assets/category_office.png'),
  Category(name: 'Furniture &\nFit-Out', icon: '🛋️', backgroundImage: 'assets/category_furniture.png'),
  Category(name: 'Partnerships', icon: '🤝', backgroundImage: 'assets/category_partners.png'),
];

final List<Product> mockProducts = [
  Product(
    name: 'Lemon & Raspberry\nTriple Layer Cake',
    price: '£20',
    image: 'assets/lemon.png',
    category: 'Food & Beverages',
  ),
  Product(
    name: 'Orange & Raspberry\nTriple Layer Cake',
    price: '£20',
    image: 'assets/raspberry.png',
    category: 'Food & Beverages',
  ),
  Product(
    name: 'Lemon & Raspberry\nTriple Layer Cake',
    price: '£20',
    image: 'assets/cake.png',
    category: 'Food & Beverages',
  ),
  Product(
    name: 'Vanilla & Berry\nTriple Layer Cake',
    price: '£20',
    image: 'https://via.placeholder.com/180x130?text=Cake+4',
    category: 'Food & Beverages',
  ),
];

