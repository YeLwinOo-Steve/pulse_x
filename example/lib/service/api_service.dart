import 'dart:convert';
import 'dart:io';

import 'package:example/models/post.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

final _logger = Logger();

const String baseUrl = 'https://dummyjson.com';

abstract class ApiService {
  final http.Client client = http.Client();
  final postUrl = Uri.parse('$baseUrl/posts');

  Future<List<Post>> getPosts();
}

const int okStatusCode = 200;
const int notFoundStatusCode = 404;

class PostService extends ApiService {
  @override
  Future<List<Post>> getPosts() async {
    try {
      http.Response res = await client.get(postUrl);
      if (res.statusCode == okStatusCode) {
        dynamic data = res.body as dynamic;
        final jsonData = jsonDecode(data);
        List<dynamic> list = jsonData['posts'] as List<dynamic>;
        List<Post> posts = [];
        for (dynamic d in list) {
          posts.add(Post.fromJson(d));
        }
        return posts;
      } else if (res.statusCode == notFoundStatusCode) {
        throw Exception('Data not found!');
      }
      throw Exception('Something went wrong!');
    } on HttpException catch (ex) {
      _logger.e(ex);
      throw const HttpException('No internet connection!');
    } catch (ex) {
      rethrow;
    }
  }
}
