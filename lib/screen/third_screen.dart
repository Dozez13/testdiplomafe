import 'package:flutter/material.dart';
import 'package:test_val/dto/product_model_type_dto.dart';
import 'package:test_val/enum/model_category.dart';
import 'package:test_val/screen/second_screen.dart';
import 'package:test_val/service/shoes_model_type_service.dart';
import 'package:test_val/widget/component/type_element.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';

class ThirdScreen extends StatefulWidget {
  final ModelCategory modelCategory;

  const ThirdScreen({Key? key, required this.modelCategory}) : super(key: key);

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  int _pageIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(140, 201, 238, 0.6),
        automaticallyImplyLeading: false,
        title: Text(
          "Nicolo",
          style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontFamily: "FiraCode",
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.camera_alt_outlined)),
        ],
      ),
      body: FutureBuilder<List<ProductModelTypeDto>>(
        future: widget.modelCategory == ModelCategory.shoes
            ? ShoesModelTypeService.getInstance.getAllShoesTypes()
            : null,
        builder: (BuildContext context,
            AsyncSnapshot<List<ProductModelTypeDto>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            default:
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return CustomScrollView(
                  primary: false,
                  slivers: <Widget>[
                    SliverPadding(
                      padding: const EdgeInsets.all(10),
                      sliver: SliverGrid.count(
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        crossAxisCount: 2,
                        childAspectRatio: 2,
                        children: snapshot.data!
                            .map((shoesModelTypeDto) => TypeElement(
                                  productModelTypeDto: shoesModelTypeDto,
                                ))
                            .toList(),
                      ),
                    ),
                  ],
                );
              }
          }
        },
      ),
      bottomNavigationBar: BubbleBottomBar(
        opacity: 1,
        backgroundColor: Color.fromRGBO(140, 201, 238, 0.6),
        currentIndex: _pageIndex,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return const SecondScreen(
                    pagesIndex: 0,
                  );
                }),
              );
              break;
            case 1:
              Navigator.pop(context);
              break;
          }
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
