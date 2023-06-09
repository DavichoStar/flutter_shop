class Product {
  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.image,
    required this.weight,
  });

  final int id;
  final String name;
  final double price;
  final String description;
  final String image;
  final String weight;
}

const products = <Product>[
  Product(
    id: 1,
    name: 'Apple',
    price: 1.59,
    description: 'Red Apple',
    image: 'assets/images/apple.png',
    weight: '1kg',
  ),
  Product(
    id: 2,
    name: 'Banana',
    price: 0.99,
    description: 'Yellow Banana',
    image: 'assets/images/banana.png',
    weight: '1kg',
  ),
  Product(
    id: 3,
    name: 'Pineapple',
    price: 2.99,
    description: 'Yellow Pineapple',
    image: 'assets/images/pineapple.png',
    weight: '1kg',
  ),
  Product(
    id: 4,
    name: 'Kiwi',
    price: 1.99,
    description: 'Green Kiwi',
    image: 'assets/images/kiwi.png',
    weight: '1kg',
  ),
  Product(
    id: 5,
    name: 'Watermelon',
    price: 1.99,
    description: 'Red Watermelon',
    image: 'assets/images/watermelon.png',
    weight: '1kg',
  ),
  Product(
    id: 6,
    name: 'Strawberry',
    price: 1.99,
    description: 'Red Strawberry',
    image: 'assets/images/strawberry.png',
    weight: '1kg',
  ),
  Product(
    id: 7,
    name: 'Grapes',
    price: 1.99,
    description: 'Purple Grapes',
    image: 'assets/images/grapes.png',
    weight: '1kg',
  ),
  Product(
    id: 8,
    name: 'Mango',
    price: 1.99,
    description: 'Yellow Mango',
    image: 'assets/images/mango.png',
    weight: '1kg',
  ),
  Product(
    id: 9,
    name: 'Lemon',
    price: 1.99,
    description: 'Yellow Lemon',
    image: 'assets/images/lemon.png',
    weight: '1kg',
  ),
  Product(
    id: 10,
    name: 'Peach',
    price: 1.99,
    description: 'Red Peach',
    image: 'assets/images/peach.png',
    weight: '1kg',
  ),
];
