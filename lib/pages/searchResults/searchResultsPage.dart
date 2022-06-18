import 'package:carousel_slider/carousel_slider.dart';
import 'package:connevents/pages/searchFilters/searchFiltersPage.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchResultsPage extends StatefulWidget {
  const SearchResultsPage({Key? key}) : super(key: key);

  @override
  _SearchResultsPageState createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  String selectedSegment = 'all';
  bool showSearchBar = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
        decoration: BoxDecoration(color: globallightbg),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: padding,
                horizontal: padding * 2,
              ),
              child: showSearchBar
                  ? Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextField(
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: padding),
                          hintText: 'Type here...',
                          hintStyle: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          prefixIcon: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                showSearchBar = !showSearchBar;
                              });
                            },
                            icon: Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ),
                          fillColor: globalGreen,
                          filled: true,
                          border: InputBorder.none,
                        ),
                      ),
                    )
                  : Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 25,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: globalLightButtonbg,
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'City',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                    ),
                                  ),
                                  SvgPicture.asset(
                                    'assets/icons/downArrow.svg',
                                    color: globalGreen,
                                    width: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: padding / 2,
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 25,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: globalLightButtonbg,
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Date',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                    ),
                                  ),
                                  SvgPicture.asset(
                                    'assets/icons/downArrow.svg',
                                    color: globalGreen,
                                    width: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: padding / 2,
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 25,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: globalLightButtonbg,
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Category',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                    ),
                                  ),
                                  SvgPicture.asset(
                                    'assets/icons/downArrow.svg',
                                    color: globalGreen,
                                    width: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: padding / 2,
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 25,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: globalLightButtonbg,
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  showSearchBar = !showSearchBar;
                                });
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/search.svg',
                                    color: globalGreen,
                                    width: 12,
                                  ),
                                  Text(
                                    'Search',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: padding,
                    horizontal: padding * 2,
                  ),
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 30,
                                decoration: BoxDecoration(
                                  color: globalLightButtonbg,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        clipBehavior: Clip.antiAlias,
                                        decoration: (selectedSegment == 'all')
                                            ? BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color: globalGreen),
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              )
                                            : BoxDecoration(),
                                        child: TextButton(
                                          onPressed: () {
                                            setState(() {
                                              selectedSegment = 'all';
                                            });
                                          },
                                          child: Text(
                                            'All',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        clipBehavior: Clip.antiAlias,
                                        decoration: (selectedSegment == 'today')
                                            ? BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color: globalGreen),
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              )
                                            : BoxDecoration(),
                                        child: TextButton(
                                            onPressed: () {
                                              setState(() {
                                                selectedSegment = 'today';
                                              });
                                            },
                                            child: Text(
                                              'Today',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                              ),
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: padding,
                            ),
                            GestureDetector(
                              onTap: () {
                                CustomNavigator.navigateTo(context, SearchFiltersPage());
                                // Navigator.pushNamed(context, '/searchFilters');
                              },
                              child: SvgPicture.asset(
                                'assets/icons/filter.svg',
                                width: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: padding,
                      ),
                      Row(
                        children: [
                          for (var i = 0; i < 3; i++)
                            SizedBox(
                              height: 24,
                              child: Row(
                                children: [
                                  TextButton(
                                    onPressed: () {},
                                    style: TextButton.styleFrom(
                                      backgroundColor: globalLightButtonbg,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      padding: EdgeInsets.zero,
                                    ),
                                    child: Row(
                                      children: [
                                        Text('data'),
                                        Icon(
                                          Icons.close,
                                          size: 14,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: padding,
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          'Clear Filter',
                          style: TextStyle(
                            color: globalGolden,
                            fontSize: 12,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: padding * 4,
                      ),
                      SizedBox(
                        width: 126,
                        height: 126,
                        child: Image.asset(
                          'assets/imgs/sad.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        height: padding * 3,
                      ),
                      Text(
                        'No result matching\nyour search.',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: padding,
                      ),
                      Text(
                        'Try again!',
                        style: TextStyle(
                          color: globalGreen,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
