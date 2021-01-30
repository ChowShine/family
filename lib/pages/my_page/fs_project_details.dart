import 'package:flutter/material.dart';
import 'package:videochat_package/constants/constants.dart';
import 'package:videochat_package/library/flustars.dart';

class DetailsPage extends StatefulWidget {
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
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
      body: _buildBody(),
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
                CusText(
                  '秀足球',
                  fontWeight: FontWeight.bold,
                  size: 20.0,
                ),
                CusText('/ 风雨操场'),
              ],
            ),
            SizedBox(height: ScreenMgr.setAdapterSize(100.0)),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
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
                            '2020-2021学期',
                            size: 18.0,
                          ),
                          Image.asset(
                            "${Constants.strImagesDir}fs_starts.png",
                            scale: 2,
                          )
                        ],
                      ),
                      SizedBox(
                        height: ScreenMgr.setAdapterSize(50.0),
                      ),
                      GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                "${Constants.strImagesDir}fs_img.png",
                              ));
                        },
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            //每个孩子的横轴与主轴范围的比率
                            childAspectRatio: 2 / 2,
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
                },
                shrinkWrap: true,
              ),
            ),
          ],
        ),
        l: ScreenMgr.setAdapterSize(50.0),
        r: ScreenMgr.setAdapterSize(50.0),
      ),
    );
  }
}
