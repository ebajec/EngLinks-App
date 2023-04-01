import 'package:flutter/material.dart';
import 'my_styles.dart';

const double accentBarWidth = 220;
const double accentBarSpacing = 20;
const Color accentBarColor = Colors.grey;

class AlignedText extends StatelessWidget {
  final String text;
  final AlignmentGeometry alignment;
  final TextStyle style;
  final TextAlign textAlign;

  const AlignedText(
      {Key? key,
      required this.text,
      required this.alignment,
      this.style = const TextStyle(),
      this.textAlign = TextAlign.left})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: style,
          textAlign: textAlign,
        ),
      ),
    );
  }
}

class AlignedBar extends StatelessWidget {
  const AlignedBar({
    super.key,
    this.alignment = Alignment.centerLeft,
    this.color = Colors.black,
    required this.width,
  });

  final double width;
  final Alignment alignment;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: width,
        child: Divider(
          color: color, //color of divider
          height: 5, //height spacing of divider
          thickness: 3, //thickness of divider line
          indent: 5, //spacing at the start of divider
          endIndent: 15, //spacing at the end of divider
        ),
      ),
    );
  }
}

class FeatureTitle extends StatelessWidget {
  const FeatureTitle(this.text, {this.textSize = 20, this.spacing = 20});

  final double spacing;
  final double textSize;
  final String text;
  final double _barWidth = 220;
  final Color _barColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AlignedText(
          text: text,
          style: MyTextStyles.bold(context, textSize),
          alignment: Alignment.centerLeft,
        ),
        AlignedBar(width: _barWidth, color: _barColor),
        SizedBox(height: spacing)
      ],
    );
  }
}

class WideButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const WideButton({
    required this.label,
    required this.onPressed,
    this.height = 50,
    this.textStyle = const TextStyle(),
    this.textAlign = Alignment.center,
  });

  final double height;
  final TextStyle textStyle;
  final Alignment textAlign;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.black),
          bottom: BorderSide(color: Colors.black),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          child: Center(
            child: AlignedText(
              text: label,
              style: textStyle,
              alignment: textAlign,
            ),
          ),
        ),
      ),
    );
  }
}

//copied this from flutter docs
class MyImage extends StatefulWidget {
  const MyImage({
    super.key,
    required this.assetImage,
  });

  final AssetImage assetImage;

  @override
  State<MyImage> createState() => _MyImageState();
}

class _MyImageState extends State<MyImage> {
  ImageStream? _imageStream;
  ImageInfo? _imageInfo;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // We call _getImage here because createLocalImageConfiguration() needs to
    // be called again if the dependencies changed, in case the changes relate
    // to the DefaultAssetBundle, MediaQuery, etc, which that method uses.
    _getImage();
  }

  @override
  void didUpdateWidget(MyImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.assetImage != oldWidget.assetImage) {
      _getImage();
    }
  }

  void _getImage() {
    final ImageStream? oldImageStream = _imageStream;
    _imageStream =
        widget.assetImage.resolve(createLocalImageConfiguration(context));
    if (_imageStream!.key != oldImageStream?.key) {
      // If the keys are the same, then we got the same image back, and so we don't
      // need to update the listeners. If the key changed, though, we must make sure
      // to switch our listeners to the new image stream.
      final ImageStreamListener listener = ImageStreamListener(_updateImage);
      oldImageStream?.removeListener(listener);
      _imageStream!.addListener(listener);
    }
  }

  void _updateImage(ImageInfo imageInfo, bool synchronousCall) {
    setState(() {
      // Trigger a build whenever the image changes.
      _imageInfo?.dispose();
      _imageInfo = imageInfo;
    });
  }

  @override
  void dispose() {
    _imageStream?.removeListener(ImageStreamListener(_updateImage));
    _imageInfo?.dispose();
    _imageInfo = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RawImage(
      image: _imageInfo?.image, // this is a dart:ui Image object
      scale: _imageInfo?.scale ?? 1.0,
    );
  }
}
