part of 'support_cubit.dart';

sealed class SupportState extends Equatable {
  const SupportState();
}

final class OtherSupportState extends SupportState {
  final ApiStatus status;
  final String description;
  const OtherSupportState({required this.status, required this.description});

  @override
  List<Object> get props => [status, description];
}
