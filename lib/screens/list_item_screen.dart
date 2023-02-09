import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/restaurant.dart';
import '../widgets/custom_form_text.dart';
import '../widgets/items_page_view.dart';
import 'detail_item_screen.dart';

class ListItemScreen extends StatefulWidget {
  const ListItemScreen({Key? key}) : super(key: key);

  @override
  State<ListItemScreen> createState() => _ListItemScreenState();
}

class _ListItemScreenState extends State<ListItemScreen> {
  var _selectedIndex = 0;
  final List<Restaurants> _data = [];
  List<Restaurants> _dataRestaurant = [];

  TextEditingController? _textEditingController;

  Future<String> _loadCategoryfromAssets() async {
    return await rootBundle.loadString('assets/local_restaurant.json');
  }

  @override
  void initState() {
    super.initState();
    loadCategory();
  }

  Future loadCategory() async {
    await wait(1);
    String jsonString = await _loadCategoryfromAssets();
    final jsonResponse = json.decode(jsonString);
    DataRestaurant dataRestaurant = DataRestaurant.fromJson(jsonResponse);
    setState(() {
      _data.addAll(dataRestaurant.restaurants!);
      _dataRestaurant = dataRestaurant.restaurants!;
    });
  }

  Future wait(int seconds) {
    return Future.delayed(Duration(seconds: seconds), () => {});
  }

  void _searchResults(String? query) {
    List<Restaurants> searchList = [];
    searchList.addAll(_data);
    if (query!.isNotEmpty) {
      List<Restaurants> dataSearch = [];
      for (var element in searchList) {
        if (element.city!.contains(query) || element.name!.contains(query)) {
          dataSearch.add(element);
        }
      }
      setState(() {
        _data.clear();
        _data.addAll(dataSearch);
      });
      return;
    } else {
      setState(() {
        _data.clear();
        _data.addAll(_dataRestaurant);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final PageController controllerPage = PageController();
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            end: Alignment.centerRight,
            begin: Alignment.centerLeft,
            colors: [Color(0xFFCBECEF), Color(0xFFACE5F5)],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: FutureBuilder<String>(
            future: _loadCategoryfromAssets(),
            builder: (context, snapshot) {
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: size.height / 39),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Daftar Restoran',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomFormText(
                        onChanged: (value) {
                          _searchResults(value);
                        },
                        controller: _textEditingController,
                        textInputAction: TextInputAction.search,
                        hintText: 'Cari Restoran/Kota ...',
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        height: 50,
                        fontSize: 16,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: size.width,
                        height: size.height * 0.65,
                        child: PageView.builder(
                          onPageChanged: (index) {
                            setState(() {
                              _selectedIndex = index;
                            });
                          },
                          controller: controllerPage,
                          physics: const BouncingScrollPhysics(),
                          itemCount: _data.length,
                          itemBuilder: (BuildContext context, index) {
                            var _scale = _selectedIndex == index ? 1.0 : 0.8;
                            return TweenAnimationBuilder(
                              duration: const Duration(milliseconds: 450),
                              tween: Tween(begin: _scale, end: _scale),
                              curve: Curves.ease,
                              builder: (BuildContext context, double value,
                                  Widget? child) {
                                return Transform.scale(
                                  scale: value,
                                  child: child,
                                );
                              },
                              child: ItemPageView(
                                srcNet: _data[index].pictureId,
                                name: _data[index].name,
                                city: _data[index].city,
                                rating: _data[index].rating,
                                onTap: () {
                                  Navigator.of(context).push(
                                    _createRoute(
                                      _data[index].pictureId,
                                      _data[index].name,
                                      _data[index].city,
                                      _data[index].description,
                                      _data[index].menus,
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      // Dot Indicator
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List<Widget>.generate(
                          _data.length,
                          (int index) {
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              height: 10,
                              width: (index == _selectedIndex) ? 30 : 10,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 0.5, color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(5),
                                color: (index == _selectedIndex)
                                    ? Color.lerp(
                                        const Color(0xFFCBECEF),
                                        const Color(0xFFACE5F5),
                                        1.5,
                                      )
                                    : Colors.white,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Route _createRoute(String? netSrc, String? title, String? location,
      String? desc, Menus? menuItem) {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return DetailItemScreen(
            netSrc: netSrc,
            title: title,
            location: location,
            desc: desc,
            menuItem: menuItem,
          );
        },
        transitionDuration: const Duration(milliseconds: 800),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        });
  }
}
