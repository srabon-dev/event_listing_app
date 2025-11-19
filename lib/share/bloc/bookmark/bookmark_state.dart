part of 'bookmark_cubit.dart';

sealed class BookmarkState extends Equatable {
  const BookmarkState();
}

final class BookmarkInitial extends BookmarkState {
  @override
  List<Object> get props => [];
}

class BookmarkToggle extends BookmarkState{
  final bool isLoading;
  final String? error;
  final String? message;
  final bool isVerified;

  const BookmarkToggle({
    this.isLoading = false,
    this.error,
    this.message,
    this.isVerified = false,
  });

  @override
  List<Object?> get props => [isLoading, error, isVerified, message];
}