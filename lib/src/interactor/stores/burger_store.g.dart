// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'burger_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BurgerStore on _BurgerStoreBase, Store {
  late final _$stateAtom =
      Atom(name: '_BurgerStoreBase.state', context: context);

  @override
  BurgerState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(BurgerState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$fetchBurgsAsyncAction =
      AsyncAction('_BurgerStoreBase.fetchBurgs', context: context);

  @override
  Future<void> fetchBurgs() {
    return _$fetchBurgsAsyncAction.run(() => super.fetchBurgs());
  }

  late final _$_BurgerStoreBaseActionController =
      ActionController(name: '_BurgerStoreBase', context: context);

  @override
  void cleanCartBurger() {
    final _$actionInfo = _$_BurgerStoreBaseActionController.startAction(
        name: '_BurgerStoreBase.cleanCartBurger');
    try {
      return super.cleanCartBurger();
    } finally {
      _$_BurgerStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addBurgerToCart(BurgerModel burger) {
    final _$actionInfo = _$_BurgerStoreBaseActionController.startAction(
        name: '_BurgerStoreBase.addBurgerToCart');
    try {
      return super.addBurgerToCart(burger);
    } finally {
      _$_BurgerStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeBurgerToCart(BurgerModel burger) {
    final _$actionInfo = _$_BurgerStoreBaseActionController.startAction(
        name: '_BurgerStoreBase.removeBurgerToCart');
    try {
      return super.removeBurgerToCart(burger);
    } finally {
      _$_BurgerStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
state: ${state}
    ''';
  }
}
