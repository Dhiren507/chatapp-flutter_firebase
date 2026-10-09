import 'package:flutter_bloc/flutter_bloc.dart';

class TabBarIndexCubit extends Cubit<int> {
  TabBarIndexCubit() : super(0);

  void changeTabBarIndex(int index) {
    print('tab bar index change called $index');
    emit(index);
  }
}
