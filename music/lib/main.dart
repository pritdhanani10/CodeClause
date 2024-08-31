import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/audio_provider.dart';
import 'screens/song_list_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AudioProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Music Player',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SongListScreen());
  }
}
