import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getter/models/room.dart';
import 'package:flutter_getter/screens/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_getter/models/room.dart';
import 'package:logger/logger.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class RoomState {
  String roomNumber = "";
  String id = "";
  String description = "";
  double price = 0;
  List<String> images = List.empty();
}

class _BodyState extends State<Body> {
  late Future<List<Room>> futureRooms;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(bottom: kDefaultPadding * 2.5),
            height: size.height * 0.2,
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                      left: kDefaultPadding,
                      right: kDefaultPadding,
                      bottom: 36 + kDefaultPadding),
                  height: size.height * 0.2 - 27,
                  decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(36),
                          bottomRight: Radius.circular(36))),
                  child: Row(children: [
                    Text(
                      "Hi Customer",
                      style: Theme.of(context).textTheme.headline5?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Spacer(),
                  ]),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    height: 54,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 50,
                            color: kPrimaryColor.withOpacity(0.23),
                          )
                        ]),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.only(left: kDefaultPadding),
                              hintText: "Search",
                              hintStyle: TextStyle(
                                  color: kPrimaryColor.withOpacity(0.5)),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Row(
            children: [
              Container(
                height: 24,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: kDefaultPadding / 4),
                      child: Text(
                        "Our Rooms",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        margin: EdgeInsets.only(right: kDefaultPadding / 4),
                        height: 7,
                        color: kPrimaryColor.withOpacity(0.2),
                      ),
                    )
                  ],
                ),
              ),
              TextButton(
                child: Text("Reload"),
                onPressed: () => {
                  this.setState(() {
                    initData();
                  })
                },
              ),
              Spacer(),
            ],
          ),
        ),
        FutureBuilder(
          future: futureRooms,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Flexible(
                child: ListView.separated(
                  itemCount: (snapshot.data as List<Room>).length,
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: kDefaultPadding, top: kDefaultPadding),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text('Room Number:' +
                                  ((snapshot.data as List<Room>)
                                      .elementAt(index)
                                      .roomNumber!)),
                            ],
                          ),
                          Row(
                            children: [
                              Text('Description:' +
                                  ((snapshot.data as List<Room>)
                                      .elementAt(index)
                                      .description!)),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              );
            }
            return const CircularProgressIndicator();
          },
        )
      ],
    );
  }

  @override
  void initState() {
    initData();

    super.initState();
  }

  void initData() {
    final dio = Dio();
    final client = RestClient(dio);
    futureRooms = client.getTasks();
  }
}
