import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:test_val/dto/product_model_category_dto.dart';
import 'package:test_val/service/product_model_category_service.dart';
import 'package:test_val/widget/component/category_element.dart';
import 'package:test_val/widget/component/shop_element.dart';

class SecondScreen extends StatefulWidget {
  final int pagesIndex;

  const SecondScreen({Key? key, required this.pagesIndex}) : super(key: key);

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  int _pageIndex = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _pageIndex = widget.pagesIndex;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(140, 201, 238, 0.6),
        automaticallyImplyLeading: false,
        title: Text("Nicolo",style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontFamily: "FiraCode",
            fontWeight: FontWeight.bold),),
        centerTitle: true,

      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _pageIndex = index;
          });
        },
        children: [
          CustomScrollView(slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: [
                  Container(
                    color: Color.fromRGBO(95, 135, 161, 0.6),
                    width: double.infinity,
                    height: 400,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Image(
                            image: AssetImage(
                              "images/logo_shoes_icon.png",
                            ),
                            color: Color.fromRGBO(95, 135, 161, 1),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Nicolo",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "FiraCode",
                                  fontSize: 48,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Explore the best",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "FiraCode",
                                  fontSize: 16,
                                  color: Color.fromRGBO(95, 135, 161, 1),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      "BEST SELLERS",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: "FiraCode",
                        fontSize: 32,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: 400,
                  //   child: GridView.builder(
                  //       gridDelegate:
                  //           const SliverGridDelegateWithFixedCrossAxisCount(
                  //               crossAxisCount: 2,
                  //               mainAxisSpacing: 10,
                  //               crossAxisSpacing: 10),
                  //       padding: EdgeInsets.all(5),
                  //       itemCount: 300,
                  //       itemBuilder: (BuildContext context, int index) {
                  //         return ShopElement(
                  //             image: Image(
                  //               image: AssetImage(
                  //                 "images/logo_shoes_icon.png",
                  //               ),
                  //               color: Color.fromRGBO(95, 135, 161, 1),
                  //             ),
                  //             onTap: (){},
                  //             imageBackgroundColor:
                  //                 Color.fromRGBO(215, 215, 215, 1.0),
                  //             productName: Text(
                  //               "name is $index",
                  //               style: TextStyle(
                  //                 fontFamily: "FiraCode",
                  //                 fontWeight: FontWeight.bold,
                  //                 color: Color.fromRGBO(166, 165, 165, 1.0),
                  //               ),
                  //             ),
                  //             productPrice: Text(
                  //               "$index\$",
                  //               style: TextStyle(
                  //                 fontFamily: "FiraCode",
                  //                 fontWeight: FontWeight.bold,
                  //               ),
                  //             ));
                  //       }),
                  // ),
                ],
              ),
            ),
          ]),
          CustomScrollView(slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: FutureBuilder<List<ProductModelCategoryDto>>(
                future:
                    ProductModelCategoryService.getInstance.getAllCategories(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<ProductModelCategoryDto>> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    default:
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return Column(
                            children: snapshot.data!
                                .map((productModelCategoryDto) =>
                                    CategoryElement(
                                      productModelCategoryDto:
                                          productModelCategoryDto,
                                    ))
                                .toList());
                      }
                  }
                },
              ),
            )
          ])
        ],
      ),
      bottomNavigationBar: BubbleBottomBar(
        opacity: 1,
        backgroundColor: Color.fromRGBO(140, 201, 238, 0.6),
        currentIndex: _pageIndex,
        onTap: (index) {
          _pageController.animateToPage(index!,
              duration: Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn);
        },
        //new, gives a cute ink effect
        inkColor: Colors.black12,
        //optional, uses theme color if not specified
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
              backgroundColor: Color.fromRGBO(95, 135, 161, 0.6),
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              activeIcon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              title: Text("Home", style: TextStyle(color: Colors.white))),
          BubbleBottomBarItem(
              backgroundColor: Color.fromRGBO(95, 135, 161, 0.6),
              icon: Icon(
                Icons.collections_bookmark,
                color: Colors.white,
              ),
              activeIcon: Icon(
                Icons.collections_bookmark,
                color: Colors.white,
              ),
              title: Text(
                "Categories",
                style: TextStyle(color: Colors.white),
              )),
        ],
      ),
    );
  }
}
