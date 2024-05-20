import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SocialButton extends StatefulWidget {
  final String imageURL;
  final String buttonText;
  const SocialButton({
    super.key,
    required this.imageURL,
    required this.buttonText,
  });

  @override
  State<SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<SocialButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // handle sign-in with Google
              },
              icon: Padding(
                padding: const EdgeInsets.only(left: 10, right: 15),
                child: CachedNetworkImage(
                  height: 24,
                  imageUrl: widget.imageURL,
                ),
              ),
              label: Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 15),
                child: Text(
                  widget.buttonText,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 19,
                      fontFamily: 'UberMoveMedium'),
                ),
              ),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, alignment: Alignment.centerLeft,
                backgroundColor: Colors.white,
                elevation: 0, // foreground colo
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(27.0),
                  side: const BorderSide(color: Colors.black, width: 1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
