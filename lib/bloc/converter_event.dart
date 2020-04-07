part of 'converter_bloc.dart';

@immutable
abstract class ConverterEvent {}

class ConvertRealToCents extends ConverterEvent{
  final double brazilianRealValue;
  ConvertRealToCents(this.brazilianRealValue); 
}