import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(
            vsync: this,
            duration: const Duration(milliseconds: 450)
        );
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IconButton(
          iconSize:150,
          splashColor:Colors.blue[100],
          highlightColor: Colors.blue[200],
          splashRadius: 70,

          icon: AnimatedIcon(
            icon: AnimatedIcons.play_pause,
            progress: _animationController,
            color: Colors.blue[500],

          ),
          onPressed: () => _handleOnPressed(),
        ),
      ),
    );
  }

  void _handleOnPressed() {
    setState(() {
      Vibration.vibrate(duration: 200);
      isPlaying = !isPlaying;
      playLocal();
      isPlaying
          ? _animationController.forward()
          : _animationController.reverse();
    });
  }

  playLocal() async {
    int result = await audioPlayer.play('assets/audio/click.wav', isLocal: true);
  }

}