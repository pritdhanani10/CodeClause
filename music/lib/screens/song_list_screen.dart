import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/audio_provider.dart';
import 'player_screen.dart';

class SongListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final audioProvider = Provider.of<AudioProvider>(context);
    final songs = audioProvider.songs;

    return Scaffold(
      appBar: AppBar(
        title: Text('Music Player'),
      ),
      body: ListView.builder(
        itemCount: songs.length,
        itemBuilder: (context, index) {
          final song = songs[index];
          final isCurrent = audioProvider.currentIndex == index;
          final isPlaying = isCurrent && audioProvider.isPlaying;

          return ListTile(
            title: Text(song.title),
            trailing: isCurrent
                ? Icon(isPlaying ? Icons.pause : Icons.play_arrow)
                : null,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PlayerScreen(initialIndex: index),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
