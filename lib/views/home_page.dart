import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player_app/controllers/video_controller.dart';
import 'package:video_player_app/models/videos_model.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final VideoController videoController = Get.put(VideoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: videoController.scrollController,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30.0),
            const Text(
              'Trending Videos',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Obx(
              () {
                if (videoController.isLoading.value &&
                    videoController.page == RxInt(1)) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: videoController.videosList.length,
                    itemBuilder: (context, index) {
                      final Results video = videoController.videosList[index];

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 200.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(video.thumbnail ?? ''),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                color: Colors.black,
                                child: Text(
                                  video.duration ?? '',
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 20.0,
                                backgroundImage: NetworkImage(
                                  video.channelImage ?? '',
                                ),
                              ),
                              const SizedBox(width: 8.0),
                              Expanded(
                                child: Text(
                                  video.title ?? '',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const Icon(Icons.more_horiz, color: Colors.grey),
                            ],
                          ),
                          const SizedBox(height: 5.0),
                          Padding(
                            padding: const EdgeInsets.only(left: 48.0),
                            child: Text(
                              '${video.viewers ?? ''} views · ${videoController.formattedDate(video.dateAndTime)}',
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          const Divider(),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
