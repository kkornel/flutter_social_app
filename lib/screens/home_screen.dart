import 'package:flutter/material.dart';
import 'package:flutter_social_app/utils/constants.dart';
import 'package:flutter_social_app/utils/constants_strings.dart' as STRINGS;
import 'package:flutter_social_app/utils/network_utils.dart';
import 'package:flutter_social_app/utils/profile_clipper.dart';
import 'package:flutter_social_app/utils/top_selector.dart';
import 'package:flutter_social_app/utils/post_card.dart';
import 'package:flutter_social_app/utils/custom_icon.dart';
import 'package:flutter_social_app/utils/user_account.dart';
import 'package:flutter_social_app/models/post.dart';

class HomeScreen extends StatefulWidget {
  static String id = "home_screen";

  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // int _currentIndex = 0;

  // List<Widget> bottomNavIconList = [
  //   Image.asset(
  //     "images/logo.png",
  //     width: 35.0,
  //     height: 35.0,
  //   ),
  //   Icon(
  //     CustomIcons.search,
  //     size: 32.0,
  //   ),
  //   Icon(
  //     CustomIcons.favorite,
  //     size: 32.0,
  //   ),
  //   Icon(CustomIcons.cart, size: 32.0),
  //   Image.asset("images/default.jpg", width: 35.0, height: 35.0)
  // ];

  List<Post> posts = new List();

  @override
  void initState() {
    // NetworkUtils.getAllComments();
    // NetworkUtils.getAllLikes();
    getPosts();
    super.initState();
  }

  void getPosts() async {
    var psosts = await NetworkUtils.getAllPosts();

    setState(() {
      this.posts = psosts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey,
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 5, left: 5, right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.menu),
                      onPressed: () {},
                    ),
                    ClipOval(
                      clipper: ProfileClipper(),
                      child: Image.network(
                        'https://pbs.twimg.com/media/EKHKiqgXUAAgwav?format=jpg&name=large',
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 1000.0,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    Post post = posts[index];
                    return PostCard(post: post);
                  },
                ),
              ),

              // PostCard(),
              // PostCard(),
              // PostCard(),
              // PostCard(),
            ],
          ),
        ),
      ),
    );
  }
}

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Padding(
//                 padding: EdgeInsets.only(top: 10, left: 10, right: 10),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     IconButton(
//                       icon: Icon(Icons.menu),
//                       onPressed: () {},
//                     ),
//                     ClipOval(
//                       clipper: ProfileClipper(),
//                       child: Image.asset(
//                         'images/default.jpg',
//                         width: 48,
//                         height: 48,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(top: 10, left: 10, bottom: 30),
//                 child: Text(
//                   'Explore',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               TopSelector(
//                 titles: ['Main', 'Second', 'Third', 'Fourth'],
//               ),
//               SizedBox(
//                 height: 50,
//               ),
//               SizedBox(
//                 height: 800,
//                 child: ListView.builder(
//                   scrollDirection: Axis.vertical,
//                   physics: BouncingScrollPhysics(),
//                   itemCount: 50,
//                   itemBuilder: (context, index) {
//                     var post = 'fdsfds';
//                     return Padding(
//                       padding: EdgeInsets.only(left: 10),
//                       child: PostCard(post: post, postId: index),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//         // # 2222222222222222222222222222222222222222222222222222222222222222222222222
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {},
//           backgroundColor: Color(0xFFF17532),
//           child: Icon(Icons.fastfood),
//         ),
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//         bottomNavigationBar: BottomAppBar(
//           shape: CircularNotchedRectangle(),
//           notchMargin: 6.0,
//           color: Colors.transparent,
//           elevation: 9.0,
//           clipBehavior: Clip.antiAlias,
//           child: Container(
//             height: 50.0,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(25.0),
//                     topRight: Radius.circular(25.0)),
//                 color: Colors.white),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                     height: 50.0,
//                     width: MediaQuery.of(context).size.width / 2 - 40.0,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: <Widget>[
//                         Icon(Icons.home, color: Color(0xFFEF7532)),
//                         Icon(Icons.person_outline, color: Color(0xFF676E79))
//                       ],
//                     )),
//                 Container(
//                     height: 50.0,
//                     width: MediaQuery.of(context).size.width / 2 - 40.0,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: <Widget>[
//                         Icon(Icons.search, color: Color(0xFF676E79)),
//                         Icon(Icons.shopping_basket, color: Color(0xFF676E79))
//                       ],
//                     )),
//               ],
//             ),
//           ),
//         ),
//         // # 111111111111111111111111111111111111111111111
//         // bottomNavigationBar: Container(
//         //   height: 70.0,
//         //   decoration: BoxDecoration(color: Colors.white, boxShadow: [
//         //     BoxShadow(
//         //         color: Colors.black12.withOpacity(0.065),
//         //         offset: Offset(0.0, -3.0),
//         //         blurRadius: 10.0)
//         //   ]),
//         //   child: Row(
//         //     children: bottomNavIconList.map((item) {
//         //       var index = bottomNavIconList.indexOf(item);
//         //       return Expanded(
//         //         child: GestureDetector(
//         //           onTap: () {
//         //             setState(() {
//         //               _currentIndex = index;
//         //             });
//         //           },
//         //           child: bottomNavItem(item, index == _currentIndex),
//         //         ),
//         //       );
//         //     }).toList(),
//         //   ),
//         // ),
//       ),
//     );
//   }
// }

bottomNavItem(Widget item, bool isSelected) => Container(
      decoration: BoxDecoration(
          boxShadow: isSelected
              ? [
                  BoxShadow(
                      color: Colors.black12.withOpacity(0.02),
                      offset: Offset(0.0, 5.0),
                      blurRadius: 10.0)
                ]
              : []),
      child: item,
    );
