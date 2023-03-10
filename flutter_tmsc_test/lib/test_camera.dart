// import 'dart:ui';

// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'dart:io';
// import 'package:image/image.dart' as img;
// import 'package:tflite/tflite.dart';

// class CameraScanTest extends StatefulWidget {
//   const CameraScanTest({super.key});

//   @override
//   State<CameraScanTest> createState() => _CameraScanTestState();
// }

// class _CameraScanTestState extends State<CameraScanTest> {
//   CameraController? _cameraController;
//   XFile? _imageFile;
//   bool _isDetecting = false;

//   @override
//   void initState() {
//     super.initState();

//     // Lấy danh sách camera có sẵn trên thiết bị
//     availableCameras().then((cameras) {
//       if (cameras.isNotEmpty) {
//         // Sử dụng camera đầu tiên trong danh sách
//         _cameraController =
//             CameraController(cameras.first, ResolutionPreset.high);
//         _cameraController!.initialize().then((_) {
//           if (!mounted) {
//             return;
//           }
//           setState(() {});
//         });
//       }
//     });

//     // Load model edge detection
//     loadModel().then((value) {});
//   }

//   Future<void> loadModel() async {
//     try {
//       String? res = await Tflite.loadModel(
//         model: "assets/edgedetection.tflite",
//         labels: "assets/labels.txt",
//       );
//       print(res);
//     } on PlatformException {
//       print("Failed to load model.");
//     }
//   }

//   Future<void> detectEdges(CameraImage image) async {
//     if (_isDetecting) return;
//     _isDetecting = true;

//     try {
//       // Convert image từ CameraImage sang image dart:ui để đưa vào model edge detection
//       img.Image imgInput = img.Image.fromBytes(
//         width: image.width,
//         height: image.height,
//         bytes: image.planes[0].bytes.buffer,
//         format: img.Format.uint16
//       );
//       img.Image imgConvert = img.copyResize(imgInput, width: 512, height: 512);
//       final input = imgConvert.data!.buffer.asUint8List();

//       // Gọi model edge detection để xác định các điểm edge
//       var output = await Tflite.runModelOnBinary(
//         binary: input,
//       );

//       // Convert output từ byte list sang image để hiển thị lên màn hình
//       img.Image imgOutput = img.Image.fromBytes(
//         width: 512,
//         height: 512,
//         bytes: output,
//       );

//       setState(() {
//         _imageFile = XFile.fromData(img.encodeJpg(imgOutput));
//         _isDetecting = false;
//       });
//     } catch (e) {
//       print("Failed to detect edges: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
