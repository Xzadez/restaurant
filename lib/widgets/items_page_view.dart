import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ItemPageView extends StatefulWidget {
  const ItemPageView(
      {Key? key, this.srcNet, this.name, this.city, this.rating, this.onTap})
      : super(key: key);

  final String? srcNet;
  final String? name;
  final String? city;
  final String? rating;
  final VoidCallback? onTap;

  @override
  State<ItemPageView> createState() => _ItemPageViewState();
}

class _ItemPageViewState extends State<ItemPageView>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    Timer(
      const Duration(milliseconds: 200),
      () => _animationController!.forward(),
    );
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return FadeTransition(
      opacity: _animationController!,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: InkWell(
          onTap: widget.onTap,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: size.width,
                  height: size.height * 0.43,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(14),
                      topRight: Radius.circular(14),
                    ),
                    child: CachedNetworkImage(
                      fadeInDuration: const Duration(milliseconds: 900),
                      placeholderFadeInDuration:
                          const Duration(milliseconds: 300),
                      fit: BoxFit.cover,
                      imageUrl: widget.srcNet!,
                      placeholder: (context, url) => const Center(
                          child: Text(
                        'Loading Image...',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                          color: Colors.grey,
                        ),
                      )),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.name ?? '',
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.002,
                      ),
                      Row(
                        children: <Widget>[
                          const Icon(
                            Icons.location_pin,
                            size: 20,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Text(
                            widget.city ?? '',
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.035),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.star_rate_rounded,
                            color: Colors.yellow[700],
                            size: 25,
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Text(
                            widget.rating ?? '',
                            style: const TextStyle(
                                fontFamily: 'Poppins', fontSize: 17),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
