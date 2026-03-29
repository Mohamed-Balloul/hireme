import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hireme/interfaces/file_handler_interface.dart';

class SingleFile extends StatelessWidget {
  final PlatformFile? singleFile;
  final FileHandlerInterface
      fileHandler; // هنا السحر! نستقبل الانترفيس بدلاً من المتحكم
  const SingleFile(
      {super.key, required this.singleFile, required this.fileHandler});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    fileHandler.getFileIcon(singleFile!.extension),
                    Text(
                      singleFile!.name,
                      textAlign: TextAlign.center,
                      maxLines: 1, // سطر واحد فقط
                      overflow: TextOverflow
                          .ellipsis, // وضع نقاط (...) إذا كان الاسم طويلاً
                      style: const TextStyle(fontSize: 10, color: Colors.grey),
                    )
                  ],
                ),
              ),
              Expanded(
                child: IconButton(
                    icon: const Icon(
                      Icons.delete,
                      size: 18,
                    ),
                    onPressed: () => fileHandler.removeCvFile()),
              ),
            ],
          ),
        )
      ],
    );
  }
}
