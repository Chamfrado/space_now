class Astronault {

  final String name;
  final String craft;
  

  const Astronault({

    required this.name,
    required this.craft,

  });

  factory Astronault.fromJson(Map<String, dynamic> json) {
    return Astronault(
    
      name: json['name'],
      craft: json['craft'],
      
    );
  }
}
