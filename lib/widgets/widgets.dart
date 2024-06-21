import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LargeTextField extends StatelessWidget {

  final double height;
  final String HintText;
  const LargeTextField({
    super.key,
    required this.HintText,
    required this.height
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: const BoxDecoration(
            border: Border(
                bottom: const BorderSide(color: Color(0xff32CD32), width: 3))),
        width: 390.w,
        height: height,
        child: Container(
          color: const Color(0xff32CD32),
          child: TextFormField(
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
            decoration:  InputDecoration(
              contentPadding:const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              ),
              labelStyle:const TextStyle(
                color: Color(0xff674FA3),
                fontSize: 14.0,
                fontWeight: FontWeight.normal,
              ),
              hintText:HintText,
              hintStyle: const TextStyle(
                color: Color(0XFFBF95A6),
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
              filled: true,
              fillColor:const Color(0xffdaf7D2), // Background color
              border:const OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Color(0xffFFE5F0)),
              ),
              enabledBorder:const OutlineInputBorder(
                borderSide:const BorderSide(width: 1, color: Color(0xffFFE5F0)),
              ),
              focusedBorder:const OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: Color(0xffFFE5F0),
                ),
              ),
            ),
            maxLines: 4,
          ),
        ),
      ),
    );
  }
}
