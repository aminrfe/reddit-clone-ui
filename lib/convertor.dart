import 'package:reddit_clone_ui/Models/user_model.dart';

import 'Models/comment_model.dart';
import 'Models/forum_model.dart';
import 'Models/post_model.dart';

class Convertor {
  static Map<String, String> stringToMap(String data) {
    Map<String, String> map = <String, String>{};
    List<String> pairs = data.trim().split("\\|\\|");

    for (String pair in pairs) {
      if (pair.length > 2 && pair.contains("::")) {
        int delIndex = pair.indexOf("::");
        String key = pair.substring(0, delIndex);
        String value = pair.substring(delIndex + 2);

        map[key] = value;
      }
    }
    return map;
  }

  static String mapToString(Map<String, String> map) {
    StringBuffer sb = StringBuffer();

    map.forEach((key, value) {
      sb.write(key);
      sb.write("::");
      sb.write(value);
      sb.write("||");
    });

    return sb.toString().substring(0, sb.length - 2);
  }

  static Map<String, String> merge(
      Map<String, String> map1, Map<String, String> map2) {
    Map<String, String> result = <String, String>{};

    map1.forEach((key, value) => {
          if (map2.containsKey(key))
            {result[key] = map2[key]}
          else
            {result[key] = value}
        });
    return result;
  }

  static List<String> stringToList(String data) {
    return data.trim().split(",");
  }

  static String listToString(List<String> list) {
    if (list.isEmpty) {
      return "-";
    }
    StringBuffer sb = StringBuffer();
    for (String element in list) {
      sb.write(element);
      sb.write(",");
    }

    return sb.toString().substring(0, sb.length - 1);
  }

  static Map<String, String> modelToMap(dynamic model) {
    Map<String, String> map = <String, String>{};
    if (model is UserModel) {
      map['username'] = model.username;
      map['password'] = model.password;
      map['email'] = model.email;
    } else if (model is PostModel) {
      map['id'] = model.id;
      map['title'] = model.title;
      map['desc'] = model.desc;
      map['date'] = model.date.toString();
      map['forum'] = model.forum.name;
    } else if (model is CommentModel) {
      map['id'] = model.id;
      map['user'] = model.user.username;
      map['comment'] = model.comment;
      map['date'] = model.date.toString();
    } else if (model is ForumModel) {
      map['name'] = model.name;
      map['desc'] = model.desc;
      map['admin'] = model.admin.username;
    }
    return map;
  }
}
