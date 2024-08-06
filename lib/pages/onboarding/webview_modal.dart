import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsOfUse {
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      useSafeArea: true,
      showDragHandle: true,
      backgroundColor: Colors.white,
      builder: (builder) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.85,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20.0),
                  topRight: const Radius.circular(20.0))),
          child: WebViewWidget(
            controller: WebViewController()
              ..loadRequest(
                Uri.parse('https://terms-of-use-pied.vercel.app'),
              ),
          ),
        );
      },
    );
  }
}
