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
    int qtd50cents = 0;
    int qtd25cents = 0;
    int qtd10cents = 0;
    int qtd5cents = 0;
    int qtd1cent = 0;
    
    qtd50cents = (integerValue / 50).truncate();
    integerValue = integerValue % 50;

    qtd25cents = (integerValue / 25).truncate();
    integerValue = integerValue % 25;

    qtd10cents = (integerValue / 10).truncate();
    integerValue = integerValue % 10;

    qtd5cents = (integerValue / 5).truncate();
    integerValue = integerValue % 5;

    qtd1cent = integerValue;

    return BagOfCoins(qtd50cents, qtd25cents, qtd10cents, qtd5cents, qtd1cent);

  }
}
