import 'package:flutter/material.dart';
import 'package:hackathonproject/core/LocaleManager.dart';
import 'package:provider/provider.dart';
class ProfileScreen extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    final localManager = Provider.of<LocalManager>(context);
    return Center(
      child: Text(localManager.translate("hello")),
    );
  }
}