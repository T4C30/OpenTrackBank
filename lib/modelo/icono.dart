import 'package:flutter/material.dart';

enum Icono {
  comida(Icons.fastfood),
  compra(Icons.shop)
  ;

  final IconData icono;

  const Icono(this.icono);

}