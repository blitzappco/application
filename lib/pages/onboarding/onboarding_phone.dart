import 'package:blitz/pages/onboarding/onboarding_code.dart';
import 'package:blitz/utils/vars.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/account_provider.dart';

class OnboardingPhone extends StatefulWidget {
  const OnboardingPhone({super.key});

  @override
  State<OnboardingPhone> createState() => _OnboardingPhoneState();
}

class _OnboardingPhoneState extends State<OnboardingPhone> {
  TextEditingController phoneNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    phoneNumberController.addListener(_onPhoneNumberChanged);
  }

  @override
  void dispose() {
    phoneNumberController.removeListener(_onPhoneNumberChanged);
    phoneNumberController.dispose();
    super.dispose();
  }

  void _onPhoneNumberChanged() {
    final phoneNumber = phoneNumberController.text;
    final auth = Provider.of<AccountProvider>(context, listen: false);

    if (phoneNumber.length != 10 && phoneNumber.isNotEmpty) {
      auth.setError("Numarul de telefon incorect.");
    } else {
      auth.setError('');
    }
  }

  Future<void> _continueWithPhoneNumber() async {
    final auth = Provider.of<AccountProvider>(context, listen: false);
    String phoneNumber = "+4${phoneNumberController.text}";

    if (phoneNumberController.text.length == 10) {
      auth.onboarding(phoneNumber).then((_) {
        if (auth.errorMessage == '') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const OnboardingCode()),
          );
        }
      });
    } else {
      await auth.setError("Număr de telefon incorect.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountProvider>(builder: (context, auth, _) {
      return Scaffold(
        body: Stack(
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(
                                context,
                              );
                            },
                            child: const Icon(Icons.arrow_back_ios_new),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: lightGrey,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Icon(
                          Icons.sms_rounded,
                          size: 30,
                          color: darkGrey,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "Continua cu numarul de telefon",
                      style: TextStyle(
                        fontSize: 22,
                        fontFamily: 'SFProRounded',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      "Logheaza-te sau inregistreaza-te cu numarul de telefon",
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'SFProRounded',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10, top: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            keyboardType: TextInputType.phone,
                            autofillHints: const [
                              AutofillHints.telephoneNumberNational
                            ],
                            controller: phoneNumberController,
                            textInputAction: TextInputAction.done,
                            cursorColor: Colors.black,
                            style: const TextStyle(
                              fontSize: 22,
                              fontFamily: 'UberMoveMedium',
                            ),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              fillColor: const Color(0xFFE8E8E8),
                              filled: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              auth.errorMessage,
                              style: const TextStyle(
                                fontSize: 17,
                                fontFamily: 'SFProDisplay',
                                fontWeight: FontWeight.w600,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  child: GestureDetector(
                    onTap: _continueWithPhoneNumber,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        color: blitzPurple,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            !auth.loading
                                ? const Text(
                                    'Continua',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'SFProRounded',
                                    ),
                                  )
                                : const SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
