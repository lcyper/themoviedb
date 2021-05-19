import 'package:themoviedb/class/Movies.dart'; // var imageAlternative

class Actors {
  final String name;
  final String character;
  final String image;
  final int order;
  final String creditId;

  Actors({this.name, this.character, this.image, this.order, this.creditId});
  factory Actors.fromJson(Map actorsData) {
    //    String name=actorsData['name'];
    // final String character;
    // final String image;
    // final int order;
    // final String credit_id;
    return Actors(
      name: actorsData['name'],
      character: actorsData['character'],
      image: actorsData['image'] ?? imageAlternative,
      order: actorsData['order'],
      creditId: actorsData['credit_id'],
    );
  }
  List toJSONEncodable(List<Actors> actors) {
    // print(this);
    List list = actors.map((a) {
      
      Map<String, dynamic> map = {
        'name': a.name,
        'character': a.character,
        'image': a.image,
        'order': a.order,
        'creditId': a.creditId,
      };
      return map;
    }).toList();
    return list;
  }
}
