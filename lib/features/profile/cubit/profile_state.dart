part of 'profile_cubit.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

final class ProfileLoaded extends ProfileState {
  final Map<String, String> data;
  const ProfileLoaded({required this.data});

  @override
  List<Object?> get props => [data];
}
