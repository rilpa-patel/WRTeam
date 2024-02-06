import 'package:flutter/material.dart';
import 'package:wrteam/Screens/login_screen.dart';

import '../Services/localStorage.dart';
import 'home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  bool? userLogin;
  List<Map<String, String>> onboardingData = [
    {
      'image': 'assets/images/image.jpg',
      'title': 'Welcome to Our App',
      'description':
          'WRTeam has a creative and dedicated group of developers who are mastered in Apps development and Web.',
    },
    {
      'image': 'assets/images/image.jpg',
      'title': 'Explore Exciting Features',
      'description':
          'WRTeam has a creative and dedicated group of developers who are mastered in Apps development and Web.',
    },
    {
      'image': 'assets/images/image.jpg',
      'title': 'Get Started Now',
      'description':
          'WRTeam has a creative and dedicated group of developers who are mastered in Apps development and Web.',
    },
  ];

@override
  void didChangeDependencies() async{
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
     LocalStorage _loginvarification = LocalStorage();

    userLogin = await _loginvarification.readLogin();
   
  }


  void _nextPage() {
    if (_currentPage < onboardingData.length - 1) {
      pageController.nextPage(
          duration: const Duration(milliseconds: 500), curve: Curves.ease);
      setState(() {
        _currentPage++;
      });
    } else {
      userLogin!
          ? Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            )
          : Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ),
            );
    }
  }

  void _prevPage() {
    if (_currentPage > 0) {
      pageController.previousPage(
          duration: const Duration(milliseconds: 500), curve: Curves.ease);
      setState(() {
        _currentPage--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: PageView.builder(
              controller: pageController,
              itemCount: onboardingData.length,
              itemBuilder: (context, index) {
                return OnboardingPage(
                  image: onboardingData[index]['image']!,
                  title: onboardingData[index]['title']!,
                  description: onboardingData[index]['description']!,
                );
              },
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: _prevPage,
                child: const Text('Previous'),
              ),
              ElevatedButton(
                onPressed: _nextPage,
                child: Text(_currentPage < onboardingData.length - 1
                    ? 'Next'
                    : 'Get Started'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  OnboardingPage({
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, height: 200),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
