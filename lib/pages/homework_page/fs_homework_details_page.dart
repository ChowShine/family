//作业详情

import 'package:videochat_package/constants/base/base_provider.dart';
import '../common/ImgVideoHelper.dart';
import '../common/common_func.dart';
import 'package:flutter/material.dart';
import 'package:videochat_package/constants/constants.dart';
import 'package:videochat_package/pages/component/touch_callback.dart';
import '../common/common_param.dart';
import './fs_publish_homework_page.dart';
import '../common/audio_player.dart';
import '../model/homework_details_model.dart';
import '../provider/homework_details_provider.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:videochat_package/constants/customMgr/dlgMgr.dart';

class HomeWorkDetailsPage extends StatefulWidget {
  int homeWorkId;
  HomeWorkDetailsPage(this.homeWorkId);
  @override
  _HomeWorkDetailsPageState createState() => _HomeWorkDetailsPageState();
}

class _HomeWorkDetailsPageState extends State<HomeWorkDetailsPage> {
  HomeWorkDetailsProvider provider = HomeWorkDetailsProvider();
  ImageVideoHelper imgVideoHelper; //老师布置作业文件
  ImageVideoHelper stuImgVideoHelper; //学生提交文件
  bool isPlayVoice = false; //是否播放语音
  AudioPalyerMgr playAudio;
  List<String> ls_Score = [];
  List<int> lsFileId = [];
  int sendFileLen = 0;
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero, () async {
      await this.provider.getHomeworkDetailsReq(widget.homeWorkId);
      int stuFileLen = this.provider.instance?.data?.files?.length ?? 0;
      if (stuFileLen > 0) {
        List<String> lsAdd = [];
        this.provider.instance.data.files.forEach((element) {
          lsAdd.add(element.address);
        });
        imgVideoHelper = new ImageVideoHelper(lsAdd, context);
      }

      //学生提交文件个数
      sendFileLen = this.provider.instance?.data?.studentHomework?.studentFiles?.length ?? 0;
      if (sendFileLen > 0) {
        List<String> lsAdd = [];
        this.provider.instance.data.studentHomework.studentFiles.forEach((element) {
          lsAdd.add(element.studentFilesAddress);
          lsFileId.add(element.studentFilesId);
        });
        stuImgVideoHelper = new ImageVideoHelper(lsAdd, context);
      }

      //判断是否有点评文件 ：语音
      bool isHaveVoice = (this.provider.instance?.data?.studentHomework?.remarkFile?.length ?? 0) == 0 ? false : true;
      if (isHaveVoice) {
        playAudio = AudioPalyerMgr(
            en_AudioType.AUDIO_TYPE_URL, this.provider.instance.data.studentHomework.remarkFile[0]?.address);

        playAudio.onPlayerStateChangedListen((value) {
          Constants.log.v("$value");
          if (isPlayVoice) {
            //在播放
            if (value == AudioPlayerState.COMPLETED) {
              setState(() {
                isPlayVoice = false;
              });
            }
          }
        });
      }

      //将分数等级保存
      int scoreLen = this.provider.instance?.data?.score?.length ?? 0;
      if (scoreLen > 0) {
        this.provider.instance.data.score.forEach((element) {
          ls_Score.add(element.scoreName);
        });
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "作业详情",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        brightness: Brightness.light,
        elevation: 0.0,
      ),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return ChangeNotifierProvider<BaseProvider<HomeworkDetailModel>>(
      create: (_) => provider,
      child: Consumer<BaseProvider<HomeworkDetailModel>>(
        builder: (_, provider, child) => this.provider.instance == null
            ? LoadingDialog(
                color: Colors.black54,
              )
            : ScrollConfiguration(
                behavior: ScrollBehavior(),
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Container(
                        height: ScreenMgr.scrHeight /*-ScreenMgr.statusBarHeight-kToolbarHeight*/ +
                            func_ShowPicHeight(sendFileLen) +
                            (this.provider.isComment == true ? ScreenMgr.setAdapterSize(750.0) : 0.0),
                        color: Colors.white,
                        child: Column(
                          children: [
                            Container(
                                padding: EdgeInsets.only(
                                    left: ScreenMgr.setAdapterSize(40.0), right: ScreenMgr.setAdapterSize(40.0)),
                                alignment: Alignment.centerLeft,
                                height: ScreenMgr.setAdapterSize(100.0),
                                child: CusText(
                                  "${this.provider.instance?.data?.homeworkName ?? ""}",
                                  fontWeight: FontWeight.bold,
                                  size: CusFontSize.size_18,
                                )),
                            Container(
                                padding: EdgeInsets.only(
                                    left: ScreenMgr.setAdapterSize(40.0), right: ScreenMgr.setAdapterSize(40.0)),
                                alignment: Alignment.centerLeft,
                                height: ScreenMgr.setAdapterSize(100.0),
                                child: CusText(
                                  "${this.provider.instance?.data?.teacherName ?? ""}老师 ${this.provider.instance?.data?.gradeClass ?? ""} ${this.provider.instance?.data?.startTime ?? ""}",
                                  size: CusFontSize.size_14,
                                  color: CusColorGrey.grey400,
                                )),
                            Container(
                              padding: EdgeInsets.only(
                                  left: ScreenMgr.setAdapterSize(40.0), right: ScreenMgr.setAdapterSize(40.0)),
                              alignment: Alignment.centerLeft,
                              child: showHtmlView("${this.provider.instance?.data?.homeworkDetails ?? ""}"),
                            ),
                            buildImageWidget(),
                            Container(
                                padding: EdgeInsets.only(
                                    left: ScreenMgr.setAdapterSize(40.0), right: ScreenMgr.setAdapterSize(40.0)),
                                alignment: Alignment.centerLeft,
                                height: ScreenMgr.setAdapterSize(100.0),
                                child: Row(
                                  children: [
                                    func_buildImageAsset("fs_end_time.png", dScale: 3.0),
                                    CusText(
                                      " 截止日期${this.provider.instance?.data?.endTime ?? ""}",
                                      size: CusFontSize.size_14,
                                      color: CusColorGrey.grey400,
                                    ),
                                    Spacer()
                                  ],
                                )),
                            !this.provider.isHaveSend
                                ? Container()
                                : VSpacer(
                                    ScreenMgr.setAdapterSize(30.0),
                                    color: CusColorGrey.grey100,
                                  ),
                            !this.provider.isHaveSend ? Spacer() : buildSendHomework(),
                            !this.provider.isComment
                                ? Container()
                                : VSpacer(
                                    ScreenMgr.setAdapterSize(30.0),
                                    color: CusColorGrey.grey100,
                                  ),
                            !this.provider.isComment ? Container() : buildTeacherComment(),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: !this.provider.isHaveSend,
                      child: buildSendBtn(),
                    )
                  ],
                ),
              ),
      ),
    );
  }

  //加载作业图片
  buildImageWidget() {
    return (imgVideoHelper?.lsAddress?.length ?? 0) == 0
        ? Container(
            height: 0,
          )
        : Container(
            padding: EdgeInsets.fromLTRB(ScreenMgr.setAdapterSize(30.0), 0.0, ScreenMgr.setAdapterSize(30.0), 0.0),
            alignment: Alignment.topCenter,
            height: func_ShowPicHeight(imgVideoHelper?.lsAddress?.length) + ScreenMgr.setAdapterSize(30.0),
            child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, crossAxisSpacing: 10.0, mainAxisSpacing: 10.0),
                itemBuilder: (_, index) {
                  return InkWell(
                    onTap: () async {
                      imgVideoHelper.preView(index);
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Container(child: imgVideoHelper.buildImgVideo(index)),
                    ),
                  );
                },
                itemCount: imgVideoHelper?.lsAddress?.length));
  }

  //学生上交作业
  buildSendHomework() {
    return Container(
      padding: EdgeInsets.fromLTRB(ScreenMgr.setAdapterSize(50.0), 0.0, ScreenMgr.setAdapterSize(50.0), 0.0),
      child: Column(
        children: [
          Container(
              height: ScreenMgr.setAdapterSize(120.0),
              child: Row(
                children: [
                  CusText(
                    "我的作业:",
                    size: CusFontSize.size_17,
                    fontWeight: FontWeight.bold,
                  ),
                  Spacer(),
                  Container(
                      height: ScreenMgr.setHeight(120.0),
                      width: ScreenMgr.setAdapterSize(200.0),
                      padding: EdgeInsets.all(ScreenMgr.setAdapterSize(20.0)),
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () async {
                          if (this.provider.isCanModify)
                            await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                              return SendHomeworkPage(
                                widget.homeWorkId,
                                content: "${this.provider.instance?.data?.studentHomework?.content ?? ""}",
                                lsAddr: stuImgVideoHelper.lsAddress,
                                lsFileId: lsFileId,
                              );
                            })).then((value) {
                              if (value == "return") Navigator.pop(context);
                            });
                        },
                        child: Visibility(
                          visible: this.provider.isCanModify,
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0), color: Color.fromARGB(255, 88, 158, 255)),
                            child: Text(
                              "修 改",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      )),
                ],
              )),
          Container(
            height: ScreenMgr.setAdapterSize(150.0),
            alignment: Alignment.centerLeft,
            child: CusText(
              "${this.provider.instance?.data?.studentHomework?.content ?? ""}",
              color: Colors.grey,
              size: CusFontSize.size_16,
            ),
          ),
          (stuImgVideoHelper?.lsAddress?.length ?? 0) == 0
              ? Container()
              : Container(
                  padding:
                      EdgeInsets.fromLTRB(ScreenMgr.setAdapterSize(30.0), 0.0, ScreenMgr.setAdapterSize(30.0), 0.0),
                  alignment: Alignment.topCenter,
                  height: func_ShowPicHeight(stuImgVideoHelper?.lsAddress?.length) + ScreenMgr.setAdapterSize(30.0),
                  child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, crossAxisSpacing: 10.0, mainAxisSpacing: 10.0),
                      itemBuilder: (_, index) {
                        return InkWell(
                          onTap: () async {
                            stuImgVideoHelper.preView(index);
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Container(child: stuImgVideoHelper.buildImgVideo(index)),
                          ),
                        );
                      },
                      itemCount: stuImgVideoHelper?.lsAddress?.length))
        ],
      ),
    );
  }

  //老师点评
  buildTeacherComment() {
    return Container(
      padding: EdgeInsets.fromLTRB(ScreenMgr.setAdapterSize(50.0), 0.0, ScreenMgr.setAdapterSize(50.0), 0.0),
      child: Column(
        children: [
          Container(
              height: ScreenMgr.setAdapterSize(120.0),
              child: Row(
                children: [
                  CusText(
                    "老师点评:",
                    size: CusFontSize.size_17,
                    fontWeight: FontWeight.bold,
                  ),
                  Spacer(),
                  CusText(
                    "${this.provider.instance?.data?.studentHomework?.remarkTime?.substring(5, 19) ?? ""}",
                    size: CusFontSize.size_16,
                    color: CusColorGrey.grey500,
                  ),
                ],
              )),
          Container(
            height: ScreenMgr.setAdapterSize(260.0),
            child: Column(
              children: [
                (this.provider.instance?.data?.studentHomework?.scoreName ?? "") == ""
                    ? Container()
                    : Center(
                        child: func_buildImageAsset(
                            "fs_score${getScoreImg(this.provider.instance?.data?.studentHomework?.scoreName)}_select.png",
                            dScale: 2.4),
                      ),
                CusText(
                  "${this.provider.instance?.data?.studentHomework?.scoreName ?? ""}",
                  fontWeight: FontWeight.bold,
                  size: CusFontSize.size_16,
                )
              ],
            ),
          ),
          Container(
            height: ScreenMgr.setAdapterSize(150.0),
            alignment: Alignment.centerLeft,
            child: CusText(
              "${this.provider.instance?.data?.studentHomework?.remark ?? ""}",
              color: Colors.grey,
              size: CusFontSize.size_16,
            ),
          ),
          (this.provider.instance?.data?.studentHomework?.remarkFile?.length ?? 0) == 0
              ? Container()
              : Container(
                  //有语音
                  height: 40.0,
                  alignment: Alignment.centerLeft,
                  child: Stack(
                    children: [
                      Container(
                        width: ScreenMgr.scrWidth * 0.4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0), color: Color.fromARGB(255, 69, 126, 216)),
                      ),
                      InkWell(
                        onTap: () async {
                          if (!isPlayVoice) {
                            //没有播放就播放
                            Constants.log.v("播放");
                            setState(() {
                              isPlayVoice = true;
                            });
                            await playAudio.play();
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(
                              ScreenMgr.setAdapterSize(30.0), 0.0, ScreenMgr.setAdapterSize(30.0), 0.0),
                          width: ScreenMgr.scrWidth * 0.4,
                          child: Center(
                            child: Row(
                              children: [
                                CusText(
                                  "${showVideoTime(int.parse(this.provider.instance.data.studentHomework.remarkFile[0].voiceTime))}",
                                  color: Colors.white,
                                ),
                                Spacer(),
                                func_buildImageAsset(isPlayVoice ? "fs_play_voice.gif" : "fs_non_play_voice.png"),
                                HSpacer(ScreenMgr.setAdapterSize(20.0)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
        ],
      ),
    );
  }

  buildSendBtn() {
    return CusPadding(
      Container(
          height: ScreenMgr.setHeight(130.0),
          padding: EdgeInsets.fromLTRB(ScreenMgr.setAdapterSize(150.0), 0.0, ScreenMgr.setAdapterSize(150.0), 0.0),
          alignment: Alignment.center,
          child: TouchCallBack(
            onPressed: () {
              RouteMgr().push(context, SendHomeworkPage(widget.homeWorkId));
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(ScreenMgr.setAdapterSize(100.0)), color: Colors.blue),
              child: Text(
                "提交作业",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )),
      t: ScreenMgr.scrHeight * 0.75,
    );
  }

  int getScoreImg(String str) {
    int i = 0;
    ls_Score.forEach((element) {
      if (str == element) {
        return;
      }
      i++;
    });
    return i;
  }
} //end_class
