import 'package:e_library/model/book_list_model.dart';
import 'package:e_library/screens/book_detail.dart';
import 'package:e_library/screens/homescreen.dart';
import 'package:e_library/screens/view_book.dart';
import 'package:e_library/service/get_book_list.dart';

import 'package:flutter/material.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  late Future<List<BookListModel>> bookList;
  List<BookListModel> allBookList = [];

  @override
  void initState() {
    // TODO: implement initState
    handleGetBooks();
    super.initState();
  }

  handleGetBooks() {
    bookList = getBookList();
    bookList.then((value) {
      setState(() {
        allBookList = value;
      });
    });
    print(allBookList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 31, 31, 44),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      // floatingActionButton: InkWell(
      //   onTap: () {
      //     Navigator.push(context, MaterialPageRoute(builder: (_) {
      //       return ChatScreen();
      //     }));
      //   },
      //   child: const CircleAvatar(
      //     backgroundColor: Colors.blue,
      //     child: Icon(
      //       CupertinoIcons.chat_bubble_fill,
      //       color: Colors.white,
      //     ),
      //   ),
      // ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              children: const [
                Text(
                  "Welcome to Ahmadu Bello E-Library !",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Top Available for you"),
                      Text(
                        "View all",
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 250,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Container(
                                width: 100,
                                height: 250,
                                margin: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: const DecorationImage(
                                    image: NetworkImage(
                                        'https://th.bing.com/th/id/OIP.qyip0gFDasQiIdcBiJSRiwHaJM?pid=ImgDet&rs=1'),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Recently Downloaded Books"),
                      Text(
                        "View all",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 50,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Container(
                              height: 50,
                              width: 50,
                              margin: const EdgeInsets.all(5),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: const [
                      Text("Latest Books"),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // for (int x = 0; x < allBookList.length; x++)
                  RefreshIndicator(
                    onRefresh: () {
                      return Navigator.push(context,
                          MaterialPageRoute(builder: (_) {
                        return SidebarXExampleApp();
                      }));
                    },
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: allBookList.length,
                        itemBuilder: (context, x) {
                          var bookDetails = allBookList[x];
                          return InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return  BookDetails(
                                    bookName: bookDetails.bookName.toString(),
                                    bookAuthor: bookDetails.author.toString(),
                                    bookId: bookDetails.id.toString(),
                                    bookUrl: bookDetails.bookUrl.toString(),
                                    bookDesc:bookDetails.bookDesc.toString());
                              }));
                            },
                            child: ListTile(
                              leading: Image.network(
                                "https://th.bing.com/th/id/OIP.qyip0gFDasQiIdcBiJSRiwHaJM?pid=ImgDet&rs=1",
                                fit: BoxFit.cover,
                              ),
                              title: Text(allBookList[x].bookName.toString()),
                              subtitle: Text(allBookList[x].author.toString()),
                              trailing: InkWell(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (_) {
                                      return ViewBook(
                                          bookUrl:
                                              'https://activeglobalfx.com/e-library/books/${allBookList[x].bookUrl}');
                                    }));
                                  },
                                  child: const Icon(Icons.download)),
                            ),
                          );
                        }),
                  )
                  // Column(
                  //   children: [
                  //     Container(
                  //       height: 200,
                  //       width: double.infinity,
                  //       child: Image.network(
                  //         "https://th.bing.com/th/id/R.b1ed381a19dbbdbc3b880f8d3d17e296?rik=vr8AmEXmp%2b3hzA&pid=ImgRaw&r=0",
                  //         fit: BoxFit.cover,
                  //       ),
                  //     ),
                  //     Text("")
                  //   ],
                  // )
                ],
              ),
            ))
          ],
        ),
      )),
    );
  }
}
