import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareProductButton extends StatelessWidget {
  final String productId;

  const ShareProductButton({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.share, size: 18),
      ),
      onPressed: () async {
        final productLink =
            'https://humavolve-bc582.web.app/product/$productId';
        final String shareText = 'Look at this Product : $productLink';
        await SharePlus.instance.share(
          ShareParams(
            text: shareText,
            subject: 'Check out this product on Huma Volve!',
          ),
        );
      },
    );
  }
}
