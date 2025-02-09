import 'package:hackathonproject/core/LocaleManager.dart';
import 'package:hackathonproject/screens/campaing_detail.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

class ProductCardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localManager = Provider.of<LocalManager>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(localManager.translate("product")),
        backgroundColor: Colors.blue.shade300,
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 30,),
          /// Slider Bölümü
          CarouselSlider(
            options: CarouselOptions(
              height: 180.0,
              autoPlay: true,
              enlargeCenterPage: true,
            ),
            items: [
              "assets/images/dyson.jpg",
              "assets/images/karcher.jpg",
              "assets/images/mob.jpg",
            ].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: AssetImage(i),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),

          const SizedBox(height: 20),

          /// Ürün Kartları - 2 Sütun
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 sütun olacak
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 3 / 4, // Kartların oranı (daha dikey olacak)
              ),
              itemCount: productList.length,
              itemBuilder: (context, index) {
                return ProductCard(
                  imagePath: productList[index]["imagePath"],
                  title: productList[index]["title"],
                  priceUsd: productList[index]["priceUsd"],
                  exchangeRateEur: 0.92,
                  exchangeRateTry: 30.0,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Ürün Listesi
final List<Map<String, dynamic>> productList = [
  {
    "imagePath": "assets/images/karcher.jpg",
    "title": "Buharlı Makine",
    "priceUsd": 50.0,
  },
  {
    "imagePath": "assets/images/mob.jpg",
    "title": "Buharlı Mob",
    "priceUsd": 80.0,
  },
  {
    "imagePath": "assets/images/dyson.jpg",
    "title": "Hava Temizleyici",
    "priceUsd": 20.0,
  },
  {
    "imagePath": "assets/images/camtemizleme.jpg",
    "title": "Cam Temizleyici",
    "priceUsd": 30.0,
  },
];

/// Ürün Kartı
class ProductCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final double priceUsd;
  final double exchangeRateEur;
  final double exchangeRateTry;

  const ProductCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.priceUsd,
    required this.exchangeRateEur,
    required this.exchangeRateTry,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CampaingDetailPage(),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, height: 100), // Resim genişliği 100 piksel
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text("\$${priceUsd.toStringAsFixed(2)}", style: const TextStyle(fontSize: 14, color: Colors.black)),
            Text("€${(priceUsd * exchangeRateEur).toStringAsFixed(2)}", style: const TextStyle(fontSize: 14, color: Colors.black)),
            Text("₺${(priceUsd * exchangeRateTry).toStringAsFixed(2)}", style: const TextStyle(fontSize: 14, color: Colors.black)),
          ],
        ),
      ),
    );
  }
}