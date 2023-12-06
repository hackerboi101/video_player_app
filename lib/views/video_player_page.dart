// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player_app/controllers/video_controller.dart';
import 'package:video_player_app/controllers/video_page_controller.dart';
import 'package:video_player_app/models/videos_model.dart';
import 'package:video_player_app/views/empty_page.dart';
import 'package:video_player_app/views/utils/action_container.dart';
import 'package:chewie/chewie.dart';

class VideoPlayerPage extends StatelessWidget {
  VideoPlayerPage({super.key});

  final VideoPageController videoPageController =
      Get.put(VideoPageController());
  final VideoController videoController = Get.put(VideoController());

  @override
  Widget build(BuildContext context) {
    final Results? videoDetails = videoController.videoDetails.value;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30.0),
            Stack(
              children: [
                Obx(() {
                  videoPageController.initializeVideoPlayer();

                  return Container(
                    width: double.infinity,
                    height: 200.0,
                    child: Chewie(
                        controller: videoPageController.chewieController),
                  );
                }),
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
                        videoController.videoDetails.value = null;
                        videoPageController.videoPlayerController.dispose();
                        videoPageController.videoController.dispose();
                        videoPageController.chewieController.pause();
                        videoPageController.chewieController.dispose();
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                videoDetails?.title ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                '${videoDetails?.viewers} views . ${videoPageController.calculateDaysAgo(videoDetails?.dateAndTime)}',
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ActionContainer(
                      icon: Icons.favorite_border_outlined,
                      label: 'MASH ALLAH (12K)'),
                  ActionContainer(
                      icon: Icons.thumb_up_outlined, label: 'LIKE (12K)'),
                  ActionContainer(icon: Icons.share_outlined, label: 'SHARE'),
                  ActionContainer(icon: Icons.flag_outlined, label: 'REPORT'),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20.0,
                    backgroundImage:
                        NetworkImage(videoDetails?.channelImage ?? ''),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(const EmptyPage());
                          },
                          child: Text(
                            videoDetails?.channelName ?? '',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          '${videoDetails?.channelSubscriber} Subscribers',
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                    label: const Text('Subscribe'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            const Divider(color: Colors.grey),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(const EmptyPage());
                    },
                    child: const Text(
                      'Comments   7.5K',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ),
                const IconButton(
                  icon: Icon(Icons.arrow_drop_down_outlined),
                  color: Colors.grey,
                  iconSize: 25.0,
                  onPressed: null,
                ),
              ],
            ),
            const SizedBox(height: 6.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.0),
                  border: Border.all(color: Colors.grey[300]!),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 16.0),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Add Comment',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
