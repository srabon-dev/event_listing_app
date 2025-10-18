part of 'terms_cubit.dart';

sealed class TermsState extends Equatable {
  const TermsState();
}

final class OtherTermsState extends TermsState {
  final ApiStatus status;
  final String description;
  const OtherTermsState({required this.status, required this.description});

  @override
  List<Object> get props => [status, description];
}