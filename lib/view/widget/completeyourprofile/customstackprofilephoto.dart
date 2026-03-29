import 'package:flutter/material.dart';

class CustomStackProfilePhoto extends StatelessWidget {
  const CustomStackProfilePhoto({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.grey[300],
          // backgroundImage:
          //     _imageFile != null ? FileImage(_imageFile!) : null,
          // child: _imageFile == null
          //     ? Icon(Icons.person, size: 50, color: Colors.grey[700])
          //     : null,
        ),
        const CircleAvatar(
          radius: 12.5,
          backgroundColor: Colors.brown,
          child: Icon(
            Icons.edit,
            color: Colors.white,
            size: 13,
          ),
        ),
      ],
    );
    // return Stack(
    //   children: [
    //     Container(
    //       margin: EdgeInsets.only(
    //         top: 20,
    //       ),
    //       width: 100,
    //       height: 100,
    //       decoration: BoxDecoration(
    //           color: Colors.grey.shade300,
    //           borderRadius: BorderRadius.circular(100),
    //           border: Border.all(width: 2, color: AppColor.primaryColor)),
    //       child: Icon(
    //         Icons.photo,
    //         size: 35,
    //         // color: Colors.grey,
    //       ),
    //     ),
    //     Positioned(
    //       bottom: 3,
    //       right: 3,
    //       child: Container(
    //         width: 25,
    //         height: 25,
    //         decoration: BoxDecoration(
    //           color: AppColor.primaryColor,
    //           border: Border.all(
    //             width: 2,
    //             color: Colors.white,
    //           ),
    //           borderRadius: BorderRadius.circular(25),
    //         ),
    //         child: Icon(
    //           Icons.edit,
    //           size: 13,
    //           color: Colors.white,
    //         ),
    //       ),
    //     ),
    //   ],
    // );
  }
}
