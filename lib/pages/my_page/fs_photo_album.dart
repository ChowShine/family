import 'package:flutter/material.dart';
import 'package:videochat_package/constants/constants.dart';
import 'package:videochat_package/library/flustars.dart';
import 'package:family_school/pages/my_page/fs_project_details.dart';

class PhotoPage extends StatefulWidget {
  @override
  _PhotoPageState createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {
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
      body: _buildBody(),
      resizeToAvoidBottomInset: false,
    );
  }

  _buildBody() {
    return Container(
        child: ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Column(
          children: [
            CusPadding(
              InkWell(
                child: Stack(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          "${Constants.strImagesDir}fs_img.png",
                        )),
                    Positioned(
                      bottom: ScreenMgr.setAdapterSize(50.0),
                      left: ScreenMgr.setAdapterSize(30.0),
                      child: CusText(
                        'IT小画家',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                onTap: () {
                  RouteMgr().push(context, DetailsPage());
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
                  Expanded(
                    child: InkWell(
                      child: Stack(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                "${Constants.strImagesDir}fs_img.png",
                              )),
                          Positioned(
                            bottom: ScreenMgr.setAdapterSize(50.0),
                            left: ScreenMgr.setAdapterSize(30.0),
                            child: CusText(
                              'IT小画家',
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                      onTap: () {},
                    ),
                  ),
                  SizedBox(
                    width: ScreenMgr.setAdapterSize(40.0),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Stack(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                "${Constants.strImagesDir}fs_img.png",
                              )),
                          Positioned(
                            bottom: ScreenMgr.setAdapterSize(50.0),
                            left: ScreenMgr.setAdapterSize(30.0),
                            child: CusText(
                              'IT小画家',
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                      onTap: () {},
                    ),
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
      },
      shrinkWrap: true,
    ));
  }
}
