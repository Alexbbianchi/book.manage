import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:projeto_integrador_app/app/common/utility/assets.dart';

class BookApi {
  final String? id;
  final String? title;
  final String authors;
  final int? pageCount;
  final String description;
  final DateTime? publishedDate;
  final String? thumbnailUrl;

  BookApi(
    this.id,
    this.title,
    this.authors,
    this.pageCount,
    this.description,
    this.publishedDate,
    this.thumbnailUrl,
  );

  Widget get thumbnail => thumbnailUrl != null
      ? Image.network(thumbnailUrl!)
      : Image.asset(ConstantAssets.imgDefault, fit: BoxFit.fill, height: 160);
  //  CircleAvatar(child: Text(title[0]));

  BookApi.fromJson(Map<String, dynamic> jsonMap)
      : id = jsonMap['id'] as String?,
        title = jsonMap['volumeInfo']['title'] as String?,
        // authors = (jsonMap['volumeInfo']['authors'] as List).join(', '),
        authors = jsonMap['volumeInfo']['authors'] != null
            ? (jsonMap['volumeInfo']['authors'] as List)[0]
            : "_",
        pageCount = jsonMap['volumeInfo']['pageCount'] != null
            ? jsonMap['volumeInfo']['pageCount'] as int?
            : 0,
        description = jsonMap['volumeInfo']['description'] as String? ?? '_',
        publishedDate = jsonMap['volumeInfo']['publishedDate'] != null &&
                jsonMap['volumeInfo']['publishedDate'].length > 8
            ? DateTime.parse(jsonMap['volumeInfo']['publishedDate'])
            : null,
        thumbnailUrl = jsonMap['volumeInfo']['imageLinks'] != null
            ? jsonMap['volumeInfo']['imageLinks']['smallThumbnail'] as String?
            : null;

  static List<BookApi> parseFromJsonStr(String jsonStr) {
    final json = jsonDecode(jsonStr);

    if (json['items'] == null) return [];

    final jsonList = json['items'] as List<dynamic>;

    return [
      for (final jsonMap in jsonList)
        BookApi.fromJson(jsonMap as Map<String, dynamic>)
    ];
  }
}
