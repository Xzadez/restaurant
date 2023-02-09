class DataRestaurant {
  List<Restaurants>? restaurants;

  DataRestaurant({this.restaurants});

  DataRestaurant.fromJson(Map<String, dynamic> json) {
    if (json['restaurants'] != null) {
      restaurants = <Restaurants>[];
      json['restaurants'].forEach((v) {
        restaurants!.add(Restaurants.fromJson(v));
      });
    }
  }
}

class Restaurants {
  String? id;
  String? name;
  String? description;
  String? pictureId;
  String? city;
  String? rating;
  Menus? menus;

  Restaurants(
      {this.id,
      this.name,
      this.description,
      this.pictureId,
      this.city,
      this.rating,
      this.menus});

  Restaurants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    pictureId = json['pictureId'];
    city = json['city'];
    rating = json['rating'].toString();
    menus = json['menus'] != null ? Menus.fromJson(json['menus']) : null;
  }
}

class Menus {
  List<Foods>? foods;
  List<Drinks>? drinks;

  Menus({this.foods, this.drinks});

  Menus.fromJson(Map<String, dynamic> json) {
    if (json['foods'] != null) {
      foods = <Foods>[];
      json['foods'].forEach((v) {
        foods!.add(Foods.fromJson(v));
      });
    }
    if (json['drinks'] != null) {
      drinks = <Drinks>[];
      json['drinks'].forEach((v) {
        drinks!.add(Drinks.fromJson(v));
      });
    }
  }
}

class Foods {
  String? name;

  Foods({this.name});

  Foods.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }
}

class Drinks {
  String? name;

  Drinks({this.name});

  Drinks.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }
}
