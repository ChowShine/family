import 'package:flutter/material.dart';
import 'package:videochat_package/constants/constants.dart';
import 'package:videochat_package/library/flustars.dart';
import 'package:family_school/pages/my_page/fs_photo_album.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("${Constants.strImagesDir}fs_process.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: _buildBody(),
    ));
  }

  _buildBody() {
    return Stack(
      children: [
        Column(
          children: [
            _buildHead(),
            _buildCenter(),
            _buildBottom(),
          ],
        ),
        CusPadding(
          //选择班级弹出的列表下部 透明黑色
          Visibility(
            visible: isExpanded,
            child: InkWell(
              //退出展开
              onTap: () {
                setState(() {
                  isExpanded = false;
                });
              },
              child: Container(
                height: ScreenMgr.scrHeight -
                    ScreenMgr.scrHeight * 0.07 -
                    ScreenMgr.scrHeight * 0.04,
                color: Colors.black54,
              ),
            ),
          ),
          t: ScreenMgr.scrHeight * 0.07 + ScreenMgr.scrHeight * 0.04,
        ),
        CusPadding(
          //选择学期弹出的列表
          Visibility(
            visible: isExpanded,
            child: InkWell(
              onTap: () {},
              child: Container(
                  height: ScreenMgr.scrHeight * 0.28,
                  decoration: new BoxDecoration(
                    color: Color.fromARGB(255, 87, 159, 255),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(
                        ScreenMgr.setAdapterSize(30.0),
                      ),
                      bottomRight: Radius.circular(
                        ScreenMgr.setAdapterSize(30.0),
                      ),
                    ),
                  ),
                  child: ListView.builder(
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return CusPadding(
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CusText(
                                '2020-2021学期',
                                color: Colors.white,
                                size: 16.0,
                              ),
                              SizedBox(
                                height: 30,
                              )
                            ],
                          ),
                          l: ScreenMgr.scrWidth * 0.08);
                    },
                    shrinkWrap: true,
                  )),
            ),
          ),
          t: ScreenMgr.scrHeight * 0.07 + ScreenMgr.scrHeight * 0.04,
        ),
      ],
    );
  }

  _buildHead() {
    return CusPadding(
        Container(
            height: ScreenMgr.scrHeight * 0.07,
            color: isExpanded ? Color.fromARGB(255, 87, 159, 255) : null,
            child: InkWell(
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      iconSize: 30.0,
                      icon: Icon(
                        Icons.chevron_left,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Expanded(
                      flex: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CusText(
                            '2020-2021 学期',
                            size: 18.0,
                            color: Colors.white,
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                left: ScreenMgr.setAdapterSize(15.0)),
                            child: Image.asset(
                              isExpanded
                                  ? "${Constants.strImagesDir}fs_fold.png"
                                  : "${Constants.strImagesDir}fs_unfold.png",
                              scale: 2.5,
                            ),
                          ),
                        ],
                      )),
                  Spacer(),
                ],
              ),
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
                print(ScreenMgr.scrHeight);
                print(ScreenMgr.scrWidth);
              },
            )),
        t: ScreenMgr.scrHeight * 0.04);
  }

  _buildCenter() {
    return CusPadding(
      Stack(
        children: [
          Container(
            width: ScreenMgr.scrWidth,
          ),
          Container(
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Image.asset("${Constants.strImagesDir}fs_backdrop.png",
                      scale: 3.2),
                  Positioned(
                      bottom: 0,
                      child: Container(
                          height: ScreenMgr.setAdapterSize(1124.0),
                          width: ScreenMgr.setAdapterSize(750.0),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                              border: Border.all(color: Colors.black)),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(6.0),
                              child: Image.asset(
                                "${Constants.strImagesDir}fs_img.png",
                                fit: BoxFit.cover,
                              )))),
                ],
              )),
          Positioned(
            bottom: ScreenMgr.scrHeight * 0.05,
            left: ScreenMgr.scrWidth * 0.08,
            child: Stack(
              children: [
                Image.asset(
                  "${Constants.strImagesDir}fs_cover.png",
                  scale: 3.2,
                ),
                Positioned(
                  top: ScreenMgr.setAdapterSize(50.0),
                  left: ScreenMgr.setAdapterSize(50.0),
                  child: Row(
                    children: [
                      Container(
                          child: CusText(
                            '秀足球',
                            fontWeight: FontWeight.bold,
                            size: 20.0,
                          ),
                          decoration: UnderlineTabIndicator(
                              borderSide: BorderSide(
                                  width: 6,
                                  color: Color.fromARGB(255, 255, 185, 2)))),
                      CusText('/ 风雨操场'),
                    ],
                  ),
                ),
                Positioned(
                  bottom: ScreenMgr.setAdapterSize(50.0),
                  right: 0,
                  child: Row(
                    children: [
                      CusPadding(
                        Image.asset(
                          "${Constants.strImagesDir}fs_starts.png",
                          scale: 2.5,
                        ),
                        r: ScreenMgr.setAdapterSize(30.0),
                      ),
                      CusPadding(
                        Image.asset(
                          "${Constants.strImagesDir}fs_starts.png",
                          scale: 2.5,
                        ),
                        r: ScreenMgr.setAdapterSize(30.0),
                      ),
                      CusPadding(
                        Image.asset(
                          "${Constants.strImagesDir}fs_starts.png",
                          scale: 2.5,
                        ),
                        r: ScreenMgr.setAdapterSize(30.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      t: ScreenMgr.scrHeight * 0.06,
      b: ScreenMgr.scrHeight * 0.06,
    );
  }

  _buildBottom() {
    return CusPadding(
      Row(
        children: [
          Expanded(
              flex: 3,
              child: CusPadding(
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CusText('俞天骥小朋友',
                          size: 18.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      CusPadding(
                        Row(
                          children: [
                            CusText(
                              '本学期共获得',
                              size: 14.0,
                              color: Colors.white,
                            ),
                            CusText(
                              '28',
                              size: 30.0,
                              color: Color.fromARGB(255, 254, 239, 6),
                            ),
                            CusText(
                              '颗星星',
                              size: 14.0,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        t: ScreenMgr.setAdapterSize(20.0),
                      ),
                    ],
                  ),
                  l: ScreenMgr.scrWidth * 0.08)),
          Spacer(),
          Expanded(
            flex: 1,
            child: InkWell(
              child: Image.asset(
                "${Constants.strImagesDir}fs_more.png",
                scale: 2.5,
              ),
              onTap: () {
                RouteMgr().push(context, PhotoPage());
              },
            ),
          )
        ],
      ),
    );
  }
}
