import 'dart:async';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as rtc_local_view;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as rtc_remote_view;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:psychological_counseling/controller/slot.dart';
import 'package:psychological_counseling/utils/settings.dart';

class BodyLive extends StatefulWidget {
  final String? chanelName;
  final ClientRole? role;
  // final String? token;
  final String? token;
  final DateTime? timeEnd;
  final int? id;

  const BodyLive({
    Key? key,
    this.chanelName,
    this.role,
    this.token,
    this.timeEnd,
    this.id,
  }) : super(key: key);

  @override
  State<BodyLive> createState() => _BodyLiveState();
}

class _BodyLiveState extends State<BodyLive> {
  final _user = <int>[];
  final _infoStrings = <String>[];
  bool muted = false;
  bool viewPanel = false;
  bool banChat = false;
  late RtcEngine _engine;

  bool isMore = false;
  int minute = 0;

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
    // final timer = Timer(Duration(minutes: 1), () {
    //   setState(() {
    //     _showDialog();
    //   });
    // });
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
    // if (widget.role == ClientRole.Broadcaster) {
    //   list.add(const rtc_local_view.SurfaceView());
    // }
    // for (var uid in _user) {
    //   list.add(rtc_remote_view.SurfaceView(
    //     uid: uid,
    //     channelId: widget.chanelName!,
    //   ));
    // }
    list.add(const rtc_local_view.SurfaceView());
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
                                            .confirmLive(widget.id);
                                        Navigator.pop(context);
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
      body: Center(
        child: Stack(
          children: <Widget>[
            _viewRows(),
            _panel(),
            _toolbar(),
          ],
        ),
      ),
    );
  }

  // Future _showDialog() {
  //   DateTime? timebegin =
  //       DateFormat("yyyy-MM-dd HH:mm").parse('${DateTime.now()}');
  //   DateTime? finish = widget.timeEnd!;
  //   int? minute;
  //   return showDialog(
  //       context: context,
  //       builder: (BuildContext context) => AlertDialog(
  //             title: const Text(
  //               'Thông báo',
  //               style: TextStyle(fontWeight: FontWeight.bold),
  //             ),
  //             content: Text('Còn 5 phút trước khi buổi live kết thúc '),
  //             actions: <Widget>[
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   Padding(
  //                     padding: EdgeInsets.only(right: 1),
  //                     child: Padding(
  //                       padding: const EdgeInsets.all(8.0),
  //                       child: ElevatedButton(
  //                           onPressed: () {
  //                             // timerStart(minute = finish.hour +
  //                             //     finish.minute -
  //                             //     timebegin.hour -
  //                             //     timebegin.minute);
  //                             timerStart(1);
  //                             Navigator.pop(context, 'Đồng ý');
  //                           },
  //                           child: const Text(
  //                             'Đồng ý',
  //                             style: TextStyle(color: Colors.white),
  //                           )),
  //                     ),
  //                   ),
  //                   Padding(
  //                     padding: EdgeInsets.only(left: 1),
  //                     child: ElevatedButton(
  //                         onPressed: () {
  //                           //   timerStart(finish.hour +
  //                           //       finish.minute -
  //                           //       timebegin.hour -
  //                           //       timebegin.minute +
  //                           //       5);
  //                           timerStart(1);
  //                           Navigator.pop(context, 'Gia hạn thêm 5 phút');
  //                         },
  //                         child: const Text(
  //                           'Gia hạn thêm 5 phút',
  //                           style: TextStyle(color: Colors.white),
  //                         )),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ));
  // }

  // void timerStart(int minute) {
  //   final timer = Timer(Duration(minutes: minute), () {
  //     _engine.leaveChannel();
  //     slotbookingcontroller.confirmLive(widget.id);
  //   });
  // }
}
