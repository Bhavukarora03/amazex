import 'package:example/custom_orientation_player/controls.dart';
import 'package:example/utils/mock_data.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:video_player/video_player.dart';

import 'data_manager.dart';

class CustomOrientationPlayer extends StatefulWidget {
  CustomOrientationPlayer({Key? key}) : super(key: key);

  @override
  _CustomOrientationPlayerState createState() =>
      _CustomOrientationPlayerState();
}

class _CustomOrientationPlayerState extends State<CustomOrientationPlayer> {
  late FlickManager flickManager;
  late DataManager dataManager;
  List<String> urls = (mockData["items"] as List)
      .map<String>((item) => item["trailer_url"])
      .toList();

  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
        videoPlayerController: VideoPlayerController.network(
          "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
          closedCaptionFile: _loadCaptions(),
        ),
        onVideoEnd: () {
          dataManager.skipToNextVideo(Duration(seconds: 5));
        });

    dataManager = DataManager(flickManager: flickManager, urls: urls);
  }

  Future<ClosedCaptionFile> _loadCaptions() async {
    final String fileContents = await DefaultAssetBundle.of(context)
        .loadString('images/bumble_bee_captions.srt');
    flickManager.flickControlManager!.toggleSubtitle();
    return SubRipCaptionFile(fileContents);
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  skipToVideo(String url) {
    flickManager.handleChangeVideo(VideoPlayerController.network(url));
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: ObjectKey(flickManager),
      onVisibilityChanged: (visibility) {
        if (visibility.visibleFraction == 0 && this.mounted) {
          flickManager.flickControlManager?.autoPause();
        } else if (visibility.visibleFraction == 1) {
          flickManager.flickControlManager?.autoResume();
        }
      },
      child: Column(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 16 / 9,
            child: FlickVideoPlayer(
              flickManager: flickManager,


              flickVideoWithControls: FlickVideoWithControls(
                controls: CustomOrientationControls(dataManager: dataManager),
              ),
              flickVideoWithControlsFullscreen: FlickVideoWithControls(
                controls: CustomOrientationControls(dataManager: dataManager),
              ),

            ),
          ),
        ],
      ),
    );
  }
}
