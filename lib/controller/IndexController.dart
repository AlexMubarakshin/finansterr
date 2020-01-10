import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import 'package:finansterr/model/index.dart';

class IndexController {
  Future<List<Index>> fetchMajorIndexes() async {
    final response = await http
        .get("https://financialmodelingprep.com/api/v3/majors-indexes");

    if (response.statusCode == 200) {
      List majorIndexesList =
          convert.json.decode(response.body)['majorIndexesList'];

      List<Index> list =
          majorIndexesList.map((data) => new Index.fromJson(data)).toList();

      return list;
    } else {
      throw Exception('Failed to load indexes, code = ${response.statusCode}');
    }
  }
}
