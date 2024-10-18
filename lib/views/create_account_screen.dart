import 'package:blott_asessment/services/user_data.dart';
import 'package:blott_asessment/views/get_started_screen.dart';
import 'package:flutter/material.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  bool _isButtonEnabled = false;

  void _saveNameAndNavigate() async {
    await UserDataManager.saveFirstName(_firstNameController.text);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const GetStartedScreen(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _firstNameController.addListener(_updateButtonState);
    _lastNameController.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    _firstNameController.removeListener(_updateButtonState);
    _lastNameController.removeListener(_updateButtonState);
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  void _updateButtonState() {
    setState(() {
      _isButtonEnabled = _firstNameController.text.isNotEmpty &&
          _lastNameController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Legal Name',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 33,
              ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text(
            'We need to know a bit about you so that we can create your account.',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: const Color(0xFF737373),
                  fontWeight: FontWeight.w400,
                  fontSize: 19,
                ),
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            controller: _firstNameController,
            keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              hintText: 'First name',
              border: UnderlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your first name';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            controller: _lastNameController,
            keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              hintText: 'Last name',
              border: UnderlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your last name';
              }
              return null;
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        onPressed: _isButtonEnabled ? _saveNameAndNavigate : null,
        backgroundColor:
            _isButtonEnabled ? const Color(0xFF523AE4) : Colors.grey,
        child: const Icon(
          Icons.arrow_forward_ios_rounded,
          color: Colors.white,
        ),
      ), //
    );
  }
}
