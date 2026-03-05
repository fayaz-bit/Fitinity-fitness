import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class WorkoutVideoPlayer extends StatefulWidget {
  final VideoPlayerController controller;

  const WorkoutVideoPlayer({super.key, required this.controller});

  @override
  State<WorkoutVideoPlayer> createState() => _WorkoutVideoPlayerState();
}

class _WorkoutVideoPlayerState extends State<WorkoutVideoPlayer> {
  ChewieController? chewieController;

  @override
  void initState() {
    super.initState();

    chewieController = ChewieController(
      videoPlayerController: widget.controller,
      autoPlay: false,
      looping: false,
      allowFullScreen: true,
      showControls: true,
    );
  }

  @override
  void dispose() {
    chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.controller.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return AspectRatio(
      aspectRatio: widget.controller.value.aspectRatio,
      child: Chewie(
        controller: chewieController!,
      ),
    );
  }
}
