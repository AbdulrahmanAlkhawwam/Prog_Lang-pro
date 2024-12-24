part of 'product_bloc.dart';

@immutable
abstract class ProductEvent {}

final class GetProducts extends ProductEvent{}