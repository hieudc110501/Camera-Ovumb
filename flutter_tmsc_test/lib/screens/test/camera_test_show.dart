// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:async';
// import 'dart:io';

// import 'package:camera/camera.dart';
// import 'package:edge_detection/edge_detection.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_tmsc_test/utils/primary_color.dart';
// import 'package:flutter_tmsc_test/widgets/title_text.dart';

// // mở camera và flash
// class CameraTestShow extends StatefulWidget {
//   final List<CameraDescription>? cameras;
//   const CameraTestShow({
//     Key? key,
//     this.cameras,
//   }) : super(key: key);

//   @override
//   State<CameraTestShow> createState() => _CameraTestShowState();
// }

// class _CameraTestShowState extends State<CameraTestShow> {
//   late CameraController controller;
//   XFile? pictureFile;
//   late Timer _timer;
//   int baseTime = 3;
//   bool isRun = false;

//   //độ zoom hiện tại và ban đầu
//   // double _currentScale = 4;
//   final double _baseScale = 4;

//   @override
//   void initState() {
//     super.initState();
//     controller = CameraController(
//       widget.cameras![0],
//       ResolutionPreset.high,
//     );

//     //khởi tạo camera và bật đèn flash
//     controller.initialize().then((_) {
//       if (!mounted) {
//         return;
//       }
//       controller.setZoomLevel(_baseScale);
//       controller.setFlashMode(FlashMode.torch);
//       controller.startImageStream(_onCameraStream);

//       setState(() {});
//     });
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (!controller.value.isInitialized) {
//       return const SizedBox(
//         child: Center(
//           child: CircularProgressIndicator(),
//         ),
//       );
//     }
//     return _cameraPreviewWidget();
//   }

//   void onViewFinderTap(
//       TapDownDetails details, BoxConstraints constraints) async {
//     final CameraController cameraController = controller;

//     final Offset offset = Offset(
//       details.localPosition.dx / constraints.maxWidth,
//       details.localPosition.dy / constraints.maxHeight,
//     );
//     cameraController.setExposurePoint(offset);
//     cameraController.setFocusPoint(offset);
//   }

//   // chụp ảnh màn hình
//   void onTakePicture() async {
//     await controller.setFocusMode(FocusMode.auto);
//     const oneSec = Duration(seconds: 1);
//     _timer = Timer.periodic(
//       oneSec,
//       (Timer timer) {
//         if (baseTime == 0) {
//           setState(() {
//             timer.cancel();
//             controller.takePicture().then((XFile xfile) {
//               if (mounted) {
//                 showDialog(
//                   context: context,
//                   builder: (context) => AlertDialog(
//                     content: SizedBox(
//                       width: 200,
//                       height: 200,
//                       child: CircleAvatar(
//                         backgroundImage: Image.file(File(xfile.path)).image,
//                       ),
//                     ),
//                   ),
//                 );
//               }
//             });
//           });
//         } else {
//           setState(() {
//             baseTime--;
//           });
//         }
//       },
//     );
//   }

//   void _onCameraStream(CameraImage cameraImage) {
//     // xử lý ảnh cameraImage ở đây
//     // nếu ảnh đã lấy đủ nét và khớp với hình ảnh, thực hiện chụp ảnh
//     bool isImageReady = true;
//     if (isImageReady) {
//       controller.takePicture().then((XFile file) {
//         // xử lý ảnh file ở đây
//         if (mounted) {
//           showDialog(
//             context: context,
//             builder: (context) => AlertDialog(
//               content: SizedBox(
//                 width: 200,
//                 height: 200,
//                 child: CircleAvatar(
//                   backgroundImage: Image.file(File(file.path)).image,
//                 ),
//               ),
//             ),
//           );
//         }
//       });
//     }
//   }

//   // hiện camera và button
//   Widget _cameraPreviewWidget() {
//     return Scaffold(
//       backgroundColor: primaryColor,
//       body: Listener(
//         // onPointerDown: (_) => _pointers++,
//         // onPointerUp: (_) => _pointers--,
//         child: AspectRatio(
//           aspectRatio: 1 / controller.value.aspectRatio,
//           child: Stack(
//             alignment: Alignment.center,
//             children: [
//               CameraPreview(
//                 controller,
//                 child: LayoutBuilder(
//                   builder: (BuildContext context, BoxConstraints constraints) {
//                     return GestureDetector(
//                       behavior: HitTestBehavior.opaque,
//                       // onScaleStart: _handleScaleStart,
//                       // onScaleUpdate: _handleScaleUpdate,
//                       onTapDown: (TapDownDetails details) {
//                         onViewFinderTap(details, constraints);
//                         onTakePicture();
//                       },
//                     );
//                   },
//                 ),
//               ),
//               Positioned(
//                 top: 200,
//                 child: TitleText(
//                   text: baseTime != 0 ? '$baseTime' : '',
//                   fontWeight: FontWeight.w700,
//                   size: 70,
//                   color: primaryColorRose500,
//                 ),
//               ),
//               GestureDetector(
//                 onTapDown: (TapDownDetails details) {
//                   onTakePicture();
//                 },
//                 child: Image.asset(
//                   'assets/images/camera_border.png',
//                   scale: 0.8,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
