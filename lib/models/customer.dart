import 'package:hive/hive.dart';
part 'customer.g.dart';

@HiveType(typeId: 1)
class Customer {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String mobile;
  @HiveField(2)
  final String address;
  @HiveField(3)
  final String id;

  Customer({
    required this.id,
    required this.name,
    required this.mobile,
    required this.address,
  });
}
