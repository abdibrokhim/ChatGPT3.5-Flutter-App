import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:gallery_saver/gallery_saver.dart';

class DownloadingDialog extends StatefulWidget {
  const DownloadingDialog({Key? key, required this.imUrl}) : super(key: key);

  final String imUrl;

  @override
  State<DownloadingDialog> createState() => _DownloadingDialogState();
}

class _DownloadingDialogState extends State<DownloadingDialog> {
  late final Dio dio;
  double progress = 0.0;

  void startDownloading() async {
    String url = widget.imUrl;

    // String fileName = 'im.jpg';

    GallerySaver.saveImage(url, albumName: 'ChatGPT').then((bool? success) {});

    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    startDownloading();
  }

  @override
  Widget build(BuildContext context) {
    String downloadingProgress = (progress * 100).toInt().toString();

    return AlertDialog(
      backgroundColor: Colors.black,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(
            value: progress,
            strokeWidth: 5,
            color: Colors.white,
          ),
          const SizedBox(height: 20),
          Text(
            "Downloading: $downloadingProgress%",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
