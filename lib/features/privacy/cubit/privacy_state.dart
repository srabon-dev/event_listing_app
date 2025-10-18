part of 'privacy_cubit.dart';

sealed class PrivacyState extends Equatable {
  const PrivacyState();
}

final class OtherPrivacyState extends PrivacyState {
  final ApiStatus status;
  final String description;
  const OtherPrivacyState({required this.status, required this.description});

  @override
  List<Object> get props => [status, description];
}
