class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final String brand;
  final String category;
  final String thumbnail;
  final List<String> images;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.category,
    required this.thumbnail,
    required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'].toDouble(),
      discountPercentage: json['discountPercentage'].toDouble(),
      rating: json['rating'].toDouble(),
      stock: json['stock'],
      brand: json['brand'],
      category: json['category'],
      thumbnail: json['thumbnail'],
      images: List<String>.from(json['images']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'discountPercentage': discountPercentage,
      'rating': rating,
      'stock': stock,
      'brand': brand,
      'category': category,
      'thumbnail': thumbnail,
      'images': images,
    };
  }
  
  // Future<void> addProductsFromAPI() async {
  //   try {
  //     // Make an HTTP request to fetch the API data
  //     final response =
  //         await http.get(Uri.parse('https://api.example.com/products'));

  //     // Check if the request was successful
  //     if (response.statusCode == 200) {
  //       // Parse the JSON data
  //       final jsonData = jsonDecode(response.body);

  //       // Get the collection reference for 'products' in Firestore
  //       final productsCollection =
  //           FirebaseFirestore.instance.collection('products');

  //       // Loop through the products and add them to Firestore
  //       for (var productData in jsonData) {
  //         // Create a Product object from the API data
  //         Product product = Product.fromJson(productData);

  //         // Convert the Product object to a JSON map
  //         Map<String, dynamic> productJson = product.toJson();

  //         // Add the product to Firestore using the collection reference
  //         await productsCollection.add(productJson);
  //       }

  //       print('Products added successfully');
  //     } else {
  //       print('Failed to fetch API data. Status code: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //   }
  // }
}
