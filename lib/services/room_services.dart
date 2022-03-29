import 'package:flutter_getter/models/room.dart';
import 'package:logger/logger.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

void test() {
  final dio = Dio();
  final client = RestClient(dio);
  client.getTasks().then((value) => null);
}
