class FoodMenu {
  String name;
  String category;
  String description;
  String ingredients;
  String cookingTime;
  String price;
  String imageAsset;
  List<String> imageUrls;

  FoodMenu({
    required this.name,
    required this.category,
    required this.description,
    required this.ingredients,
    required this.cookingTime,
    required this.price,
    required this.imageAsset,
    required this.imageUrls,
  });
}

var foodMenuList = [
  FoodMenu(
    name: 'Nasi Goreng',
    category: 'Main Course',
    description: 'Nasi goreng khas Indonesia yang dimasak dengan bumbu rempah-rempah, telur, ayam, dan sayuran.',
    ingredients: 'Nasi, telur, ayam, bawang putih, bawang merah, kecap manis, garam, cabai',
    cookingTime: '15 minutes',
    price: 'Rp 20000',
    imageAsset: 'images/nasi-goreng.jpg',
    imageUrls: [
      'https://www.resepmakansedap.com/images/nasi-goreng.jpg',
      'https://www.example.com/nasi-goreng-2.jpg',
      'https://www.example.com/nasi-goreng-3.jpg',
    ],
  ),
  FoodMenu(
    name: 'Sate Ayam',
    category: 'Main Course',
    description: 'Sate ayam yang dipanggang dengan bumbu kacang dan kecap manis.',
    ingredients: 'Daging ayam, bumbu kacang, kecap manis, bawang merah, cabai, tomat',
    cookingTime: '20 minutes',
    price: 'Rp 25000',
    imageAsset: 'images/sate-ayam.jpg',
    imageUrls: [
      'https://www.resepmakansedap.com/images/sate-ayam.jpg',
      'https://www.example.com/sate-ayam-2.jpg',
      'https://www.example.com/sate-ayam-3.jpg',
    ],
  ),
  FoodMenu(
    name: 'Gado-Gado',
    category: 'Salad',
    description: 'Sayur-sayuran yang disiram dengan bumbu kacang, disajikan dengan lontong dan kerupuk.',
    ingredients: 'Tauge, bayam, kacang panjang, kentang, tahu, bumbu kacang, kerupuk',
    cookingTime: '25 minutes',
    price: 'Rp 15000',
    imageAsset: 'images/gado-gado.jpg',
    imageUrls: [
      'https://www.resepmakansedap.com/images/gado-gado.jpg',
      'https://www.example.com/gado-gado-2.jpg',
      'https://www.example.com/gado-gado-3.jpg',
    ],
  ),
  FoodMenu(
    name: 'Bakso',
    category: 'Soup',
    description: 'Bakso sapi yang disajikan dengan kuah kaldu hangat, mi, tahu, dan sayuran.',
    ingredients: 'Daging sapi, tepung tapioka, bawang putih, garam, mi, sayuran',
    cookingTime: '30 minutes',
    price: 'Rp 18000',
    imageAsset: 'images/bakso.jpg',
    imageUrls: [
      'https://www.resepmakansedap.com/images/bakso.jpg',
      'https://www.example.com/bakso-2.jpg',
      'https://www.example.com/bakso-3.jpg',
    ],
  ),
  FoodMenu(
    name: 'Rendang',
    category: 'Main Course',
    description: 'Daging sapi yang dimasak lama dengan bumbu rempah dan santan hingga empuk dan kaya rasa.',
    ingredients: 'Daging sapi, santan, lengkuas, serai, daun jeruk, cabai, bawang putih, bawang merah',
    cookingTime: '2 hours',
    price: 'Rp 40000',
    imageAsset: 'images/rendang.jpg',
    imageUrls: [
      'https://www.resepmakansedap.com/images/rendang.jpg',
      'https://www.example.com/rendang-2.jpg',
      'https://www.example.com/rendang-3.jpg',
    ],
  ),
  FoodMenu(
    name: 'Soto Ayam',
    category: 'Soup',
    description: 'Soto ayam khas Indonesia dengan kuah bening, daging ayam suwir, dan tambahan telur rebus serta sayuran.',
    ingredients: 'Daging ayam, bawang putih, bawang merah, daun salam, serai, telur, lontong',
    cookingTime: '45 minutes',
    price: 'Rp 22000',
    imageAsset: 'images/soto-ayam.jpg',
    imageUrls: [
      'https://www.resepmakansedap.com/images/soto-ayam.jpg',
      'https://www.example.com/soto-ayam-2.jpg',
      'https://www.example.com/soto-ayam-3.jpg',
    ],
  ),
  FoodMenu(
    name: 'Mie Ayam',
    category: 'Main Course',
    description: 'Mie dengan topping ayam cincang, sawi, dan kuah kaldu yang gurih.',
    ingredients: 'Mie, daging ayam, kecap, bawang putih, sawi, kaldu ayam',
    cookingTime: '20 minutes',
    price: 'Rp 15000',
    imageAsset: 'images/mie-ayam.jpg',
    imageUrls: [
      'https://www.resepmakansedap.com/images/mie-ayam.jpg',
      'https://www.example.com/mie-ayam-2.jpg',
      'https://www.example.com/mie-ayam-3.jpg',
    ],
  ),
  FoodMenu(
    name: 'Es Campur',
    category: 'Dessert',
    description: 'Es campur segar dengan campuran buah-buahan, cincau, agar-agar, dan santan.',
    ingredients: 'Buah-buahan, cincau, agar-agar, susu kental manis, sirup, es batu',
    cookingTime: '10 minutes',
    price: 'Rp 12000',
    imageAsset: 'images/es-campur.jpg',
    imageUrls: [
      'https://www.resepmakansedap.com/images/es-campur.jpg',
      'https://www.example.com/es-campur-2.jpg',
      'https://www.example.com/es-campur-3.jpg',
    ],
  ),
  FoodMenu(
    name: 'Martabak Manis',
    category: 'Dessert',
    description: 'Martabak manis dengan berbagai topping seperti coklat, keju, dan kacang.',
    ingredients: 'Tepung terigu, gula, telur, mentega, susu, coklat, keju, kacang',
    cookingTime: '25 minutes',
    price: 'Rp 30000',
    imageAsset: 'images/martabak-manis.jpg',
    imageUrls: [
      'https://www.resepmakansedap.com/images/martabak-manis.jpg',
      'https://www.example.com/martabak-manis-2.jpg',
      'https://www.example.com/martabak-manis-3.jpg',
    ],
  ),
  FoodMenu(
    name: 'Klepon',
    category: 'Dessert',
    description: 'Kue tradisional berbentuk bulat berisi gula merah cair dan dibalut kelapa parut.',
    ingredients: 'Tepung ketan, gula merah, kelapa parut, pandan',
    cookingTime: '15 minutes',
    price: 'Rp 5000',
    imageAsset: 'images/klepon.jpg',
    imageUrls: [
      'https://www.resepmakansedap.com/images/klepon.jpg',
      'https://www.example.com/klepon-2.jpg',
      'https://www.example.com/klepon-3.jpg',
    ],
  ),
  FoodMenu(
    name: 'Nasi Uduk',
    category: 'Main Course',
    description: 'Nasi uduk is a fragrant rice dish cooked in coconut milk, served with fried chicken, omelette, and sambal.',
    ingredients: 'Rice, Coconut Milk, Spices, Fried Chicken, Egg, Sambal',
    cookingTime: '30 minutes',
    price: 'Rp 20.000',
    imageAsset: 'assets/images/nasi-uduk.jpg',
    imageUrls: [
      'https://example.com/images/nasi-uduk1.jpg',
      'https://example.com/images/nasi-uduk2.jpg',
      'https://example.com/images/nasi-uduk3.jpg'
    ],
  ),
  FoodMenu(
    name: 'Soto Betawi',
    category: 'Main Course',
    description: 'A traditional soup from Jakarta, made with beef, coconut milk, and spices.',
    ingredients: 'Beef, Coconut Milk, Spices, Potato, Tomato, Fried Shallot',
    cookingTime: '45 minutes',
    price: 'Rp 30.000',
    imageAsset: 'assets/images/soto-betawi.jpg',
    imageUrls: [
      'https://example.com/images/soto-betawi1.jpg',
      'https://example.com/images/soto-betawi2.jpg',
      'https://example.com/images/soto-betawi3.jpg'
    ],
  ),
  FoodMenu(
    name: 'Pempek',
    category: 'Snack',
    description: 'A savory fish cake from Palembang, served with a tangy tamarind sauce.',
    ingredients: 'Fish, Tapioca, Garlic, Vinegar, Sugar, Chili',
    cookingTime: '60 minutes',
    price: 'Rp 25.000',
    imageAsset: 'assets/images/pempek.jpg',
    imageUrls: [
      'https://example.com/images/pempek1.jpg',
      'https://example.com/images/pempek2.jpg',
      'https://example.com/images/pempek3.jpg'
    ],
  ),
  FoodMenu(
    name: 'Nasi Liwet',
    category: 'Main Course',
    description: 'Nasi liwet is a savory rice dish cooked with coconut milk, chicken broth, and served with chicken and tempeh.',
    ingredients: 'Rice, Coconut Milk, Chicken, Tempeh, Spices',
    cookingTime: '40 minutes',
    price: 'Rp 25.000',
    imageAsset: 'assets/images/nasi-liwet.jpg',
    imageUrls: [
      'https://example.com/images/nasi-liwet1.jpg',
      'https://example.com/images/nasi-liwet2.jpg',
      'https://example.com/images/nasi-liwet3.jpg'
    ],
  ),
  FoodMenu(
    name: 'Martabak Telur',
    category: 'Snack',
    description: 'A savory fried pancake filled with eggs, minced meat, and vegetables.',
    ingredients: 'Eggs, Minced Meat, Spring Onions, Flour, Spices',
    cookingTime: '20 minutes',
    price: 'Rp 15.000',
    imageAsset: 'assets/images/martabak-telur.jpg',
    imageUrls: [
      'https://example.com/images/martabak-telur1.jpg',
      'https://example.com/images/martabak-telur2.jpg',
      'https://example.com/images/martabak-telur3.jpg'
    ],
  ),
  FoodMenu(
    name: 'Bubur Ayam',
    category: 'Breakfast',
    description: 'A chicken congee served with shredded chicken, fried shallots, and crackers.',
    ingredients: 'Rice, Chicken, Soy Sauce, Fried Shallots, Crackers',
    cookingTime: '30 minutes',
    price: 'Rp 12.000',
    imageAsset: 'assets/images/bubur-ayam.jpg',
    imageUrls: [
      'https://example.com/images/bubur-ayam1.jpg',
      'https://example.com/images/bubur-ayam2.jpg',
      'https://example.com/images/bubur-ayam3.jpg'
    ],
  ),
  FoodMenu(
    name: 'Es Cendol',
    category: 'Dessert',
    description: 'A refreshing dessert drink made with green rice flour jelly, coconut milk, and palm sugar syrup.',
    ingredients: 'Rice Flour, Coconut Milk, Palm Sugar, Ice, Pandan',
    cookingTime: '15 minutes',
    price: 'Rp 10.000',
    imageAsset: 'assets/images/es-cendol.jpg',
    imageUrls: [
      'https://example.com/images/es-cendol1.jpg',
      'https://example.com/images/es-cendol2.jpg',
      'https://example.com/images/es-cendol3.jpg'
    ],
  ),
  FoodMenu(
    name: 'Gulai Kambing',
    category: 'Main Course',
    description: 'A rich and spicy goat meat stew cooked in coconut milk and spices.',
    ingredients: 'Goat Meat, Coconut Milk, Spices, Chili, Lemongrass',
    cookingTime: '90 minutes',
    price: 'Rp 35.000',
    imageAsset: 'assets/images/gulai-kambing.jpg',
    imageUrls: [
      'https://example.com/images/gulai-kambing1.jpg',
      'https://example.com/images/gulai-kambing2.jpg',
      'https://example.com/images/gulai-kambing3.jpg'
    ],
  ),
  FoodMenu(
    name: 'Kerak Telor',
    category: 'Snack',
    description: 'A Betawi traditional dish made from glutinous rice, egg, and seasoned with fried shallots and coconut.',
    ingredients: 'Glutinous Rice, Egg, Fried Shallots, Coconut, Spices',
    cookingTime: '25 minutes',
    price: 'Rp 20.000',
    imageAsset: 'assets/images/kerak-telor.jpg',
    imageUrls: [
      'https://example.com/images/kerak-telor1.jpg',
      'https://example.com/images/kerak-telor2.jpg',
      'https://example.com/images/kerak-telor3.jpg'
    ],
  ),
];
