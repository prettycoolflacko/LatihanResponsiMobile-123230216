class Food {
  final String name;
  final String category;
  final int price;
  final List<String> ingredients;
  final int calories;
  final String image;
  final String recipeUrl;
  final String description;

  Food({
    required this.name,
    required this.category,
    required this.price,
    required this.ingredients,
    required this.calories,
    required this.image,
    required this.recipeUrl,
    required this.description,
  });
}

List<Food> dummyFoods = [
  Food(
    name: "Nasi Goreng Spesial",
    category: "Main Course",
    price: 25000,
    ingredients: ["Nasi", "Telur", "Ayam", "Kecap"],
    calories: 550,
    image: "https://images.pexels.com/photos/19834047/pexels-photo-19834047.jpeg",
    recipeUrl: "https://cookpad.com/id/resep/12345-nasi-goreng-spesial",
    description: "Nasi goreng khas Indonesia dengan tambahan ayam dan telur, disajikan dengan bumbu spesial.",
  ),
  Food(
    name: "Sate Ayam",
    category: "Main Course",
    price: 30000,
    ingredients: ["Ayam", "Kacang", "Kecap"],
    calories: 400,
    image: "https://images.pexels.com/photos/23147806/pexels-photo-23147806.jpeg",
    recipeUrl: "https://cookpad.com/id/resep/67890-sate-ayam",
    description: "Sate ayam empuk dengan bumbu kacang gurih dan kecap manis.",
  ),
  Food(
    name: "Es Teh Manis",
    category: "Beverage",
    price: 8000,
    ingredients: ["Teh", "Gula", "Es Batu"],
    calories: 90,
    image: "https://images.pexels.com/photos/13495013/pexels-photo-13495013.jpeg",
    recipeUrl: "https://cookpad.com/id/resep/11111-es-teh-manis",
    description: "Minuman teh segar dengan gula dan es batu, cocok untuk pelepas dahaga.",
  ),
  Food(
    name: "Bakso Sapi",
    category: "Main Course",
    price: 20000,
    ingredients: ["Daging Sapi", "Tepung", "Bumbu"],
    calories: 350,
    image: "https://images.pexels.com/photos/15853315/pexels-photo-15853315.jpeg",
    recipeUrl: "https://cookpad.com/id/resep/22222-bakso-sapi",
    description: "Bakso sapi kenyal dengan kuah gurih dan bumbu khas Indonesia.",
  ),
  Food(
    name: "Rendang",
    category: "Main Course",
    price: 40000,
    ingredients: ["Daging Sapi", "Santan", "Rempah"],
    calories: 700,
    image: "https://images.pexels.com/photos/12208781/pexels-photo-12208781.jpeg",
    recipeUrl: "https://cookpad.com/id/resep/33333-rendang",
    description: "Rendang daging sapi dengan santan dan rempah-rempah khas Minang.",
  ),
  Food(
    name: "Pisang Goreng",
    category: "Snack",
    price: 15000,
    ingredients: ["Pisang", "Tepung", "Gula"],
    calories: 300,
    image: "https://images.pexels.com/photos/8118337/pexels-photo-8118337.jpeg",
    recipeUrl: "https://cookpad.com/id/resep/44444-pisang-goreng",
    description: "Pisang goreng renyah di luar, lembut di dalam, cocok untuk camilan.",
  ),
];
