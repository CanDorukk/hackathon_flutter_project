import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackathonproject/core/LocaleManager.dart';
import 'package:hackathonproject/core/ThemeManager.dart';
import 'package:provider/provider.dart';
import 'package:hackathonproject/screens/login_screen.dart';


class ProfileScreen extends StatelessWidget{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    final localManager = Provider.of<LocalManager>(context);
    final User? currentUser = _auth.currentUser;
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16),
          color: Colors.blue.shade400,
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.orange,
                child: Icon(Icons.person, size: 40, color: Colors.white,),
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    localManager.translate("welcome"),
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Text(
                    "${currentUser?.email ?? 'Misafir'}",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16),
              ),
            ),
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                    ],
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text("Üyelik Bilgilerim"),
                        trailing: Icon(Icons.arrow_forward_ios, size: 16,
                          color: Colors.blue.shade400,),
                      ),
                      ListTile(
                        title: Text("Promosyonlarım"),
                        trailing: Icon(Icons.arrow_forward_ios, size: 16,
                            color: Colors.blue.shade400),
                      ),
                      ListTile(
                        title: Text("Ürün Geçmişi"),
                        trailing: Icon(Icons.arrow_forward_ios, size: 16,
                            color: Colors.blue.shade400),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24,),
                Text(
                  "Ayarlar",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 8),
                ListTile(
                  leading: Icon(Icons.language, color: Colors.blue.shade500,),
                  title: Text(localManager.translate('language'),style: TextStyle(color: Colors.blue.shade500),),
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
                        child: Text('English',style: TextStyle(color: Colors.blueGrey),),
                      ),
                      DropdownMenuItem(
                        value: Locale('tr'),
                        child: Text('Türkçe',style: TextStyle(color: Colors.blueGrey)),
                      ),
                    ],
                  ),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.monetization_on, color: Colors.blue,),
                  title: Text(localManager.translate("currency"),style: TextStyle(color: Colors.blue.shade500)),
                  trailing: Text(
                    '\$ Dollar',
                    style: TextStyle(color: Colors.black38),
                  ),

                ),


              ],
            ),
          ),
        ),
      ],
    );
  }
}