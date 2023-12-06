import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_app/controllers/video_controller.dart';
import 'package:video_player_app/models/videos_model.dart';

class VideoPageController extends GetxController {
  final VideoController videoController = Get.put(VideoController());

  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;

  @override
  void onClose() {
    videoController.videoDetails.value = null;
    videoPlayerController.dispose();
    videoController.dispose();
    chewieController.pause();
    chewieController.dispose();
    super.onClose();
  }

  @override
  void dispose() {
    videoController.videoDetails.value = null;
    videoPlayerController.dispose();
    videoController.dispose();
    chewieController.pause();
    chewieController.dispose();
    super.dispose();
  }

  String calculateDaysAgo(String? videoDate) {
    if (videoDate == null) {
      return '';
    }

    DateTime videoDateTime = DateTime.parse(videoDate);

    Duration difference = DateTime.now().difference(videoDateTime);
    int daysAgo = difference.inDays;

    if (daysAgo == 0) {
      return 'today';
    } else if (daysAgo == 1) {
      return 'yesterday';
    } else {
      return '$daysAgo days ago';
    }
  }

  void initializeVideoPlayer() {
    final Results? videoDetails = videoController.videoDetails.value;

    videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(videoDetails?.manifest ?? ''),
    );

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      looping: false,
      aspectRatio: MediaQuery.of(Get.context!).size.width / 200,
      placeholder: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 200.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(videoDetails?.thumbnail ?? ''),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 10.0,
            left: 10.0,
            child: Container(
              height: 40,
              width: 50,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(0, 0, 0, 0.3),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                color: Colors.white,
                iconSize: 25.0,
                onPressed: () {
                  Get.back();
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
