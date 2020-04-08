import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:brazilian_real_to_cents_converter/model/bag_of_coins.dart';
import 'package:meta/meta.dart';

part 'converter_event.dart';
part 'converter_state.dart';

class ConverterBloc extends Bloc<ConverterEvent, ConverterState> {
  @override
  ConverterState get initialState => ConverterInitial();

  @override
  Stream<ConverterState> mapEventToState(
    ConverterEvent event,
  ) async* {
    if (event is ConvertRealToCents) {
      yield ConvertedValue(_convertBrazilianRealToCoin(event.brazilianRealValue));
    }
  }

  BagOfCoins _convertBrazilianRealToCoin(double brazilianRealValue){
    int integerValue = (brazilianRealValue * 100).round();

    List<int> coinsValues = [50, 25, 10, 5, 1];
    List<int> coinsQtd = List<int>();

    for(int i = 0; i < coinsValues.length; i++){
      coinsQtd.add((integerValue / coinsValues[i]).truncate());
      integerValue = integerValue % coinsValues[i];
    }

    return BagOfCoins(coinsQtd[0], coinsQtd[1], coinsQtd[2], coinsQtd[3], coinsQtd[4]);
  }
}
