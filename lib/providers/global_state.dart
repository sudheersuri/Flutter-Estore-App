import 'package:flutter_riverpod/flutter_riverpod.dart';

final productsProvider = StateProvider<dynamic>((_)=>[]);

final categoriesProvider = StateProvider<dynamic>((_)=>[]);

final cartItemsProvider = StateProvider<dynamic>((_)=>[]);

final favoritesProvider = StateProvider<dynamic>((_)=>[]);

final loggedInProvider = StateProvider<dynamic>((_)=> false);

updateState(ref,targeProvider,newState) {
  ref.read(targeProvider.notifier).update((state) => newState);
}

watch(ref,targetProvider) {
  return ref.watch(targetProvider);
}
