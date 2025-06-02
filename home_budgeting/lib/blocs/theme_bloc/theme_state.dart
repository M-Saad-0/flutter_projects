part of 'theme_bloc.dart';

sealed class ThemeState extends Equatable {
  const ThemeState();

  @override
  List<Object> get props => [];
}


final class ThemeThemeToggledState extends ThemeState {
  final bool isDark;
  const ThemeThemeToggledState(this.isDark);
  @override
  List<Object > get props => [isDark];
}
