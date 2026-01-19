enum sport {
    tennis,
    cricket,
    basketball,
}

class Court {
  final String id;
  final String name;
  final String referenceNumber;
  final String description;
  final String imageUrl;
  final int maxPlayers;
  final int minHours;
  final bool isActive;

  const Court({
    required this.id,
    required this.name,
    required this.referenceNumber,
    required this.description,
    required this.imageUrl,
    required this.maxPlayers,
    required this.minHours,
    required this.isActive,
  });
}