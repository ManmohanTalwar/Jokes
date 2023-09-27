class Joke {
  String? joke;

  Joke({this.joke});

  factory Joke.fromJson(Map<String, dynamic> json) => Joke(
        joke: json['joke'] ?? '',
      );

  toJson() => {
        'joke': joke,
      };
}

class JokeList {
  final List<Joke>? jokes;

  JokeList({this.jokes});

  factory JokeList.fromJson(Map<String, dynamic> json) => JokeList();
}
