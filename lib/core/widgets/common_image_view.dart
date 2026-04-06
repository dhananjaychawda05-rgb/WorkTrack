// ignore_for_file: must_be_immutable
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:work_trace_app/core/constants/app_assets.dart';

class CommonImageView extends StatelessWidget {
  /// for picked in Unit8List  print("base64Encode==>${base64Encode(pickedImage!["file"])}");
  ///[imagePath] is required parameter for showing image
  String? imagePath;
  num? height;
  num? width;
  Color? color;
  BoxFit? fit;
  final String placeHolder;
  Alignment? alignment;
  VoidCallback? onTap;
  EdgeInsetsGeometry? margin;
  BorderRadius? radius;
  BoxBorder? border;
  Uint8List? uint8List;

  ///a [CommonImageView] it can be used for showing any type of images
  /// it will shows the placeholder image if image is not found on network image
  CommonImageView({
    super.key,
    this.imagePath,
    this.height,
    this.width,
    this.color,
    this.fit,
    this.alignment,
    this.onTap,
    this.radius,
    this.margin,
    this.border,
    this.uint8List,
    this.placeHolder = AppAssets.brokenImage,
  });

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(alignment: alignment!, child: _buildWidget())
        : _buildWidget();
  }

  Widget _buildWidget() {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: InkWell(onTap: onTap, child: _buildCircleImage()),
    );
  }

  ///build the image with border radius
  _buildCircleImage() {
    if (radius != null) {
      return ClipRRect(
        borderRadius: radius ?? BorderRadius.zero,
        child: _buildImageWithBorder(),
      );
    } else {
      return _buildImageWithBorder();
    }
  }

  ///build the image with border and border radius style
  _buildImageWithBorder() {
    if (border != null) {
      return Container(
        decoration: BoxDecoration(border: border, borderRadius: radius),
        child: _buildImageView(),
      );
    } else {
      return _buildImageView();
    }
  }

  Widget _buildImageView() {
    if (imagePath == null || imagePath!.isEmpty) {
      return Image.asset(
        placeHolder,
        height: height?.toDouble() ?? 50,
        width: width?.toDouble() ?? 50,
      );
    }

    switch (imagePath!.imageType) {
      case ImageType.svg:
        return SizedBox(
          height: height?.toDouble(),
          width: width?.toDouble(),
          child: SvgPicture.asset(
            imagePath!,
            colorFilter: color != null
                ? ColorFilter.mode(color!, BlendMode.srcIn)
                : null,
            fit: fit ?? BoxFit.contain,
          ),
        );
      case ImageType.file:
        return Image.file(
          File(imagePath!),
          height: height?.toDouble(),
          width: width?.toDouble(),
          fit: fit ?? BoxFit.cover,
          color: color,
        );
      case ImageType.unit8List:
        return Image.memory(
          base64Decode(imagePath!),
          height: height?.toDouble(),
          width: width?.toDouble(),
          fit: fit ?? BoxFit.cover,
          color: color,
        );
      case ImageType.network:
        return CachedNetworkImage(
          height: height?.toDouble(),
          width: width?.toDouble(),
          fit: fit ?? BoxFit.cover,
          imageUrl: imagePath!,
          color: color,
          placeholder: (context, url) => SizedBox(
            height: height?.toDouble() ?? 50,
            width: width?.toDouble() ?? 50,
            child: LinearProgressIndicator(
              color: Colors.grey.shade200,
              backgroundColor: Colors.grey.shade100,
            ),
          ),
          errorWidget: (context, url, error) => Image.asset(
            placeHolder,
            height: height?.toDouble() ?? 50,
            width: width?.toDouble() ?? 50,
            fit: fit ?? BoxFit.contain,
          ),
        );
      case ImageType.png:
      default:
        return Image.asset(
          imagePath!,
          height: height?.toDouble(),
          width: width?.toDouble(),
          fit: fit ?? BoxFit.cover,
          color: color,
        );
    }
  }
}

extension ImageTypeExtension on String {
  ImageType get imageType {
    if (startsWith('http') || startsWith('https')) {
      return ImageType.network;
    } else if (endsWith('.svg')) {
      return ImageType.svg;
    } else if (startsWith('file://')) {
      return ImageType.file;
    } else if (startsWith('/9')) {
      return ImageType.unit8List;
    } else if (startsWith('/')) {
      return ImageType.file;
    } else {
      return ImageType.png;
    }
  }
}

enum ImageType { svg, png, network, file, unknown, unit8List }