import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  void change(int index) {
    emit(state.copyWith(index: index));
  }
}

class HomeState {
  final int index;

  const HomeState({this.index = 0});

  HomeState copyWith({int? index}) {
    return HomeState(
      index: index ?? this.index,
    );
  }
}