

import 'package:flutter/material.dart';

class ShipCard extends StatelessWidget {
  const ShipCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ExpansionTile(
        leading: const Icon(Icons.location_on),
        title: Text(
          'Calcular Frete',
          textAlign: TextAlign.start,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey[700]
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              restorationId:'',
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Digite seu CEP'
              ),
              onSubmitted: (text){

                }
                ),
            ),
        ],
      ),
    );
  }
}
