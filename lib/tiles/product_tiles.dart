import 'package:flutter/material.dart';
import 'package:lojavirtual/data/product_data.dart';
import 'package:lojavirtual/screens/product_screen.dart';

class ProductTile extends StatelessWidget {
  final String type;
  final ProductData data;

  const ProductTile({Key? key, required this.type, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ProductScreen(data: data))
          );
      },
      child: Card(
        child: type == 'grid'
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AspectRatio(
                    aspectRatio: 0.8,
                    child: Image.network(
                      data.images.first,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                      Text(
                        data.title,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).primaryColor)),
                      Text(
                        "R\$ ${data.price.toStringAsFixed(2)}",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor),
                      )
                    ]),
                  ))
                ],
              )
            : Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Image.network(
                      data.images.first,
                      fit: BoxFit.cover,
                      height: 250,
                    ),
                ),
                Flexible(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [                    
                      Text(data.title,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).primaryColor)),
                      Text(
                        "R\$ ${data.price.toStringAsFixed(2)}",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor),
                      )
                    ]),
                )
              ],
            ),
      ),
    );
  }
}
