import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({
    Key? key,
    required this.camera,
  }) : super(key: key);

  final CameraDescription camera;

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool _flashEnabled = false;
  bool _isFrontCamera = false;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.high,
    );
    _initializeController();
  }

  Future<void> _initializeController() async {
    try {
      await _controller.initialize();
      setState(() {});
    } catch (e) {
      print('Failed to initialize camera controller: $e');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          if (_controller.value.isInitialized)
            Positioned.fill(
              child: CameraPreview(_controller),
            )
          else
            const Center(child: CircularProgressIndicator()),
          Positioned(
            bottom: 24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(
                    _flashEnabled ? Icons.flash_on : Icons.flash_off,
                  ),
                  onPressed: _toggleFlash,
                ),
                ElevatedButton(
                  onPressed: _takePicture,
                  child: Icon(Icons.camera),
                ),
                IconButton(
                  icon: Icon(Icons.switch_camera),
                  onPressed: _toggleCamera,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _toggleFlash() {
    if (!_controller.value.isInitialized) {
      return;
    }
    final newFlashMode = _flashEnabled ? FlashMode.off : FlashMode.torch;
    _setFlashMode(newFlashMode);
    setState(() {
      _flashEnabled = !_flashEnabled;
    });
  }

  Future<void> _setFlashMode(FlashMode flashMode) async {
    try {
      await _controller.setFlashMode(flashMode);
    } catch (e) {
      print('Failed to set flash mode: $e');
    }
  }

  void _toggleCamera() {
    if (!_controller.value.isInitialized) {
      return;
    }
    final newCameraLensDirection =
        _isFrontCamera ? CameraLensDirection.back : CameraLensDirection.front;
    _initializeControllerFuture = _controller
        .dispose()
        .then((_) => _initializeCamera(newCameraLensDirection));
    setState(() {
      _isFrontCamera = !_isFrontCamera;
    });
  }

  Future<void> _initializeCamera(
      CameraLensDirection cameraLensDirection) async {
    final cameras = await availableCameras();
    final camera = cameras.firstWhere(
      (cam) => cam.lensDirection == cameraLensDirection,
      orElse: () => cameras.first,
    );
    _controller = CameraController(camera, ResolutionPreset.high);
    _initializeController();
  }

  Future<void> _takePicture() async {
    if (!_controller.value.isInitialized) {
      return;
    }
    try {
      final image = await _controller.takePicture();
      // Обработка снимка
      print('Picture saved to ${image.path}');
    } catch (e) {
      print('Error capturing picture: $e');
    }
  }
}
