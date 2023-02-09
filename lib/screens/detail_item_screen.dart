import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/restaurant.dart';
import '../widgets/items_menu_view.dart';

class DetailItemScreen extends StatefulWidget {
  const DetailItemScreen(
      {Key? key,
      this.netSrc,
      this.title,
      this.desc,
      this.location,
      this.menuItem})
      : super(key: key);

  final String? netSrc;
  final String? title;
  final String? desc;
  final String? location;
  final Menus? menuItem;

  @override
  State<DetailItemScreen> createState() => _DetailItemScreenState();
}

class _DetailItemScreenState extends State<DetailItemScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white.withOpacity(0.98),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  SizedBox(
                    width: size.width,
                    height: size.height / 3,
                    child: ClipRRect(
                      child: CachedNetworkImage(
                        fadeInDuration: const Duration(milliseconds: 900),
                        placeholderFadeInDuration:
                            const Duration(milliseconds: 300),
                        fit: BoxFit.cover,
                        imageUrl: widget.netSrc!,
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
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    left: 20,
                    child: InkWell(
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            20,
                          ),
                        ),
                        child: const Icon(
                          Icons.arrow_back_rounded,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 20, left: 20, right: 20, bottom: 10),
                child: Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.title!,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          const Icon(
                            Icons.location_pin,
                            size: 20,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            widget.location!,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        'Tentang Restaurant',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.desc!,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w300,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'Menu Makanan',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(
                height: 190,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: widget.menuItem!.foods!.length,
                  itemBuilder: (context, int index) {
                    return ItemMenu(
                      onTap: () {
                        var snackBar = SnackBar(
                          duration: const Duration(milliseconds: 800),
                          content: Text(
                              '${widget.menuItem!.foods![index].name} Ordered'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      title: widget.menuItem!.foods![index].name,
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'Menu Minuman',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(
                height: 190,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: widget.menuItem!.drinks!.length,
                  itemBuilder: (context, int index) {
                    return ItemMenu(
                      onTap: () {
                        var snackBar = SnackBar(
                          duration: const Duration(milliseconds: 800),
                          content: Text(
                              '${widget.menuItem!.drinks![index].name} Ordered'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      title: widget.menuItem!.drinks![index].name,
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
