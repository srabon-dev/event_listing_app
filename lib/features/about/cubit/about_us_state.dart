part of 'about_us_cubit.dart';

sealed class AboutUsState extends Equatable {
  const AboutUsState();
}

final class OtherAboutState extends AboutUsState {
  final ApiStatus status;
  final String description;
  const OtherAboutState({required this.status, required this.description});

  @override
  List<Object> get props => [status, description];
}
