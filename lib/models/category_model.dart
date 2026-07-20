class Subcategory {
  final String name;
  final String icon;

  Subcategory({
    required this.name,
    required this.icon,
  });
}

class Category {
  final String name;
  final String icon;
  final String backgroundImage;
  final List<Subcategory> subcategories;

  Category({
    required this.name,
    required this.icon,
    required this.backgroundImage,
    this.subcategories = const [],
  });
}

class Product {
  final String name;
  final String price;
  final String image;
  final String category;
  final bool isStarred;

  Product({
    required this.name,
    required this.price,
    required this.image,
    required this.category,
    this.isStarred = false,
  });
}

class Promotion {
  final String title;
  final String subtitle;
  final String buttonText;
  final String backgroundImage;
  final String backgroundColor;

  Promotion({
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.backgroundImage,
    required this.backgroundColor,
  });
}

// Mock data matching Figma screenshot
final List<Category> mockCategories = [
  Category(
    name: 'Concierge Services',
    icon: '🏢',
    backgroundImage: 'assets/category_concierge.png',
    subcategories: [
      Subcategory(name: 'Catering', icon: ''),
      Subcategory(name: 'Events', icon: ''),
      Subcategory(name: 'Office Pets', icon: ''),
      Subcategory(name: 'Wellbeing', icon: ''),
      Subcategory(name: 'Stationery', icon: ''),
      Subcategory(name: 'Hotel & Travel', icon: ''),
    ],
  ),
  Category(
    name: 'Food & Beverages',
    icon: '🍽️',
    backgroundImage: 'assets/category_food.png',
    subcategories: [
      Subcategory(name: 'Soft Drinks', icon: ''),
      Subcategory(name: 'Alcoholic Drinks', icon: ''),
      Subcategory(name: 'Hot Drinks', icon: ''),
      Subcategory(name: 'Chocolate, Sweets, Mints & Chewing Gum', icon: ''),
      Subcategory(name: 'Crisps, Nuts & Popcorn', icon: ''),
      Subcategory(name: 'Biscuits & Cereal', icon: ''),
      Subcategory(name: 'Dried Fruits, Nuts & Seeds', icon: ''),
      Subcategory(name: 'Crackers & Crispbreads', icon: ''),
      Subcategory(name: 'Fresh Food', icon: ''),
      Subcategory(name: 'Frozen Foods', icon: ''),
    ],
  ),
  Category(
    name: 'Internet & Technology',
    icon: '💻',
    backgroundImage: 'assets/category_tech.png',
    subcategories: [
      Subcategory(name: 'Internet', icon: ''),
      Subcategory(name: 'Meeting Rooms', icon: ''),
      Subcategory(name: 'Security', icon: ''),
    ],
  ),
  Category(
    name: 'Office Cleaning',
    icon: '🏢',
    backgroundImage: 'assets/category_office.png',
    subcategories: [
      Subcategory(name: 'Cleaning', icon: ''),
      Subcategory(name: 'Biophilia', icon: ''),
      Subcategory(name: 'Health & Safety', icon: ''),
      Subcategory(name: 'Repairs', icon: ''),
    ],
  ),
  Category(
    name: 'Furniture & Fitout',
    icon: '🛋️',
    backgroundImage: 'assets/category_furniture.png',
    subcategories: [
      Subcategory(name: 'Desks', icon: ''),
      Subcategory(name: 'Desk Chairs', icon: ''),
      Subcategory(name: 'Storage', icon: ''),
      Subcategory(name: 'Meeting Room Furniture', icon: ''),
      Subcategory(name: 'Desk Organisers & Accessories', icon: ''),
      Subcategory(name: 'Breakout Areas', icon: ''),
      Subcategory(name: 'Biophilia', icon: ''),
      Subcategory(name: 'Accessories', icon: ''),
    ],
  ),
  Category(
    name: 'Discounts & Partnerships',
    icon: '🤝',
    backgroundImage: 'assets/category_partners.png',
    subcategories: [
      Subcategory(name: 'Restaurants, Bars & Coffee Shops', icon: ''),
      Subcategory(name: 'Team Nights Out', icon: ''),
      Subcategory(name: 'Hotel & Travel', icon: ''),
      Subcategory(name: 'Gifting', icon: ''),
      Subcategory(name: 'Softwares', icon: ''),
      Subcategory(name: 'Health & Beauty', icon: ''),
      Subcategory(name: 'Other', icon: ''),
    ],
  ),
];

final List<Product> mockProducts = [
  Product(
    name: 'Lemon & Raspberry\nTriple Layer Cake',
    price: '£20',
    isStarred: true,
    image: 'assets/lemon.png',
    category: 'Food & Beverages',
  ),
  Product(
    name: 'Orange & Raspberry\nTriple Layer Cake',
    price: '£20',
    isStarred: true,
    image: 'assets/raspberry.png',
    category: 'Food & Beverages',
  ),
  Product(
    name: 'Lemon & Raspberry\nTriple Layer Cake',
    price: '£20',
    isStarred: true,
    image: 'assets/cake.png',
    category: 'Food & Beverages',
  ),
  Product(
    name: 'Vanilla & Berry\nTriple Layer Cake',
    price: '£20',
    isStarred: true,
    image: 'assets/lemon.png',
    category: 'Food & Beverages',
  ),
];

final List<Product> mockCateringProducts = [
  Product(
    name: 'Lemon & Raspberry\nTriple Layer Cake',
    price: '£20',
    isStarred: true,
    image: 'assets/cake.png',
    category: 'Catering',
  ),
  Product(
    name: 'Orange & Raspberry\nTriple Layer Cake',
    price: '£20',
    isStarred: true,
    image: 'assets/lemon.png',
    category: 'Catering',
  ),
  Product(
    name: 'Lemon & Raspberry\nTriple Layer Cake',
    price: '£20',
    isStarred: true,
    image: 'assets/raspberry.png',
    category: 'Catering',
  ),
  Product(
    name: 'Vanilla & Berry\nTriple Layer Cake',
    price: '£20',
    isStarred: true,
    image: 'assets/cake.png',
    category: 'Catering',
  ),
  Product(
    name: 'Strawberry Delight\nLayer Cake',
    price: '£20',
    isStarred: true,
    image: 'assets/lemon.png',
    category: 'Catering',
  ),
  Product(
    name: 'Celebration Cake\nAssortment',
    price: '£20',
    isStarred: true,
    image: 'assets/raspberry.png',
    category: 'Catering',
  ),
];

final List<Promotion> mockPromotions = [
  Promotion(
    title: 'Explore Signature Scents\nFor Your Office',
    subtitle: 'Bring a sense of calm to your workspace',
    buttonText: 'Discover Office Scents',
    backgroundImage: 'assets/scent.png',
    backgroundColor: '#C9B8A3',
  ),
  Promotion(
    title: 'New Collection Now\nAvailable',
    subtitle: 'Celebrate with our premium packages',
    buttonText: 'Shop Celebration Packages',
    backgroundImage: 'assets/gold.png',
    backgroundColor: '#2C3E50',
  ),
  Promotion(
    title: 'Premium Office\nWellness',
    subtitle: 'Transform your workspace experience',
    buttonText: 'Shop Now',
    backgroundImage: 'assets/category_furniture.png',
    backgroundColor: '#5A8A7F',
  ),
  Promotion(
    title: 'Exclusive Concierge\nServices',
    subtitle: 'Personalized assistance for your needs',
    buttonText: 'Learn More',
    backgroundImage: 'assets/category_concierge.png',
    backgroundColor: '#8B7355',
  ),
  Promotion(
    title: 'Furnish Your Space\nStylishly',
    subtitle: 'Premium furniture collection awaits',
    buttonText: 'Discover',
    backgroundImage: 'assets/category_partners.png',
    backgroundColor: '#6B8E7F',
  ),
];
