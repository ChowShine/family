import 'package:flutter/material.dart';
import 'package:videochat_package/constants/constants.dart';
import 'file:///D:/work/003007_yt_videochat_app_flutter/trunk/apps/family_school/lib/pages/provider/fs_growth_details_provider.dart';
import 'package:videochat_package/constants/token/family_token.dart';
import '../common/common_param.dart';
import '../common/ImgVideoHelper.dart';
import 'package:videochat_package/constants/customMgr/dlgMgr.dart';

class DetailsPage extends StatefulWidget {
  final int id;
  final String projectsName;
  final String stationName;
  DetailsPage(this.id, this.projectsName, this.stationName);
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  DetailsProvider provider = DetailsProvider();
  List<String> imgList = [];
  List<ImageVideoHelper> _imgVideoHelperList = []; //显示图片和视频
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.id);
    Future.delayed(Duration.zero, () async {
      await this.provider.getDetails(widget.id);
      this.provider.detailsList.forEach((item1) {
        imgList = [];
        item1.address.forEach((item2) {
          imgList.add('${gnNetType == 0 ? URL.API_ADD_UPLOAD : URLIntranet.API_ADD_UPLOAD}${item2.address}');
        });
        _imgVideoHelperList.add(new ImageVideoHelper(imgList, context));
      });
      setState(() {});
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
          "详情",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0.0,
      ),
      body: this.provider.detailsList == null ? LoadingDialog() : _buildBody(),
      resizeToAvoidBottomInset: false,
    );
  }

  _buildBody() {
    return Container(
      color: Colors.white,
      child: CusPadding(
        Column(
          children: [
            SizedBox(height: ScreenMgr.setAdapterSize(50.0)),
            Row(
              children: [
                Container(
                    child: CusText(
                      '${widget.projectsName}',
                      fontWeight: FontWeight.bold,
                      size: 20.0,
                    ),
                    decoration: UnderlineTabIndicator(
                        borderSide: BorderSide(width: 6, color: Color.fromARGB(255, 255, 185, 2)))),
                CusText('/ ${widget.stationName}'),
              ],
            ),
            SizedBox(height: ScreenMgr.setAdapterSize(100.0)),
            Expanded(
              child: ScrollConfiguration(
                behavior: ScrollBehavior(),
                child: ListView.builder(
                  itemCount: this.provider.detailsList.length,
                  itemBuilder: (context, index) {
                    return buildContent(index, this.provider.detailsList);
                  },
                  shrinkWrap: true,
                ),
              ),
            ),
          ],
        ),
        l: ScreenMgr.setAdapterSize(50.0),
        r: ScreenMgr.setAdapterSize(50.0),
      ),
    );
  }

  buildContent(index, detailsList) {
    return Column(
      children: [
        Divider(
          height: 1.0,
          color: Color.fromARGB(248, 248, 248, 248),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CusText(
              '${detailsList[index].semesterName}',
              size: 18.0,
            ),
            detailsList[index].score == 1
                ? Image.asset(
                    "${Constants.strImagesDir}fs_starts.png",
                    scale: 2.5,
                  )
                : (detailsList[index].score == 2
                    ? Row(
                        children: [
                          Image.asset(
                            "${Constants.strImagesDir}fs_starts.png",
                            scale: 2.5,
                          ),
                          Image.asset(
                            "${Constants.strImagesDir}fs_starts.png",
                            scale: 2.5,
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset(
                            "${Constants.strImagesDir}fs_starts.png",
                            scale: 2.5,
                          ),
                          SizedBox(
                            width: ScreenMgr.setAdapterSize(10.0),
                          ),
                          Image.asset(
                            "${Constants.strImagesDir}fs_starts.png",
                            scale: 2.5,
                          ),
                          SizedBox(
                            width: ScreenMgr.setAdapterSize(10.0),
                          ),
                          Image.asset(
                            "${Constants.strImagesDir}fs_starts.png",
                            scale: 2.5,
                          ),
                        ],
                      ))
          ],
        ),
        SizedBox(
          height: ScreenMgr.setAdapterSize(50.0),
        ),
        GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: detailsList[index].address.length,
          itemBuilder: (context, indexImg) {
            return InkWell(
              onTap: () async {
                _imgVideoHelperList[index].preView(indexImg);
              },
              // child: ClipRRect(
              //     borderRadius: BorderRadius.circular(8.0),
              //     child: Image.network(
              //       "${gnNetType == 0 ? URL.API_ADD_UPLOAD : URLIntranet.API_ADD_UPLOAD}${detailsList[index].address[indexImg].address}",
              //       fit: BoxFit.cover,
              //     )
              // ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Container(child: _imgVideoHelperList[index].buildImgVideo(indexImg)),
              ),
            );
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //每个孩子的横轴与主轴范围的比率
              childAspectRatio: 1 / 1,
              crossAxisCount: 3,
              //垂直单个子Widget之间间距
              mainAxisSpacing: 5,
              //水平单个子Widget之间间距
              crossAxisSpacing: 10),
        ),
        SizedBox(
          height: ScreenMgr.setAdapterSize(80.0),
        ),
      ],
    );
  }
}
