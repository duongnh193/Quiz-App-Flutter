import 'package:flutter/material.dart';

import '../../login/component/rounded_input_field.dart';
import '../../../widgets/rounded_button.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text(
                  'Forgot Your Password?',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            child: const Text(
              'No worries, you just need to type your email address or username and we will send the verification code.',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          const RoundedInputField(
            hintText: 'Email Address',
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          RoundedButton(
            press: () {},
            text: 'RESET MY PASSWORD',
          )
        ],
      ),
    );
  }
}
