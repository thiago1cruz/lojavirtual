

import 'package:flutter/material.dart';


class DrawerTile extends StatelessWidget {

  final IconData  icon;
  final String text;
  final PageController controller;
  final int page;


  const DrawerTile({ Key? key, required  this.icon, required this.text, required this.controller, required this.page }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: (){
          Navigator.of(context).pop();
          controller.jumpToPage(page);
         },
        child: Container(
          height: 60.0,
          child: Row(
            children: [
              Icon(
                icon,
                size: 32,
                color: controller.page?.round() == page ? Theme.of(context).primaryColor : Colors.grey[700],
              ),
              const  SizedBox(width:  32,),
              Text(
                text,
                style: TextStyle( fontSize: 16, color: controller.page?.round()  == page ? Theme.of(context).primaryColor : Colors.grey[700],),
              )
            ],
          ),
        ),
      ),
    );
  }
}