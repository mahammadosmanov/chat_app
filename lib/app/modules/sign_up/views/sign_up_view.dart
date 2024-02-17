import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:pinput/pinput.dart';

import '../controllers/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SignUpView'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(
                flex: 3,
              ),
              InternationalPhoneNumberInput(
                onInputChanged: (PhoneNumber value) {
                  controller.onInputChange(value.phoneNumber!);
                },
                inputDecoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Your number',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              if (controller.codeSent.value)  Pinput(length: 6,
                onCompleted: controller.onSubmittedSmsCodeEnter
              ,focusNode: controller.pinPutFocusNode,),
              if (!controller.codeSent.value)
                ElevatedButton(
                  onPressed: controller.onTapSignUpButton,
                  child: const Text('Sign Up'),
                ),
              const Spacer(
                flex: 5,
              )
            ],
          ),
        ),
      ),
    );
  }
}
