import 'package:hackathonproject/core/LocaleManager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CampaingPages extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final localManager = Provider.of<LocalManager>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade300,
        title: Text(localManager.translate("campaign")),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [],
            ),
          ),
          Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 16),
                children: [
                  GestureDetector(
                    onTap: () {
                      _showCampaignDialog(context, "İlk Defa Gelenlere Özel 'URUN100' Kodu!");
                    },
                    child: _buildCampaignCard(
                        "İlk Defa Gelenlere Özel 'URUN100' Kodu!",
                        "assets/images/camsilme.jpg"
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _showCampaignDialog(context, "'BUHARLI50' Kodu!");
                    },
                    child: _buildCampaignCard(
                        "'BUHARLI50' Kodu!",
                        "assets/images/buharli.jpg"
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _showCampaignDialog(context, "'VAKUM25' Kodu!");
                    },
                    child: _buildCampaignCard(
                        "'VAKUM25' Kodu!",
                        "assets/images/vakumlu.jpg"
                    ),
                  )
                ],
              )
          )
        ],
      ),
    );
  }

  // Kampanya detaylarını gösteren dialog
  void _showCampaignDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Kampanya Detayı"),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              message,
              style: TextStyle(fontSize: 16),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dialog'u kapat
              },
              child: Text("Kapat"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFilterIcon(IconData icon, String label, bool isSelected) {
    return Column(
      children: [
        Icon(
          icon,
          color: isSelected ? Colors.pink : Colors.white,
          size: 30,
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.pink : Colors.white,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        )
      ],
    );
  }

  Widget _buildCategoryButton(String label, bool isSelected) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade300 : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.blue.shade300),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
                color: isSelected ? Colors.white : Colors.blue.shade300,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCampaignCard(String title, String imagePath) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRect(
            child: Image.asset(
              imagePath,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold
              ),
            ),
          )
        ],
      ),
    );
  }
}
