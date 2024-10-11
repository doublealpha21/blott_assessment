import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:blott_asessment/views/news_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SvgPicture.asset('assets/message-notif.svg'),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Get the Most out of Blott',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.black,
                    ),
              ),
              const Icon(
                Icons.check_box,
                color: Colors.green,
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'Allow notifications to stay in the loop with\n your payments, requests and groups.',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: const Color(0xFF737373),
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 16,
          ),
          TextButton(
            onPressed: _onPressed,
            style: TextButton.styleFrom(
              backgroundColor: Colors.deepPurple,
            ),
            child: const Text(
              'Continue',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onPressed() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications().then((_) {
          _nextScreen();
        });
      } else {
        _nextScreen();
      }
    });
  }

  void _nextScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => NewsListScreen(),
      ),
    );
  }
}
