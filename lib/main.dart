import 'package:flutter/material.dart';
import 'package:pokedex_app/screens/pokemon_list_screen.dart';
import 'package:provider/provider.dart';

import 'services/pokemon_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PokemonService()),
      ],
      child: MaterialApp(
        title: 'Pokedex',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: PokemonListScreen(),
      ),
    );
  }
}
