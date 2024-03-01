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
              if (controller.isAuthorized.value)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Profile Name'),
                    TextField(
                      controller: controller.profileNameTextEditingController,
                      decoration:
                          const InputDecoration(hintText: 'Type your name'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: controller.tapNextButton,
                        child: const Text('Next'),
                      ),
                    ),
                  ],
                ),
              if (!controller.isAuthorized.value)
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
              if (controller.isCodeSent.value && !controller.isAuthorized.value)
                Pinput(
                  length: 6,
                  onCompleted: controller.onSubmittedSmsCode,
                  focusNode: controller.pinPutFocusNode,
                ),
              if (!controller.isCodeSent.value &&
                  !controller.isAuthorized.value)
                ElevatedButton(
                  onPressed: controller.onTapSignUpButton,
                  child: const Text('Sign Up'),
                ),
              const Spacer(
                flex: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
