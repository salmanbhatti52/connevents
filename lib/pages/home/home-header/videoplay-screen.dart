

import 'package:better_player/better_player.dart';
import 'package:flutter/cupertino.dart';

class VideoPlayScreen extends StatefulWidget {
  String url;
  VideoPlayScreen({Key? key,required this.url}) : super(key: key);

  @override
  State<VideoPlayScreen> createState() => _VideoPlayScreenState();
}

class _VideoPlayScreenState extends State<VideoPlayScreen> {

  late BetterPlayerController _betterPlayerController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _betterPlayerController = BetterPlayerController(
      const BetterPlayerConfiguration(
        autoDispose: true,
        aspectRatio: 0.5,
        looping: false,
        autoPlay: true,
      ),
      betterPlayerDataSource: BetterPlayerDataSource.network(widget.url)
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _betterPlayerController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: BetterPlayer(
        controller: _betterPlayerController,
      ),
    );
  }
}
