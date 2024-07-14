import '../utils/colors.dart';
import '../utils/text_sizes.dart';
import 'package:flutter/material.dart';

Text headerText(String text, Color color) {
  return Text(
    text,
    style: TextStyle(
      fontSize: headerSize,
      fontWeight: FontWeight.w600,
      color: color,
    ),
  );
}

Text titleText(String text, Color color, TextAlign alignment) {
  return Text(
    text,
    textAlign: alignment,
    style: TextStyle(
      fontSize: titleSize,
      fontWeight: FontWeight.w600,
      color: color,
    ),
  );
}

Text subText(String text, TextAlign alignment, bool overflow) {
  return Text(
    text,
    textAlign: alignment,
    style: TextStyle(
      fontSize: defaultSize,
      fontWeight: FontWeight.w400,
      color: greyTextColor,
      overflow: overflow ? null : TextOverflow.ellipsis,
    ),
    softWrap: overflow,
  );
}

Text boldDefaultText(String text, TextAlign alignment) {
  return Text(
    text,
    textAlign: alignment,
    style: TextStyle(
      fontSize: defaultSize,
      fontWeight: FontWeight.w600,
      color: blackColor,
    ),
    softWrap: true,
  );
}

Text boldDefaultDisableText(String text, TextAlign alignment) {
  return Text(
    text,
    textAlign: alignment,
    style: TextStyle(
      fontSize: defaultSize,
      fontWeight: FontWeight.w600,
      color: lightGreyColor,
    ),
    softWrap: true,
  );
}

Text smallerSubText(String text, TextAlign alignment) {
  return Text(
    text,
    textAlign: alignment,
    style: TextStyle(
      fontSize: smallSize,
      fontWeight: FontWeight.w400,
      color: greyTextColor,
    ),
    softWrap: true,
  );
}

Text priceTag(String text, TextAlign alignment, bool overflow) {
  return Text(
    text,
    textAlign: alignment,
    style: TextStyle(
      fontSize: defaultSize,
      fontWeight: FontWeight.w600,
      color: safeColor,
      overflow: overflow ? null : TextOverflow.ellipsis,
    ),
    softWrap: overflow,
  );
}

Text listTitleText(String text, bool overflow) {
  return Text(
    text,
    textAlign: TextAlign.left,
    style: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: blackColor,
      overflow: overflow ? null : TextOverflow.ellipsis,
    ),
    softWrap: overflow,
  );
}

Text totalText(String text) {
  return Text(
    text,
    textAlign: TextAlign.left,
    style: TextStyle(
      fontSize: bigSize,
      fontWeight: FontWeight.w600,
      color: whiteColor,
    ),
    softWrap: true,
  );
}
