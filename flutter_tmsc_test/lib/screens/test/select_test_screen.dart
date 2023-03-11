import 'dart:math';
import 'package:edge_detection/edge_detection.dart';
import 'package:edge_detection_example/utils/primary_color.dart';
import 'package:edge_detection_example/utils/primary_font.dart';
import 'package:edge_detection_example/widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

// màn hình chọn que test
class SelectTestScreen extends StatefulWidget {
  static const routeName = 'select-test-screen';
  const SelectTestScreen({super.key});

  @override
  State<SelectTestScreen> createState() => _SelectTestScreenState();
}

class _SelectTestScreenState extends State<SelectTestScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late AnimationController controller1;
  late Animation<double> animation;
  late Animation<double> animation1;
  String? _imagePath;

  //Mở cameca và chụp để lấy image path
  Future<void> getImage() async {
    bool isCameraGranted = await Permission.camera.request().isGranted;
    if (!isCameraGranted) {
      isCameraGranted =
          await Permission.camera.request() == PermissionStatus.granted;
    }
    if (!isCameraGranted) {
      // Have not permission to camera
      return;
    }

    // Generate filepath for saving
    String imagePath = join((await getApplicationSupportDirectory()).path,
        "${(DateTime.now().millisecondsSinceEpoch / 1000).round()}.jpeg");

    try {
      //Make sure to await the call to detectEdge.
      await EdgeDetection.detectEdge(
        imagePath,
        canUseGallery: true,
        androidScanTitle:
            'Quét que Test', // use custom localizations for android
        androidCropTitle: 'Cắt',
        androidCropBlackWhiteTitle: 'Black White',
        androidCropReset: 'Reset',
      );
    } catch (e) {
      print(e);
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _imagePath = imagePath;
      saveImage();
    });
  }

  //Lấy file ảnh lưu vào gallery
  Future<void> saveImage() async {
    await GallerySaver.saveImage(_imagePath!);
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    controller1 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    setRotation(15);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    controller1.dispose();
  }

  //animation
  void setRotation(int degrees) {
    final angle = degrees * pi / 180;
    animation = Tween<double>(begin: -0.1, end: angle).animate(controller);
    animation1 = Tween<double>(begin: -0.1, end: angle).animate(controller1);
  }

  bool test1Selected = false;
  bool test2Selected = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.centerLeft,
          child: TitleText(
            text: 'Test',
            fontWeight: FontWeight.w600,
            size: 18,
            color: primaryColorRose400,
          ),
        ),
        backgroundColor: primaryColor,
        shadowColor: primaryColor,
        bottomOpacity: 0.1,
        elevation: 3,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Image.asset('assets/icons/right_home_icon.png'),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: ListView(
            children: [
              const SizedBox(height: 20),
              Column(
                children: [
                  const TitleText(
                    text: 'Chọn que Test',
                    fontWeight: FontWeight.w700,
                    size: 24,
                    color: primaryColorRose400,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: SizedBox(
                      height: 50,
                      child: test1Selected
                          ? RichText(
                              text: const TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Còn ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      color: primaryColorGrey700,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '20 lượt ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color: primaryColorRose400,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'sử dụng que thử này',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      color: primaryColorGrey700,
                                    ),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.start,
                            )
                          : Text(
                              'Lựa chọn que phù hợp với mục đích của bạn',
                              style: PrimaryFont.regular(16, FontWeight.w400)
                                  .copyWith(
                                color: primaryColorGrey700,
                              ),
                              textAlign: TextAlign.center,
                            ),
                    ),
                  ),
                ],
              ),
              Container(
                color: primaryColor,
                height: size.height * 0.35,
                width: size.width,
                child: Stack(
                  children: [
                    Positioned(
                      top: 5,
                      child: AnimatedBuilder(
                        animation: animation,
                        builder: (context, child) => Transform.scale(
                          scale: animation.value + 1.1,
                          child: Transform.rotate(
                            angle: animation.value,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  // nếu bằng true thì đảo ngược lại, fasle thì chạy lên
                                  test1Selected
                                      ? controller.reverse(from: 15)
                                      : controller.forward(from: 0);

                                  test1Selected = !test1Selected;

                                  //nếu test2 cũng đang được chọn thì set về false đồng thời đảo lại
                                  if (test2Selected) {
                                    test2Selected = !test2Selected;
                                    controller1.reverse(from: 15);
                                  }
                                });
                              },
                              hoverColor: Colors.transparent,
                              child: SizedBox(
                                width: size.width * 0.8,
                                child: Image.asset(
                                  test2Selected
                                      ? 'assets/images/unselect_que_test.png'
                                      : 'assets/images/que_test_1.png',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      child: AnimatedBuilder(
                        animation: animation1,
                        builder: (context, child) => Transform.scale(
                          scale: animation1.value + 1.1,
                          child: Transform.rotate(
                            angle: animation1.value,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  test2Selected
                                      ? controller1.reverse(from: 15)
                                      : controller1.forward(from: 0);

                                  test2Selected = !test2Selected;
                                  if (test1Selected) {
                                    test1Selected = !test1Selected;
                                    controller.reverse(from: 15);
                                  }
                                });
                              },
                              hoverColor: Colors.transparent,
                              child: SizedBox(
                                width: size.width * 0.8,
                                child: Image.asset(
                                  test1Selected
                                      ? 'assets/images/unselect_que_test.png'
                                      : 'assets/images/que_test_2.png',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        test2Selected
                            ? 'assets/images/dot_test_unselect.png'
                            : 'assets/images/dot_test_que_1.png',
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const TitleText(
                        text: 'Que thử rụng trứng',
                        fontWeight: FontWeight.w500,
                        size: 12,
                        color: primaryColorGrey600,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset(
                        test1Selected
                            ? 'assets/images/dot_test_unselect.png'
                            : 'assets/images/dot_test_que_2.png',
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const TitleText(
                        text: 'Que thử thai',
                        fontWeight: FontWeight.w500,
                        size: 12,
                        color: primaryColorGrey600,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.06),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.2),
                child: SizedBox(
                  height: size.height * 0.1,
                )
              ),
              SizedBox(height: size.height * 0.02),
              // const SizedBox(
              //   height: 30,
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              primaryColorRose600.withOpacity(
                                  (test1Selected || test2Selected) ? 1 : 0.6),
                              primaryColorRose400.withOpacity(
                                  (test1Selected || test2Selected) ? 1 : 0.6),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(38),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.pink.withOpacity(0.1),
                              spreadRadius: 4,
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            )
                          ]),
                      child: ElevatedButton(
                        onPressed: () async {
                          (test1Selected || test2Selected) ? getImage() : null;
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent),
                          shape:
                              MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(38),
                          )),
                          elevation: MaterialStateProperty.all(0),
                          fixedSize: MaterialStateProperty.all(
                            Size(
                              size.width,
                              size.height * 0.065,
                            ),
                          ),
                          //foregroundColor: MaterialStateProperty.all(primaryColorRoseTitleText),
                          textStyle: MaterialStateProperty.all(
                            PrimaryFont.semibold(16, FontWeight.w600)
                                .copyWith(color: primaryColorGreyText),
                          ),
                        ),
                        child: const Text('Xác nhận'),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Hủy',
                        style: PrimaryFont.semibold(
                          16,
                          FontWeight.w400,
                        ).copyWith(
                          decoration: TextDecoration.underline,
                          color: primaryColorRose400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
