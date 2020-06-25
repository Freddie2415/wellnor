import 'package:equatable/equatable.dart';
import 'package:wellnor/models/models.dart';

abstract class ItemEvent extends Equatable {
  const ItemEvent();
}

class AddItemEvent extends ItemEvent {
  final Product product;

  const AddItemEvent(this.product);

  @override
  List<Object> get props => [product];
}

class RemoveItemEvent extends ItemEvent {
  final Product product;

  const RemoveItemEvent(this.product);

  @override
  List<Object> get props => [product];
}

class ClearItemEvent extends ItemEvent {
  final Product product;

  const ClearItemEvent(this.product);

  @override
  List<Object> get props => [product];
}

class UpdateItemEvent extends ItemEvent {
  final Product product;

  const UpdateItemEvent(this.product);

  @override
  List<Object> get props => [product];
}

class SyncItemEvent extends ItemEvent {
  final Product product;

  const SyncItemEvent({this.product});

  @override
  List<Object> get props => [product];
}
