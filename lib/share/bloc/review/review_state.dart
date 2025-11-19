part of 'review_cubit.dart';

sealed class ReviewState extends Equatable {
  const ReviewState();
}

final class ReviewInitial extends ReviewState {
  @override
  List<Object> get props => [];
}

class ReviewAdd extends ReviewState {
  final bool isLoading;
  final String? error;
  final String? message;
  final bool isVerified;

  const ReviewAdd({
    this.isLoading = false,
    this.error,
    this.message,
    this.isVerified = false,
  });

  @override
  List<Object?> get props => [isLoading, error, isVerified, message];
}