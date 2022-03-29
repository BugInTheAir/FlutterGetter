import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
part 'room.g.dart';

@RestApi(baseUrl: "http://localhost:5001/api")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/room")
  Future<List<Room>> getTasks();
}

@JsonSerializable()
class Room {
  Room({this.id, this.roomNumber, this.images, this.description, this.price});
  String? id;
  String? roomNumber;
  List<String>? images;
  String? description;
  double? price;
  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
        id: json['id'],
        roomNumber: json['roomNumber'],
        images: json['images'],
        description: json['description'],
        price: json['price']);
  }
}
