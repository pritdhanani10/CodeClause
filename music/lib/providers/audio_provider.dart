import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import '../models/song.dart';

class AudioProvider with ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  List<Song> _songs = [
    Song(
        title: 'Song 1',
        assetPath: 'assets/song1.mp3',
        albumArt: 'assets/album1.png'),
    Song(
        title: 'Song 2',
        assetPath: 'assets/song2.mp3',
        albumArt: 'assets/album2.png'),
    Song(
        title: 'Song 3',
        assetPath: 'assets/song3.mp3',
        albumArt: 'assets/album3.png'),
    Song(
        title: 'Song 4',
        assetPath: 'assets/song4.mp3',
        albumArt: 'assets/album4.png'),
    Song(
        title: 'Song 5',
        assetPath: 'assets/song5.mp3',
        albumArt: 'assets/album5.png'),
    Song(
        title: 'Song 6',
        assetPath: 'assets/song6.mp3',
        albumArt: 'assets/album6.png'),
    Song(
        title: 'Song 7',
        assetPath: 'assets/song7.mp3',
        albumArt: 'assets/album7.png'),
    Song(
        title: 'Song 8',
        assetPath: 'assets/song8.mp3',
        albumArt: 'assets/album8.png'),
    Song(
        title: 'Song 9',
        assetPath: 'assets/song9.mp3',
        albumArt: 'assets/album9.png'),
    Song(
        title: 'Song 10',
        assetPath: 'assets/song10.mp3',
        albumArt: 'assets/album10.png'),
  ];

  int _currentIndex = -1;
  bool _isPlaying = false;
  double _volume = 1.0;

  List<Song> get songs => _songs;
  int get currentIndex => _currentIndex;
  bool get isPlaying => _isPlaying;
  double get volume => _volume;

  Song? get currentSong => _currentIndex >= 0 && _currentIndex < _songs.length
      ? _songs[_currentIndex]
      : null;

  AudioProvider() {
    _audioPlayer.onPlayerComplete.listen((event) {
      nextSong();
    });
  }

  Future<void> playSong(int index) async {
    if (index < 0 || index >= _songs.length) return;

    if (_currentIndex != index) {
      _currentIndex = index;
      await _audioPlayer.stop();
      await _audioPlayer.play(
          AssetSource(_songs[index].assetPath.replaceFirst('assets/', '')));
    } else {
      if (_isPlaying) {
        await _audioPlayer.pause();
      } else {
        await _audioPlayer.resume();
      }
    }

    _isPlaying = !_isPlaying;
    notifyListeners();
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
    _isPlaying = false;
    notifyListeners();
  }

  Future<void> nextSong() async {
    if (_currentIndex + 1 < _songs.length) {
      _currentIndex += 1;
      await _audioPlayer.stop();
      await _audioPlayer.play(AssetSource(
          _songs[_currentIndex].assetPath.replaceFirst('assets/', '')));
      _isPlaying = true;
      notifyListeners();
    }
  }

  Future<void> previousSong() async {
    if (_currentIndex - 1 >= 0) {
      _currentIndex -= 1;
      await _audioPlayer.stop();
      await _audioPlayer.play(AssetSource(
          _songs[_currentIndex].assetPath.replaceFirst('assets/', '')));
      _isPlaying = true;
      notifyListeners();
    }
  }

  void setVolume(double volume) {
    _volume = volume;
    _audioPlayer.setVolume(volume);
    notifyListeners();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
