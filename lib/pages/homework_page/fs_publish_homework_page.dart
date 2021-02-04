//提交作业

import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:family_school/pages/common/common_func.dart';
import 'package:family_school/pages/common/common_param.dart';
import 'package:family_school/pages/common/full_play.dart';
import 'package:family_school/pages/provider/homework_details_provider.dart';
import 'package:family_school/pages/provider/homework_list_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:videochat_package/constants/customMgr/screenMgr.dart';
import 'package:videochat_package/constants/customMgr/widgetMgr.dart';
import 'package:videochat_package/constants/photo_view_gallery.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';
import 'package:videochat_package/constants/constants.dart';
import '../common/common_func.dart';
import 'package:oktoast/oktoast.dart';

class SendHomeworkPage extends StatefulWidget {
  final int homeworkId;
  List<int> lsFileId; //文件id 便于删除
  List<String> lsAddr; //作业地址
  String content; //作业心得
  SendHomeworkPage(this.homeworkId, {this.content, this.lsAddr, this.lsFileId});
  @override
  _HomeWorkContentPageState createState() => _HomeWorkContentPageState();
}

class _HomeWorkContentPageState extends State<SendHomeworkPage> {
  final TextEditingController _contentController = new TextEditingController(); //标题
  int nFileNum = 0; //文件数量
  List<AssetEntity> assets = []; //选择的文件
  List<VideoImgParam> _lsVideoImg = []; //文件列表
  String strHint = "请输入今日作业心得";
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero, () async {
      if (widget.content != null && widget.content.isNotEmpty) {
        strHint = widget.content;
      }
      if (widget.lsAddr != null && widget.lsAddr.isNotEmpty) {
        setState(() {
          for (var ele in widget.lsAddr) {
            _lsVideoImg.add(getVideoImgFromNetwork(ele));
          }
          nFileNum += _lsVideoImg.length;
        });
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _contentController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CusText(
          "提交作业",
          color: Colors.black,
          size: CusFontSize.size_18,
        ),
        centerTitle: true,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return Stack(
      children: [
        ScrollConfiguration(
          behavior: ScrollBehavior(),
          child: SingleChildScrollView(
            child: Container(
              height: ScreenMgr.scrHeight - ScreenMgr.statusBarHeight - kToolbarHeight,
              color: Colors.white,
              child: Column(
                children: [
                  VSpacer(
                    ScreenMgr.setAdapterSize(50.0),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)), color: CusColorGrey.grey200),
                    height: ScreenMgr.setAdapterSize(340.0),
                    margin:
                        EdgeInsets.fromLTRB(ScreenMgr.setAdapterSize(30.0), 0.0, ScreenMgr.setAdapterSize(30.0), 0.0),
                    padding: EdgeInsets.all(ScreenMgr.setAdapterSize(30.0)),
                    child: TextField(
                      controller: _contentController,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          hintText: strHint,
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: CusColorGrey.grey500)),
                      maxLength: 300,
                      maxLines: 3,
                    ),
                  ),
                  Container(
                    height: ScreenMgr.setAdapterSize(100.0),
                    margin:
                        EdgeInsets.fromLTRB(ScreenMgr.setAdapterSize(30.0), 0.0, ScreenMgr.setAdapterSize(30.0), 0.0),
                    child: Divider(
                      height: 1.0,
                      color: CusColorGrey.grey200,
                    ),
                  ),
                  //上传附件就显示
                  Visibility(
                    visible: nFileNum > 0,
                    child: Container(
                        height: ScreenMgr.setAdapterSize(240.0),
                        padding: EdgeInsets.fromLTRB(ScreenMgr.setAdapterSize(30.0), 0.0,
                            ScreenMgr.setAdapterSize(30.0), ScreenMgr.setAdapterSize(30.0)),
                        child: ListView.builder(
                          itemBuilder: (_, index) {
                            return Container(
                              margin: EdgeInsets.only(left: ScreenMgr.setAdapterSize(10.0)),
                              width: ScreenMgr.setAdapterSize(200.0),
                              height: ScreenMgr.setAdapterSize(200.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5.0),
                                child: buildVideoImg(index),
                              ),
                            );
                          },
                          itemCount: _lsVideoImg.length,
                          scrollDirection: Axis.horizontal,
                        )),
                  ),
                  Container(
                    height: ScreenMgr.setAdapterSize(200.0),
                    margin:
                        EdgeInsets.fromLTRB(ScreenMgr.setAdapterSize(30.0), 0.0, ScreenMgr.setAdapterSize(30.0), 0.0),
                    child: Row(
                      children: [
                        HSpacer(ScreenMgr.setAdapterSize(30.0)),
                        InkWell(
                          onTap: () async {
                            await pickMethod(0);
                          },
                          child: Column(
                            children: [func_buildImageAsset("fs_image.png"), CusText("相册")],
                          ),
                        ),
                        HSpacer(ScreenMgr.setAdapterSize(150.0)),
                        InkWell(
                          onTap: () async {
                            await pickMethod(1);
                          },
                          child: Column(
                            children: [func_buildImageAsset("fs_camera.png"), CusText("拍照")],
                          ),
                        ),
                        HSpacer(ScreenMgr.setAdapterSize(150.0)),
                        InkWell(
                          onTap: () async {
                            await pickMethod(2);
                          },
                          child: Column(
                            children: [func_buildImageAsset("fs_video.png"), CusText("视频")],
                          ),
                        ),
                        Spacer()
                      ],
                    ),
                  ),
                  Spacer()
                ],
              ),
            ),
          ),
        ),
        _buildAssignment()
      ],
    );
  }

  //发布作业
  _buildAssignment() {
    return CusPadding(
      Container(
          height: ScreenMgr.setHeight(130.0),
          padding: EdgeInsets.fromLTRB(ScreenMgr.scrWidth * 0.15, 0.0, ScreenMgr.scrWidth * 0.15, 0.0),
          alignment: Alignment.center,
          child: InkWell(
            onTap: () async {
              List<File> lsFile = [];
              if (_lsVideoImg.isNotEmpty) {
                _lsVideoImg.forEach((element) {
                  if (element.bLocal) lsFile.add(element.file);
                });
              }

              await HomeworkListProvider.sendHomeworkReq(lsFile, widget.homeworkId, _contentController.text)
                  .then((value) {
                showToast("$value");
              });
              Navigator.of(context).pop("return");
            },
            child: Container(
              alignment: Alignment.center,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(30.0), color: Color.fromARGB(255, 58, 158, 255)),
              child: Text(
                "提交",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )),
      t: ScreenMgr.scrHeight * 0.75,
    );
  }

  pickMethod(int index) async {
    if (nFileNum == MAX_IAMGE_VIDEO) return;
    if (assets.isNotEmpty) assets.clear(); //清空
    final List<AssetEntity> result = await pickMethods[index].f(context, assets);
    if (result != null && result.isNotEmpty && result != assets) {
      assets = List<AssetEntity>.from(result);
      nFileNum += assets.length;

      for (int i = 0; i < assets.length; i++) {
        VideoImgParam param = await getVideoImgFromAssetEntityForHomework(assets[i]);
        _lsVideoImg.add(param);
      }
      setState(() {});
    }
    //键盘自动收起
    FocusScope.of(context).requestFocus(FocusNode());
  }

  buildVideoImg(int index) {
    return InkWell(
      onTap: () async {
        await preView(index);
      },
      child: Stack(
        children: [
          _lsVideoImg[index].bLocal
              ? Container(
                  width: double.infinity,
                  child: Image.memory(
                    _lsVideoImg[index].thumbnail,
                    fit: BoxFit.fill,
                  ))
              : buildNetworkImgVideo(index),
          Visibility(
              //视频显示时间
              visible: _lsVideoImg[index].type == 1,
              child: AnimatedPositioned(
                duration: kThemeAnimationDuration,
                bottom: 6.0,
                right: 6.0,
                child: CusText(
                  showVideoTime(_lsVideoImg[index].time),
                  color: Colors.white,
                ),
              )),
          AnimatedPositioned(
            duration: kThemeAnimationDuration,
            top: 0.0,
            right: 0.0,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  if (_lsVideoImg[index].bLocal) {
                  } else {
                    HomeWorkDetailsProvider.getDelHomeworkReq(widget.lsFileId[index])
                        .then((value) => showToast("$value"));
                    widget.lsFileId.removeAt(index);
                  }
                  _lsVideoImg.removeAt(index);
                  nFileNum--;
                });
              },
              child: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black38,
                ),
                child: Container(
                  width: ScreenMgr.setAdapterSize(80.0),
                  height: ScreenMgr.setAdapterSize(80.0),
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 18.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //显示网络图片
  buildNetworkImgVideo(int index) {
    return _lsVideoImg[index].type == 0
        ? CachedNetworkImage(
            imageUrl: "${_lsVideoImg[index].strAddress}",
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.fill,
                    colorFilter: ColorFilter.mode(Colors.transparent, BlendMode.colorBurn)),
              ),
            ),
            placeholder: (context, url) => Center(
              child: CupertinoActivityIndicator(),
            ),
            errorWidget: (context, url, error) => Icon(
              Icons.error,
              color: Colors.red,
            ),
          )
        : Stack(
            children: [
              Center(
                child: _lsVideoImg[index].videoCtrl,
              ),
              ColoredBox(
                color: Colors.transparent,
                child: Center(
                  child: Icon(
                    Icons.video_library,
                    color: Colors.grey,
                    size: 24.0,
                  ),
                ),
              ),
            ],
          );
  }

  //预览
  preView(int index) async {
    List<String> images = [];
    List<bool> localType = [];
    int count = 0;
    for (int i = 0; i < _lsVideoImg.length; i++) {
      var item = _lsVideoImg[i];
      if (item != null && item.type == 0) {
        if (i < index) count++;
        images.add(item.strAddress);
        if (item.bLocal)
          localType.add(true);
        else
          localType.add(false);
      }
    }
    if (_lsVideoImg[index].type == 0) {
      await Navigator.of(context).push(new FadeRoute(
          page: PhotoViewGalleryScreen(
        images: images, //传入图片list
        index: count, //传入当前点击的图片的index
        heroTag: "$count",
        localType: localType,
      )));
    } else {
      await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return VideoFullPage(_lsVideoImg[index].strAddress);
      }));
    }
  }

  List<PickMethodModel> get pickMethods => <PickMethodModel>[
        PickMethodModel(
          (
            BuildContext context,
            List<AssetEntity> assets,
          ) async {
            return await AssetPicker.pickAssets(
              context,
              maxAssets: MAX_IAMGE_VIDEO - nFileNum,
              selectedAssets: assets,
              requestType: RequestType.image,
            );
          },
        ),
        PickMethodModel(
          (
            BuildContext context,
            List<AssetEntity> assets,
          ) async {
            final AssetEntity result = await CameraPicker.pickFromCamera(context,
                isAllowRecording: true,
                resolutionPreset: ResolutionPreset.high,
                maximumRecordingDuration: const Duration(seconds: 30));
            List<AssetEntity> ls = [];
            if (result != null) {
              ls.add(result);
            }
            return ls;
          },
        ),
        PickMethodModel(
          (
            BuildContext context,
            List<AssetEntity> assets,
          ) async {
            return await AssetPicker.pickAssets(
              context,
              maxAssets: MAX_IAMGE_VIDEO - nFileNum,
              selectedAssets: assets,
              requestType: RequestType.video,
            );
          },
        ),
      ];
} //end_class

class PickMethodModel {
  final Future<List<AssetEntity>> Function(BuildContext context, List<AssetEntity> assets) f;
  PickMethodModel(this.f);
}
