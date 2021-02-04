import 'package:flutter/material.dart';
import 'package:videochat_package/constants/constants.dart';
import 'package:family_school/pages/my_page/fs_project_details.dart';
import 'package:family_school/pages/provider/fs_growth_process_provider.dart';
import 'package:videochat_package/constants/token/family_token.dart';
import '../common/common_param.dart';
import '../common/ImgVideoHelper.dart';
import 'package:videochat_package/constants/customMgr/dlgMgr.dart';

class PhotoPage extends StatefulWidget {
  @override
  _PhotoPageState createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {
  GrowthProvider provider = GrowthProvider();
  ImageVideoHelper _imgVideoHelper; //显示图片和视频
  List<String> imgList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () async {
      await this.provider.getGrowth();
      setState(() {});
      this.provider.projectsList.forEach((item) {
        imgList.add(
            '${gnNetType == 0 ? URL.API_ADD_UPLOAD : URLIntranet.API_ADD_UPLOAD}${item.address}');
      });
      _imgVideoHelper = new ImageVideoHelper(imgList, context);
    });
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
          "列表",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0.0,
      ),
      body: this.provider.projectsList == null ? LoadingDialog() : _buildBody(),
      resizeToAvoidBottomInset: false,
    );
  }

  _buildBody() {
    return CusPadding(
      Container(
        //     child: ListView.builder(
        //   itemCount: this.provider.projectsList.length,
        //   itemBuilder: (context, index) {
        //     if (this.provider.projectsList.length > 0) {
        //       return _buildContent(index, this.provider.projectsList);
        //     } else {
        //       return null;
        //     }
        //   },
        //   shrinkWrap: true,
        // )
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: this.provider.projectsList.length,
          itemBuilder: (context, index) {
            return _buildImages(this.provider.projectsList, index);
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //每个孩子的横轴与主轴范围的比率
              childAspectRatio: 2 / 2,
              crossAxisCount: 2,
              //垂直单个子Widget之间间距
              mainAxisSpacing: 10,
              //水平单个子Widget之间间距
              crossAxisSpacing: 10),
        ),
      ),
      l: ScreenMgr.setAdapterSize(50.0),
      r: ScreenMgr.setAdapterSize(50.0),
    );
  }

  _buildImages(projectsList, index) {
    return InkWell(
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Container(child: _imgVideoHelper.buildImgVideo(index)),
          ),
          Positioned(
              bottom: ScreenMgr.setAdapterSize(50.0),
              left: ScreenMgr.setAdapterSize(30.0),
              child: CusText(
                '${projectsList[index].projectsName}',
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ))
        ],
      ),
      onTap: () {
        RouteMgr().push(
            context,
            DetailsPage(
                projectsList[index].projectId,
                projectsList[index].projectsName,
                projectsList[index].stationName));
      },
    );
  }
}

_buildContent(index, projectsList) {
  return Column(
    children: [
      CusPadding(
        InkWell(
          child: Stack(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Container(
                      child: index == 0
                          ? Image.network(
                              "${gnNetType == 0 ? URL.API_ADD_UPLOAD : URLIntranet.API_ADD_UPLOAD}${projectsList[index].address}",
                            )
                          : (index * 5 < projectsList.length - 1
                              ? Image.network(
                                  "${gnNetType == 0 ? URL.API_ADD_UPLOAD : URLIntranet.API_ADD_UPLOAD}${projectsList[index * 5].address}",
                                )
                              : Container()))),
              Positioned(
                bottom: ScreenMgr.setAdapterSize(50.0),
                left: ScreenMgr.setAdapterSize(30.0),
                child: index == 0
                    ? CusText(
                        '${projectsList[index].projectsName}',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )
                    : (index * 5 < projectsList.length - 1
                        ? CusText(
                            '${projectsList[index * 5].projectsName}',
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          )
                        : Container()),
              )
            ],
          ),
          onTap: () {
            // RouteMgr().push(context, DetailsPage());
          },
        ),
        l: ScreenMgr.setAdapterSize(50.0),
        r: ScreenMgr.setAdapterSize(50.0),
      ),
      SizedBox(
        height: ScreenMgr.setAdapterSize(50.0),
      ),
      CusPadding(
        Row(
          children: [
            InkWell(
              child: Stack(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Container(
                          child: index == 0
                              ? Image.network(
                                  "${gnNetType == 0 ? URL.API_ADD_UPLOAD : URLIntranet.API_ADD_UPLOAD}${projectsList[index + 1].address}",
                                  fit: BoxFit.fill,
                                )
                              : (index * 5 + 1 < projectsList.length - 1
                                  ? Image.network(
                                      "${gnNetType == 0 ? URL.API_ADD_UPLOAD : URLIntranet.API_ADD_UPLOAD}${projectsList[index * 5 + 1].address}",
                                    )
                                  : Container()))),
                  Positioned(
                    bottom: ScreenMgr.setAdapterSize(50.0),
                    left: ScreenMgr.setAdapterSize(30.0),
                    child: index == 0
                        ? CusText(
                            '${projectsList[index + 1].projectsName}',
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          )
                        : (index * 5 + 1 < projectsList.length - 1
                            ? CusText(
                                '${projectsList[index * 5 + 1].projectsName}',
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              )
                            : Container()),
                  )
                ],
              ),
              onTap: () {},
            ),
            SizedBox(
              width: ScreenMgr.setAdapterSize(40.0),
            ),
            InkWell(
              child: Stack(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: index == 0
                          ? Image.network(
                              "${gnNetType == 0 ? URL.API_ADD_UPLOAD : URLIntranet.API_ADD_UPLOAD}${projectsList[index + 2].address}",
                              fit: BoxFit.fill,
                            )
                          : (index * 5 + 2 < projectsList.length - 1
                              ? Image.network(
                                  "${gnNetType == 0 ? URL.API_ADD_UPLOAD : URLIntranet.API_ADD_UPLOAD}${projectsList[index * 5 + 2].address}",
                                  fit: BoxFit.fill,
                                )
                              : Container())),
                  Positioned(
                    bottom: ScreenMgr.setAdapterSize(50.0),
                    left: ScreenMgr.setAdapterSize(30.0),
                    child: index == 0
                        ? CusText(
                            '${projectsList[index + 2].projectsName}',
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          )
                        : (index * 5 + 2 < projectsList.length - 1
                            ? CusText(
                                '${projectsList[index * 5 + 2].projectsName}',
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              )
                            : Container()),
                  )
                ],
              ),
              onTap: () {},
            ),
          ],
        ),
        l: ScreenMgr.setAdapterSize(50.0),
        r: ScreenMgr.setAdapterSize(50.0),
      ),
      SizedBox(
        height: ScreenMgr.setAdapterSize(50.0),
      ),
      CusPadding(
        Row(
          children: [
            InkWell(
              child: Stack(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: index == 0
                          ? Image.network(
                              "${gnNetType == 0 ? URL.API_ADD_UPLOAD : URLIntranet.API_ADD_UPLOAD}${projectsList[index + 3].address}",
                              fit: BoxFit.fill,
                            )
                          : (index * 5 + 3 < projectsList.length - 1
                              ? Image.network(
                                  "${gnNetType == 0 ? URL.API_ADD_UPLOAD : URLIntranet.API_ADD_UPLOAD}${projectsList[index * 5 + 3].address}",
                                  fit: BoxFit.fill,
                                )
                              : Container())),
                  Positioned(
                    bottom: ScreenMgr.setAdapterSize(50.0),
                    left: ScreenMgr.setAdapterSize(30.0),
                    child: index == 0
                        ? CusText(
                            '${projectsList[index + 3].projectsName}',
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          )
                        : (index * 5 + 3 < projectsList.length - 1
                            ? CusText(
                                '${projectsList[index * 5 + 3].projectsName}',
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              )
                            : Container()),
                  )
                ],
              ),
              onTap: () {},
            ),
            SizedBox(
              width: ScreenMgr.setAdapterSize(40.0),
            ),
            InkWell(
              child: Stack(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: index == 0
                          ? Image.network(
                              "${gnNetType == 0 ? URL.API_ADD_UPLOAD : URLIntranet.API_ADD_UPLOAD}${projectsList[index + 4].address}",
                              fit: BoxFit.fill,
                            )
                          : (index * 5 + 4 < projectsList.length - 1
                              ? Image.network(
                                  "${gnNetType == 0 ? URL.API_ADD_UPLOAD : URLIntranet.API_ADD_UPLOAD}${projectsList[index * 5 + 4].address}",
                                  fit: BoxFit.fill,
                                )
                              : Container())),
                  Positioned(
                    bottom: ScreenMgr.setAdapterSize(50.0),
                    left: ScreenMgr.setAdapterSize(30.0),
                    child: index == 0
                        ? CusText(
                            '${projectsList[index + 4].projectsName}',
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          )
                        : (index * 5 + 4 < projectsList.length - 1
                            ? CusText(
                                '${projectsList[index * 5 + 4].projectsName}',
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              )
                            : Container()),
                  )
                ],
              ),
              onTap: () {},
            ),
          ],
        ),
        l: ScreenMgr.setAdapterSize(50.0),
        r: ScreenMgr.setAdapterSize(50.0),
      ),
      SizedBox(
        height: ScreenMgr.setAdapterSize(50.0),
      )
    ],
  );
}
