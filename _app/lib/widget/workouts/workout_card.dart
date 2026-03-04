import 'dart:io';
import 'package:_app/widget/workouts/video_player.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

class WorkoutCard extends StatefulWidget {
  final String name;
  final String duration;
  final String sets;
  final String reps;
  final String? videoTitle;
  final String? videoUrl;
  final String? videoFilePath;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const WorkoutCard({
    super.key,
    required this.name,
    required this.duration,
    required this.sets,
    required this.reps,
    this.videoTitle,
    this.videoUrl,
    this.videoFilePath,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  State<WorkoutCard> createState() => _WorkoutCardState();
}

class _WorkoutCardState extends State<WorkoutCard> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    _initVideoController();
  }

  void _initVideoController() {
    final path = widget.videoFilePath;
    if (path != null && path.isNotEmpty) {
      _controller = VideoPlayerController.file(File(path))
        ..initialize().then((_) => setState(() {}));
    }
  }

  @override
  void didUpdateWidget(covariant WorkoutCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.videoFilePath != widget.videoFilePath) {
      _controller?.dispose();
      _initVideoController();
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _openFullScreenVideo() {
    if (_controller == null) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FullScreenVideoPlayer(controller: _controller!),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF202020),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.name,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          _info("Duration", widget.duration),
          _info("Sets", widget.sets),
          _info("Reps", widget.reps),
          if (widget.videoTitle != null && widget.videoTitle!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text("Video Title: ${widget.videoTitle}",
                style: const TextStyle(color: Colors.white70)),
          ],
          if (widget.videoUrl != null && widget.videoUrl!.isNotEmpty) ...[
            const SizedBox(height: 8),
            TextButton.icon(
              onPressed: () => _launchURL(widget.videoUrl!),
              icon: const Icon(Icons.link, color: Colors.blueAccent),
              label: const Text(
                "Watch Video",
                style: TextStyle(
                    color: Colors.blueAccent,
                    decoration: TextDecoration.underline),
              ),
            ),
          ],
          if (_controller != null && _controller!.value.isInitialized) ...[
            const SizedBox(height: 10),
            GestureDetector(
              onTap: _openFullScreenVideo,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 150,
                  width: double.infinity,
                  color: Colors.black,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      FittedBox(
                        fit: BoxFit.cover,
                        child: SizedBox(
                          width: _controller!.value.size.width,
                          height: _controller!.value.size.height,
                          child: VideoPlayer(_controller!),
                        ),
                      ),
                      Icon(
                        _controller!.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: Colors.white,
                        size: 40,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(
                onPressed: widget.onEdit,
                style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.purple)),
                child:
                    const Text('Edit', style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(width: 8),
              TextButton(
                onPressed: widget.onDelete,
                style: TextButton.styleFrom(backgroundColor: Colors.redAccent),
                child:
                    const Text('Delete', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _info(String label, String value) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(label, style: const TextStyle(color: Colors.white70, fontSize: 15)),
      Text(value, style: const TextStyle(color: Colors.white70, fontSize: 15))
    ]);
  }
}
