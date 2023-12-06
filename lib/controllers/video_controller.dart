import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:video_player_app/models/videos_model.dart';
import 'package:intl/intl.dart';

class VideoController extends GetxController {
  RxList<Results> videosList = <Results>[].obs;
  RxBool isLoading = false.obs;
  RxInt page = 1.obs;
  final Rx<Results?> videoDetails = Rx<Results?>(null);

  final ScrollController scrollController = ScrollController();

  @override
  Future<void> onInit() async {
    super.onInit();
    await fetchVideos();
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        await fetchVideos();
      }
    });
  }

  Future<void> fetchVideos() async {
    try {
      if (!isLoading.value) {
        isLoading(true);
        final response = await http.get(Uri.parse(
            'https://test-ximit.mahfil.net/api/trending-video/1?page=${page.value}'));
        if (response.statusCode == 200) {
          final Map<String, dynamic> data =
              json.decode(utf8.decode(response.bodyBytes));
          final Videos videosData = Videos.fromJson(data);

          if (videosData.results != null) {
            videosList.addAll(videosData.results!);
            page++;
          }
        }
      }
    } catch (error) {
      debugPrint('Error fetching videos: $error');
    } finally {
      isLoading(false);
    }
  }

  String formattedDate(String? date) {
    if (date == null) {
      return '';
    }

    final DateTime parsedDate = DateTime.parse(date);
    final DateFormat formatter = DateFormat.yMMMd();
    return formatter.format(parsedDate);
  }

  void findVideoDetails(String videoTitle) {
    videoDetails.value = videosList.firstWhere(
      (video) => video.title == videoTitle,
    );
  }
}
