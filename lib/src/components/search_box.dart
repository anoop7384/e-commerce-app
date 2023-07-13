import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eshop/src/screens/home/components/camera_app.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({
    Key? key,
    this.onChanged,
  }) : super(key: key);

  final ValueChanged? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        textCapitalization: TextCapitalization.words,
        onChanged: onChanged,
        style: const TextStyle(color: Colors.blue),
        cursorColor: Colors.blue,
        decoration: const InputDecoration(
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintText: 'Search',
            hintStyle: TextStyle(color: Colors.blue),
            prefixIcon: Icon(
              CupertinoIcons.search,
              color: Colors.blue,
            ),
            // suffixIcon: InkWell(
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => CameraApp()),
            //     );
            //   },
            //   child: CircleAvatar(
            //     backgroundColor: Colors.white,
            //     child: Center(
            //       child: Icon(
            //         CupertinoIcons.camera,
            //         color: Colors.blue,
            //         size: 35,
            //       ),
            //     ),
            //   ),
            // )
            ),
      ),
    );
  }
}
