import 'package:blitz/pages/homescreen.dart';
import 'package:blitz/pages/onboarding/ask_location.dart';
import 'package:blitz/pages/onboarding/onboarding_name.dart';
import 'package:flutter/material.dart';
import 'package:otp_autofill/otp_autofill.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../../providers/account_provider.dart';
import '../../utils/vars.dart';

class OnboardingCode extends StatefulWidget {
  const OnboardingCode({super.key});

  @override
  State<OnboardingCode> createState() => _OnboardingCodeState();
}

class _OnboardingCodeState extends State<OnboardingCode> {
  TextEditingController otpController = OTPTextEditController(
    codeLength: 4,
    onCodeReceive: (code) {},
    otpInteractor: OTPInteractor(),
  )..startListenRetriever(
      (code) {
        final exp = RegExp(r'(\d{5})');
        return exp.stringMatch(code ?? '') ?? '';
      },
    );

  @override
  void initState() {
    super.initState();
    otpController.addListener(_onOtpChanged);
    // print(OTPInteractor().getAppSignature()); //get sms hash
  }

  @override
  void dispose() {
    otpController.removeListener(_onOtpChanged);
    otpController.dispose();
    super.dispose();
  }

  void _onOtpChanged() async {
    final otp = otpController.text;

    final auth = Provider.of<AccountProvider>(context, listen: false);
    if (otp.length == 4) {
      auth.verifyCode(otp).then((_) {
        if (auth.errorMessage.isEmpty) {
          if (auth.newClient) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const OnboardingName()),
            );
          } else {
            Permission.location.status.then((status) {
              if (status.isDenied || status.isPermanentlyDenied) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AskLocation()),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Homescreen()),
                );
              }
            });
          }
        }
      });
    } else {
      await auth.setError('');
    }
  }

  void _continueWithCode() {
    // Add the logic for the button tap here, if any.
    // For now, we can just call _onOtpChanged to mimic entering the OTP automatically.
    _onOtpChanged();
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
                          Icons.pin_rounded,
                          size: 30,
                          color: darkGrey,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Introdu codul primit",
                      style: TextStyle(
                        fontSize: 22,
                        fontFamily: 'SFProRounded',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "Ti-am trimis un cod de verificare prin SMS",
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'SFProRounded',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10, top: 25),
                      child: TextField(
                        controller: otpController,
                        keyboardType: TextInputType.number,
                        autofillHints: const [AutofillHints.oneTimeCode],
                        maxLength: 4,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none),
                          filled: true,
                          fillColor: const Color(0xFFE8E8E8),
                          hintText: 'Cod OTP',
                          counterText: '',
                        ),
                        style: const TextStyle(
                          fontSize: 17,
                          fontFamily: 'SFProRounded',
                          fontWeight: FontWeight.w600,
                        ),
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
                    onTap: _continueWithCode,
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
