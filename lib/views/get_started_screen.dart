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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: SvgPicture.asset('assets/message-notif.svg'),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        children: [
                          TextSpan(text: 'Get the most out of Blott '),
                          WidgetSpan(
                            child: Icon(Icons.check_box_rounded,
                                color: Colors.green, size: 24),
                          ),
                        ],
                      ),
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
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: _onPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: Text(
                    'Continue',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
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
        builder: (context) => const NewsListScreen(),
      ),
    );
  }
}
