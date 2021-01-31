class Prescription {
  final String id;
  final String name;
  final String description;
  final DateTime expiry;
  final String authoriztionId;
  final List<dynamic> directions;
  final String refills;

  Prescription({this.refills, this.authoriztionId, this.description, this.expiry, this.id, this.name, this.directions});

  
}