import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/audio_provider.dart';

class PlayerScreen extends StatefulWidget {
  final int initialIndex;

  PlayerScreen({required this.initialIndex});

  @override
  _PlayerScreenState createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  late AudioProvider _audioProvider;

  @override
  void initState() {
    super.initState();
    _audioProvider = Provider.of<AudioProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _audioProvider.playSong(widget.initialIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AudioProvider>(
      builder: (context, audio, child) {
        final currentSong = audio.currentSong;
        if (currentSong == null) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Now Playing'),
            ),
            body: Center(
              child: Text('No song selected'),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text('Now Playing'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Placeholder for album art or song title
                Icon(
                  Icons.music_note,
                  size: 150,
                  color: Colors.blueAccent,
                ),
                SizedBox(height: 30),
                Text(
                  currentSong.title,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                // Playback Controls
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.skip_previous),
                      iconSize: 40,
                      onPressed: audio.currentIndex > 0
                          ? () {
                              audio.previousSong();
                            }
                          : null,
                    ),
                    IconButton(
                      icon: Icon(
                          audio.isPlaying ? Icons.pause : Icons.play_arrow),
                      iconSize: 60,
                      onPressed: () {
                        audio.playSong(audio.currentIndex);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.skip_next),
                      iconSize: 40,
                      onPressed: audio.currentIndex < audio.songs.length - 1
                          ? () {
                              audio.nextSong();
                            }
                          : null,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                // Stop Button
                ElevatedButton.icon(
                  onPressed: () {
                    audio.stop();
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.stop),
                  label: Text('Stop'),
                  style: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                  ),
                ),
                SizedBox(height: 30),
                // Volume Slider
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.volume_down),
                    Slider(
                      value: audio.volume,
                      min: 0.0,
                      max: 1.0,
                      onChanged: (value) {
                        audio.setVolume(value);
                      },
                    ),
                    Icon(Icons.volume_up),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
