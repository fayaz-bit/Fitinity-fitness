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
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _openFullScreenVideo() {
    if (_controller == null) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => WorkoutVideoPlayer(controller: _controller!),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 6,
            offset: Offset(0, 3),
          )
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Workout Name
          Text(
            widget.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 14),

          /// Workout Info (VERTICAL)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _info(Icons.timer, widget.duration),
              const SizedBox(height: 6),
              _info(Icons.repeat, widget.sets),
              const SizedBox(height: 6),
              _info(Icons.fitness_center, widget.reps),
            ],
          ),

          /// Video Title
          if (widget.videoTitle != null && widget.videoTitle!.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              widget.videoTitle!,
              style: const TextStyle(
                color: Colors.white70,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],

          /// Video URL
          if (widget.videoUrl != null && widget.videoUrl!.isNotEmpty) ...[
            const SizedBox(height: 8),
            InkWell(
              onTap: () => _launchURL(widget.videoUrl!),
              child: Row(
                children: const [
                  Icon(Icons.link, color: Colors.blueAccent),
                  SizedBox(width: 6),
                  Text(
                    "Watch Video",
                    style: TextStyle(
                      color: Colors.blueAccent,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
          ],

          /// Local Video Preview
          if (_controller != null && _controller!.value.isInitialized) ...[
            const SizedBox(height: 14),
            GestureDetector(
              onTap: _openFullScreenVideo,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  height: 160,
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
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black45,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: const Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 36,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],

          const SizedBox(height: 16),

          /// Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton.icon(
                onPressed: widget.onEdit,
                icon: const Icon(Icons.edit, size: 18),
                label: const Text("Edit"),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.purple,
                  side: const BorderSide(color: Colors.purple),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: widget.onDelete,
                icon: const Icon(Icons.delete, size: 18),
                label: const Text("Delete"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  /// Info widget
  Widget _info(IconData icon, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.purple, size: 18),
        const SizedBox(width: 6),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
