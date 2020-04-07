part of 'converter_bloc.dart';

@immutable
abstract class ConverterState {}

class ConverterInitial extends ConverterState {}

class ConvertedValue extends ConverterState{
  final BagOfCoins bagOfCoins;

  ConvertedValue(this.bagOfCoins);
}