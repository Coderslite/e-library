import 'dart:convert';

import 'package:e_library/model/comment_model.dart';
import 'package:e_library/screens/view_book.dart';
import 'package:e_library/service/get_comments.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;

class BookDetails extends StatefulWidget {
  final String bookName;
  final String bookAuthor;
  final String bookId;
  final String bookDesc;
  final String bookUrl;
  const BookDetails(
      {Key? key,
      required this.bookName,
      required this.bookAuthor,
      required this.bookId,
      required this.bookDesc,
      required this.bookUrl})
      : super(key: key);

  @override
  State<BookDetails> createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  var commentMessage = TextEditingController();
  late Future<List<CommentModel>> commentList;
  List<CommentModel> allCommentList = [];

  handleGetBooks() {
    commentList = getComments(widget.bookId);
    commentList.then((value) {
      setState(() {
        allCommentList = value;
      });
    });
    // print(allBookList);
  }

  @override
  void initState() {
    // TODO: implement initState
    handleGetBooks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 31, 31, 44),
      bottomSheet: SizedBox(
          width: MediaQuery.of(context).size.width * 1.0,
          child: TextField(
            controller: commentMessage,
            textInputAction: TextInputAction.send,
            onSubmitted: ((value) {
              handleAddComment();
            }),
            style: TextStyle(color: Color.fromARGB(255, 66, 66, 66)),
            decoration: const InputDecoration(
                fillColor: Color.fromARGB(255, 244, 241, 241),
                filled: true,
                hintText: "comment on the book",
                hintStyle: TextStyle(color: Color.fromARGB(255, 66, 66, 66)),
                border: OutlineInputBorder()),
          )),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back))
              ],
            ),
          ),
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        image: const DecorationImage(
                          image: NetworkImage(
                            "https://th.bing.com/th/id/OIP.qyip0gFDasQiIdcBiJSRiwHaJM?pid=ImgDet&rs=1",
                          ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2.7,
                          child: Text(
                            widget.bookName,
                            style: TextStyle(fontSize: 22),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.bookAuthor,
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "3 downloads",
                          style: TextStyle(fontSize: 14, color: Colors.yellow),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return ViewBook(bookUrl: widget.bookUrl);
                              }));
                            },
                            child: const Text("View PDF")),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text("download pdf"),
                          style: ElevatedButton.styleFrom(primary: Colors.red),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20, top: 20, bottom: 80),
                  child: Column(
                    children: [
                      Row(
                        children: const [
                          Text(
                            "Description",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          widget.bookDesc,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: const [
                          Text(
                            "Similiar Books",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 250,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              for (int x = 0; x < 5; x++)
                                Container(
                                  width: 100,
                                  height: 250,
                                  margin: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: const DecorationImage(
                                      image: NetworkImage(
                                          "https://th.bing.com/th/id/OIP.qyip0gFDasQiIdcBiJSRiwHaJM?pid=ImgDet&rs=1"),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: const [
                          Text(
                            "all comments",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      for (int x = 0; x < allCommentList.length; x++)
                        ListTile(
                          leading: CircleAvatar(),
                          title: Text(
                            allCommentList[x].fullName.toString(),
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          subtitle: Text(
                            allCommentList[x].comment.toString(),
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          trailing: Text(
                            timeago.format(DateTime.parse(
                                allCommentList[x].date.toString())),
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      )),
    );
  }

  handleAddComment() async {
    var prefs = await SharedPreferences.getInstance();
    var email = prefs.getString("email");
    var response = await http.post(
        Uri.parse("https://activeglobalfx.com/e-library/add_comment.php"),
        body: {
          "bookId": widget.bookId,
          "email": email,
          "comment": commentMessage.text,
          "date": DateTime.now().toString()
        });

    var userData = jsonDecode(response.body);

    if (userData['status'] == true) {
      commentMessage.clear();
      // print("comment added");
      Fluttertoast.showToast(msg: "comment added successfully");
      setState(() {
        handleGetBooks();
      });
    } else {
      commentMessage.clear();
      Fluttertoast.showToast(msg: "comment not added");
    }
  }
}
