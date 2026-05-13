import 'package:flutter/material.dart';

class BolsaTab extends StatelessWidget {
  const BolsaTab({super.key});

  
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> stocks = [
      {'ticker': 'AAPL', 'name': 'Apple Inc.', 'price': '175.40', 'change': '+1.2%', 'isUp': true},
      {'ticker': 'TSLA', 'name': 'Tesla Inc.', 'price': '210.00', 'change': '-0.8%', 'isUp': false},
      {'ticker': 'GOOGL', 'name': 'Alphabet Inc.', 'price': '135.20', 'change': '+0.5%', 'isUp': true},
    ];

    return SafeArea(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('Mercado de Valores', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: stocks.length,
              itemBuilder: (context, index) {
                final stock = stocks[index];
                return ListTile(
                  leading:CircleAvatar(
                    backgroundColor: const Color(0xFF2C2C2C), // Gris oscuro
                    foregroundColor: const Color(0xFF1E88E5), // Letra azul
                    child: Text(stock['ticker'][0], style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  title: Text(stock['ticker'], style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(stock['name']),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('\$${stock['price']}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text(
                        stock['change'],
                        style: TextStyle(color: stock['isUp'] ? Colors.green : Colors.red, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}