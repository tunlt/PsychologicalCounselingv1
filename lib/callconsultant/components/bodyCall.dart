import 'dart:async';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as rtc_local_view;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as rtc_remote_view;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:psychological_counseling/controller/slot.dart';
import 'package:psychological_counseling/utils/settings.dart';

class BodyCall extends StatefulWidget {
  final String? chanelName;
  final ClientRole? role;
  // final String? token;
  final String? token;
  final DateTime? timeEnd;
  final int? id;

  const BodyCall({
    Key? key,
    this.chanelName,
    this.role,
    this.token,
    this.timeEnd,
    this.id,
  }) : super(key: key);

  @override
  State<BodyCall> createState() => _BodyCallState();
}

class _BodyCallState extends State<BodyCall> {
  final _user = <int>[];
  final _infoStrings = <String>[];
  bool muted = false;
  bool viewPanel = false;
  bool banChat = false;
  bool banVideo = false;
  late RtcEngine _engine;

  bool isMore = false;
  int minute = 0;

  // void timerStart() {
  //   _timer = Timer.periodic(Duration(seconds: 1), (timer) {
  //     setState(() {
  //       DateTime.now().second;
  //     });
  //   });
  // }

  final slotbookingcontroller = Get.find<SlotbookingController>();
  @override
  void initState() {
    super.initState();
    initialize();
    DateTime? timeNoti = widget.timeEnd!.subtract(Duration(minutes: 5));
    DateTime? timefinish = widget.timeEnd!;
    DateTime? timestart =
        DateFormat("yyyy-MM-dd HH:mm").parse('${DateTime.now()}');
    print(timestart);
    print(timeNoti);
    print(timefinish);
    // DateTime? timestart = DateTime.now();
    minute = (timeNoti.hour * 60 + timeNoti.minute) -
        (timestart.hour * 60 + timestart.minute);
    final timer = Timer(Duration(minutes: 1), () {
      setState(() {
        _showDialog();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _user.clear();
    _engine.leaveChannel();
    _engine.destroy();
  }

  Future<void> initialize() async {
    if (appId.isEmpty) {
      setState(() {
        _infoStrings.add("AppId is missing, plz input your AppId");
        _infoStrings.add("Agora engine is not star");
      });
      return;
    }
    // initAgoraRTC engine
    _engine = await RtcEngine.create(appId);
    await _engine.enableVideo();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(widget.role!);
    // addAdoraEventhandler
    _addAgoraEventHandlers();
    VideoEncoderConfiguration configuration = VideoEncoderConfiguration();
    configuration.dimensions = VideoDimensions(width: 1928, height: 1080);
    await _engine.setVideoEncoderConfiguration(configuration);
    await _engine.joinChannel(widget.token!, widget.chanelName!, null, 0);
  }

  // List<Widget> _getRenderViews() {
  //   final List<StatefulWidget> list = [];
  //   list.add(rtc_local_view.SurfaceView());
  //   _user
  //       .forEach((int uid) => list.add(rtc_remote_view.SurfaceView(uid: uid)));
  //   return list;
  // }

  void _addAgoraEventHandlers() {
    _engine.setEventHandler(RtcEngineEventHandler(
      error: (code) {
        setState(() {
          final info = 'Error' + '$code';
          _infoStrings.add(info);
        });
      },
      joinChannelSuccess: (channel, uid, elapsed) {
        setState(() {
          final info = 'Join chanelName: $channel, Uid: $uid';
          _infoStrings.add(info);
        });
      },
      leaveChannel: (stats) {
        setState(() {
          _infoStrings.add("Leave chanel");
          _user.clear();
        });
      },
      userJoined: (uid, elapsed) {
        setState(() {
          _infoStrings.add("User Join: $uid");
          _user.add(uid);
        });
      },
      userOffline: (uid, reason) {
        setState(() {
          _infoStrings.add("User Out: $uid");
          _user.remove(uid);
        });
      },
      firstRemoteVideoFrame: (uid, width, height, elapsed) {
        _infoStrings.add("First Remote video: $uid ${width}x$height");
      },
    ));
  }

  Widget _viewRows() {
    // if (widget.role == ClientRole.Broadcaster) return const SizedBox();
    final List<StatefulWidget> list = [];
    if (widget.role == ClientRole.Broadcaster) {
      list.add(const rtc_local_view.SurfaceView());
    }
    for (var uid in _user) {
      list.add(rtc_remote_view.SurfaceView(
        uid: uid,
        channelId: widget.chanelName!,
      ));
    }
    final views = list;
    return Column(
      children: List.generate(
        views.length,
        (index) => Expanded(
          child: views[index],
        ),
      ),
    );
    // if (widget.role == ClientRole.Broadcaster) {}
    // return;
  }

  // Widget _videoView(
  //   List<Widget> views,
  // ) {
  //   if (banVideo) {
  //     return Expanded(
  //         child: Row(
  //       children: [ShowAvatar(width: 20, height: 20)],
  //     ));
  //   }
  //   return Expanded(
  //       child: Row(
  //     children: [],
  //   ));
  // }

  // Widget _viewRows() {
  //   // if (widget.role == ClientRole.Broadcaster) return const SizedBox();
  //   return Container(
  //     child: Stack(
  //       children: [
  //         Column(
  //           children: <Widget>[
  //             !banChat
  //                 // ? _expandedVideoRow()

  //                 ? ShowAvatar(
  //                     height: 90,
  //                     width: 120,
  //                   )
  //                 : ShowAvatar(
  //                     width: 150,
  //                     height: 150,
  //                   )
  //           ],
  //         ),
  //         Positioned.fill(
  //           top: 10,
  //           child: Align(
  //             alignment: !banChat ? Alignment.center : Alignment.topCenter,
  //             child: Container(
  //               width: MediaQuery.of(context).size.width * 0.8,
  //               child: Text(
  //                 'Đang kết nối với bác sĩ tư vấn của bạn...',
  //                 softWrap: true,
  //                 style: TextStyle(
  //                   fontSize: 18,
  //                   color: Colors.white70,
  //                 ),
  //                 textAlign: TextAlign.center,
  //               ),
  //             ),
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  List<Widget> _getRenderView() {
    final List<StatefulWidget> list = [];
    list.add(rtc_local_view.SurfaceView());
    for (var uid in _user) {
      list.add(rtc_remote_view.SurfaceView(
        uid: uid,
        channelId: widget.chanelName!,
      ));
    }
    return list;
  }

  // Widget _viewRows() {
  //   // final wrappedViews = views.map<Widget>(_videoView).toList();
  //   final views = _getRenderView();
  //   switch (views.length) {
  //     case 1:
  //       return Column(children: [rtc_local_view.SurfaceView()]);
  //     default:
  //   }
  //   return Container();
  // }

  Widget _toolbar() {
    if (widget.role == ClientRole.Audience) return const SizedBox();
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
            onPressed: () {
              setState(() {
                muted = !muted;
              });
              _engine.muteLocalAudioStream(muted);
            },
            child: Icon(muted ? Icons.mic_off : Icons.mic,
                color: muted ? Colors.white : Colors.blueAccent, size: 20.0),
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: muted ? Colors.blueAccent : Colors.white,
            padding: const EdgeInsets.all(12),
          ),
          RawMaterialButton(
            // onPressed: () => Navigator.pop(context),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        title: const Text(
                          'Thông báo',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        content: Text(
                            'Bạn có chắc chắn xác nhận cuộc gọi kết thúc? Lưu ý kết thúc cuộc gọi sẽ kết toán và không thể vào lại.'),
                        actions: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 1),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                      onPressed: () {
                                        _engine.leaveChannel();
                                        slotbookingcontroller
                                            .confirmVideocall(widget.id);
                                      },
                                      child: const Text(
                                        'Đồng ý',
                                        style: TextStyle(color: Colors.white),
                                      )),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 1),
                                child: ElevatedButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Hủy'),
                                    child: const Text(
                                      'Hủy',
                                      style: TextStyle(color: Colors.white),
                                    )),
                              ),
                            ],
                          ),
                        ],
                      ));
            },
            child: const Icon(
              Icons.call_end,
              color: Colors.white,
              size: 35.0,
            ),
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.redAccent,
            padding: const EdgeInsets.all(15.0),
          ),
          RawMaterialButton(
            onPressed: () {
              _engine.switchCamera();
            },
            child: const Icon(
              Icons.switch_camera,
              color: Colors.blueAccent,
              size: 20.0,
            ),
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.white,
            padding: const EdgeInsets.all(12),
          ),

          //test mutecamera
          RawMaterialButton(
            onPressed: () {
              setState(() {
                banVideo = !banVideo;
              });
              _engine.enableLocalVideo(!banVideo);
            },
            child: Icon(banVideo ? Icons.camera : Icons.camera_alt,
                color: banVideo ? Colors.white : Colors.blueAccent, size: 20.0),
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: banVideo ? Colors.blueAccent : Colors.white,
            padding: const EdgeInsets.all(12),
          ),
          // RawMaterialButton(
          //   onPressed: () {},
          //   child: Icon(
          //     banChat ? Icons.message_sharp : Icons.messenger,
          //     color: banChat ? Colors.blueAccent : Colors.white,
          //   ),
          // )
        ],
      ),
    );
  }

  // Widget _info() {
  //   return Container(
  //     alignment: Alignment.topLeft,
  //     padding: const EdgeInsets.symmetric(vertical: 48),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.end,
  //       children: <Widget>[
  //         RawMaterialButton(
  //           onPressed: () {
  //             setState(() {
  //               IconButton(
  //                 onPressed: () {
  //                   setState(() {
  //                     viewPanel = !viewPanel;
  //                   });
  //                 },
  //                 icon: const Icon(Icons.info_outline),
  //               );
  //             });
  //           },
  //         ),

  //         // RawMaterialButton(
  //         //   onPressed: () {},
  //         //   child: Icon(
  //         //     banChat ? Icons.message_sharp : Icons.messenger,
  //         //     color: banChat ? Colors.blueAccent : Colors.white,
  //         //   ),
  //         // )
  //       ],
  //     ),
  //   );
  // }

  Widget _panel() {
    return Visibility(
      visible: viewPanel,
      child: Container(
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.symmetric(vertical: 48),
        child: FractionallySizedBox(
          heightFactor: 0.5,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 48),
            child: ListView.builder(itemBuilder: (BuildContext context, index) {
              if (_infoStrings.isEmpty) {
                return const Text("Null");
              }
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                        child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        _infoStrings[index],
                      ),
                    ))
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("text"),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                viewPanel = !viewPanel;
              });
            },
            icon: const Icon(Icons.info_outline),
          )
        ],
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            // _info(),
            _viewRows(),
            // _panel(),
            _toolbar(),
          ],
        ),
      ),
    );
  }

  Future _showDialog() {
    DateTime? timebegin =
        DateFormat("yyyy-MM-dd HH:mm").parse('${DateTime.now()}');
    DateTime? finish = widget.timeEnd!;
    int? minute;
    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text(
                'Thông báo',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: Text('Còn 5 phút trước khi cuộc họp kết thúc '),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 1),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            onPressed: () {
                              // timerStart(minute = finish.hour +
                              //     finish.minute -
                              //     timebegin.hour -
                              //     timebegin.minute);
                              // timerStart(1);
                              Navigator.pop(context, 'Đồng ý');
                            },
                            child: const Text(
                              'Đồng ý',
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 1),
                      child: ElevatedButton(
                          onPressed: () {
                            //   timerStart(finish.hour +
                            //       finish.minute -
                            //       timebegin.hour -
                            //       timebegin.minute +
                            //       5);
                            // timerStart(1);
                            Navigator.pop(context, 'Gia hạn thêm 5 phút');
                          },
                          child: const Text(
                            'Gia hạn thêm 5 phút',
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  ],
                ),
              ],
            ));
  }

  // void timerStart(int minute) {
  //   final timer = Timer(Duration(minutes: minute), () {
  //     _engine.leaveChannel();
  //     slotbookingcontroller.confirmVideocall(widget.id);
  //   });
  // }
}

class ShowAvatar extends StatelessWidget {
  const ShowAvatar({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);
  final double width, height;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(10.0),
            width: width,
            height: height,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white70, width: 2),
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    'https://www.researchgate.net/publication/29608002/figure/fig1/AS:309880117317644@1450892585639/Class-and-instance-specifications.png'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
