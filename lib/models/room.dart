import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Room {
  Room(this.id, this.roomName, this.images, this.roomNumber);
  int id = -1;
  String roomName = "";
  List<String> images = List.empty();
  String roomNumber = "";
}
