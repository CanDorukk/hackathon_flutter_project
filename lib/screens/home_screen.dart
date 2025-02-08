import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackathonproject/core/LocaleManager.dart';
import 'package:hackathonproject/core/ThemeManager.dart';
import 'package:hackathonproject/screens/login_screen.dart';
import 'package:hackathonproject/screens/proife_screen.dart';
import 'package:hackathonproject/screens/settings_screen.dart';
import 'package:hackathonproject/widget/bottom_nav_bar.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget{
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    Center(child: Text('Ana Sayfa', style: TextStyle(fontSize: 24))),
    ProfileScreen(),
    SettingsScreen(),
  ];
  void _onItemTapped(int index) async{
    if(index == 1){  // Profil ekranı seçildiğinde
      final currentUser = FirebaseAuth.instance.currentUser;
      if(currentUser == null){
        // Eğer kullanıcı giriş yapmadıysa SnackBar göster
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(('Lütfen Kayıt Olunuz')),
            duration: Duration(seconds: 3),
          ),
        );
      } else {
        setState(() {
          _selectedIndex = index;
        });
      }
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final localManager = Provider.of<LocalManager>(context);
    final themeManager = Provider.of<ThemeManager>(context);
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(localManager.translate('title')),
        ),
      ),


      // 📌 Hamburger Menü (Drawer) Eklendi ve İçine Tema & Dil Seçimi Koyduk
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                localManager.translate("settings"),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),

            // 📌 Tema Değiştirme Seçeneği
            SwitchListTile(
              title: Text(localManager.translate('dark_theme')),
              value: themeManager.themeMode == ThemeMode.dark,
              onChanged: (bool value) {
                themeManager.toggleTheme();
              },
              secondary: Icon(Icons.brightness_6),
            ),

            // 📌 Dil Değiştirme Seçeneği
            ListTile(
              leading: Icon(Icons.language),
              title: Text(localManager.translate('language')),
              trailing: DropdownButton<Locale>(
                value: localManager.currentLocale,
                onChanged: (Locale? newLocale) {
                  if (newLocale != null) {
                    localManager.changedLocale(newLocale);
                  }
                },
                items: const [
                  DropdownMenuItem(
                    value: Locale('en'),
                    child: Text('English'),
                  ),
                  DropdownMenuItem(
                    value: Locale('tr'),
                    child: Text('Türkçe'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            // 📌 Giriş Yap ve Kayıt Ol Butonları
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Giriş Yap Butonu
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Text(localManager.translate('login')),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),






      body: IndexedStack(
        index: _selectedIndex,
        children: [
          Center(
            child: Text(
              localManager.translate('home'),
              style: TextStyle(fontSize: 24),
            ),
          ),

          // ekranların açılma sırası aşşağıda
          ProfileScreen(),
          SettingsScreen(),
          // CrudScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
          selectedIndex: _selectedIndex,
          onTop: _onItemTapped),
    );
  }
}