import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';

class CacheImageWidget extends StatefulWidget {
  const CacheImageWidget({
    Key? key,
    required this.url,
    this.aspectRatio = 1 / 1,
    this.dynamicSize = false,
    this.tag,
    this.isHero = false,
    this.borderRadius,
    this.border,
  }) : super(key: key);

  // require key
  final String url;

  // nullable key
  final double? aspectRatio;
  final bool dynamicSize;
  final String? tag;
  final bool? isHero;
  final BorderRadius? borderRadius;
  final BoxBorder? border;

  @override
  State<CacheImageWidget> createState() => _CacheImageWidgetState();
}

class _CacheImageWidgetState extends State<CacheImageWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 3),
        lowerBound: 0.0,
        upperBound: 1.0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.dynamicSize == true
        ? cacheImage()
        : AspectRatio(aspectRatio: widget.aspectRatio!, child: cacheImage());
  }

  Widget cacheImage() {
    Widget image = ExtendedImage.network(
      widget.url,
      fit: widget.dynamicSize == true ? BoxFit.contain : BoxFit.cover,
      cache: true,
      borderRadius: widget.borderRadius,
      border: widget.border,
      shape: BoxShape.rectangle,
      loadStateChanged: (ExtendedImageState state) {
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            _controller.reset();
            return Image.network(
                'https://www.chanchao.com.tw/ctg/images/default.jpg',
                fit:
                    widget.dynamicSize == true ? BoxFit.contain : BoxFit.cover);
          case LoadState.completed:
            if (state.wasSynchronouslyLoaded) {
              return state.completedWidget;
            }
            _controller.forward();
            return FadeTransition(
              opacity: _controller,
              child: state.completedWidget,
            );
          case LoadState.failed:
            _controller.reset();
            state.imageProvider.evict();
            return Image.network(
              'https://www.chanchao.com.tw/ctg/images/default.jpg',
              fit: widget.dynamicSize == true ? BoxFit.contain : BoxFit.cover,
            );
        }
      },
    );
    return widget.isHero!
        ? Hero(tag: widget.tag ?? widget.url, child: image)
        : image;
  }
}
