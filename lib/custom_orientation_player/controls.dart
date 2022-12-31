import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'data_manager.dart';

class CustomOrientationControls extends StatelessWidget {
  const CustomOrientationControls(
      {Key? key, this.iconSize = 20, this.fontSize = 12, this.dataManager})
      : super(key: key);
  final double iconSize;
  final double fontSize;
  final DataManager? dataManager;

  @override
  Widget build(BuildContext context) {
    FlickVideoManager flickVideoManager =
        Provider.of<FlickVideoManager>(context);
    final isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: FlickAutoHideChild(
            child: Container(color: Colors.black38),
          ),
        ),
        Positioned.fill(
          child: FlickShowControlsAction(
            child: FlickSeekVideoAction(
              child: Center(
                child: flickVideoManager.nextVideoAutoPlayTimer != null
                    ? FlickAutoPlayCircularProgress(
                        colors: FlickAutoPlayTimerProgressColors(
                          backgroundColor: Colors.white30,
                          color: Colors.red,
                        ),
                      )
                    : FlickAutoHideChild(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: GestureDetector(
                            //     onTap: () {
                            //       dataManager!.skipToPreviousVideo();
                            //     },
                            //     child: Icon(
                            //       Icons.skip_previous,
                            //       color: dataManager!.hasPreviousVideo()
                            //           ? Colors.white
                            //           : Colors.white38,
                            //       size: 35,
                            //     ),
                            //   ),
                            // ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FlickPlayToggle(size: 50,),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: GestureDetector(
                            //     onTap: () {
                            //       dataManager!.skipToNextVideo();
                            //     },
                            //     child: Icon(
                            //       Icons.skip_next,
                            //       color: dataManager!.hasNextVideo()
                            //           ? Colors.white
                            //           : Colors.white38,
                            //       size: 35,
                            //     ),
                            //   ),
                            // )
                          ],
                        ),
                      ),
              ),
            ),
          ),
        ),
        isLandScape
            ? Positioned(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                bottom: 80,
                child: FlickAutoHideChild(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 60.0, vertical: 30.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                            text: TextSpan(
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                                children: [
                              TextSpan(
                                  text: "Episode :1\n",
                                  style: TextStyle(fontSize: 12)),
                              TextSpan(
                                text: "Lesson Planning",
                              )
                            ])),
                        Expanded(
                          child: Container(),
                        ),
                        FlickFullScreenToggle(
                          size: 24,
                        ),
                      ],
                    ),
                  ),
                ))
            : SizedBox(),
        Positioned(
          child: FlickAutoHideChild(
            child: Padding(
                padding: isLandScape
                    ? EdgeInsets.symmetric(horizontal: 60.0, vertical: 30.0)
                    : EdgeInsets.symmetric(vertical: 30.0, horizontal: 10.0),
                child: isLandScape
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          FlickCurrentPosition(
                            fontSize: fontSize,
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          FlickTotalDuration(
                            fontSize: fontSize,
                          ),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  FlickCurrentPosition(
                                    fontSize: fontSize,
                                  ),
                                  Text(
                                    ' / ',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: fontSize),
                                  ),
                                  FlickTotalDuration(
                                    fontSize: fontSize,
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Container(),
                              ),
                              FlickFullScreenToggle(
                                size: 22,
                              ),
                            ],
                          ),
                        ],
                      )),
          ),
        ),
        Positioned.fill(
          top: isLandScape ? 280 : 230,
          child: FlickAutoHideChild(
            child: Padding(
              padding: isLandScape ? EdgeInsets.all(60.0) : EdgeInsets.all(0.0),
              child: FlickVideoProgressBar(
                flickProgressBarSettings: FlickProgressBarSettings(
                  height: 5,
                  handleRadius: 10,
                  curveRadius: 50,
                  backgroundColor: Colors.white24,
                  bufferedColor: Colors.white38,
                  playedColor: Colors.blueAccent,
                  handleColor: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Positioned(
            top: 10,
            right: isLandScape ? 40 : 10,
            child: FlickAutoHideChild(
                child: Row(
              children: [
               FlickSubtitleToggle(
                  size: 22,
                ),
                SizedBox(
                  width: 10,
                ),
                IconButton(
                    iconSize: 22,
                    onPressed: () {
                      showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(25.0),
                            ),
                          ),
                          context: context,
                          builder: (context) => Container(
                                height: 800,
                                child: Padding(
                                  padding: const EdgeInsets.all(50.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Add a note",
                                        textAlign: TextAlign.start,
                                      ),
                                      TextField(
                                        decoration: InputDecoration(
                                            hintText: "Enter your comment"),
                                      ),
                                    ],
                                  ),
                                ),
                              ));
                    },
                    icon: Icon(Icons.note_add_outlined)),
                IconButton(
                    iconSize: 22,
                    onPressed: () {
                      showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),

                          context: context,
                          builder: (context) {
                            return Container(
                              height: 500,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Divider(
                                    thickness: 5,
                                    endIndent: 200,
                                    indent: 200,
                                  ),
                                  ListTile(
                                    title: Text('Subtitles'),
                                    trailing: Switch(
                                      value: true,
                                      onChanged: (value) {
                                        value = !value;
                                      },
                                    ),
                                  ),
                                  ListTile(
                                    title: Text('Playback Speed'),
                                    onTap: () {},
                                    trailing: Text('1.0x'),
                                  ),
                                  ListTile(
                                    title: Text('Video Language'),
                                    trailing: Text('English >'),
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  ListTile(
                                    title: Text('Enter Picture in Picture'),
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                    icon: Icon(Icons.settings_outlined))
              ],
            ))),
      ],
    );
  }
}
