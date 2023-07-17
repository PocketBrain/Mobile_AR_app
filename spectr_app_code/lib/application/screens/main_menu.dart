import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:spectr/application/screens/camera_screen.dart';

class MainPageScreen extends StatefulWidget {
  const MainPageScreen({Key? key}) : super(key: key);

  @override
  _MainPageScreenState createState() => _MainPageScreenState();
}

class _MainPageScreenState extends State<MainPageScreen> {
  int _currentIndex = 0;
  List<CameraDescription>? _cameras; // Список доступных камер
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    initializeCamera();
    _pageController = PageController(initialPage: _currentIndex);
  }

  // Инициализация камеры
  Future<void> initializeCamera() async {
    // Получение списка доступных камер
    _cameras = await availableCameras();
    setState(() {}); // Перестроить виджет после инициализации
  }

  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 200),
        curve: Curves.ease,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: [
          _buildPage(_currentIndex),
          _buildPage(_currentIndex),
          _buildPage(_currentIndex),
          //_buildPage(1),
          //_buildPage(2),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabSelected,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.square_favorites,
            ),
            label: 'Афиша',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.camera),
            label: 'Камера',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.person_circle,
            ),
            label: 'Аккаунт',
          ),
        ],
      ),
    );
  }

  Widget _buildPage(int index) {
    if (_cameras == null) {
      return Container(); // Пока камеры не инициализированы, отображаем пустой контейнер
    }

    switch (index) {
      case 0:
        return Page1();
      case 1:
        return CameraPage(
          camera: _cameras!.first, // Используем первую доступную камеру
        );
      case 2:
        return Page2();
      default:
        return Container();
    }
  }
}

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Text('Page 1'),
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Text('Page 2'),
      ),
    );
  }
}
