import 'package:flutter/material.dart' as material show SearchDelegate;
import 'package:flutter/material.dart';

abstract class SearchDelegate<T> extends material.SearchDelegate<T> {
  SearchDelegate({
    String searchFieldLabel,
    TextInputType keyboardType,
    TextInputAction textInputAction,
  }) : super(
          searchFieldLabel: searchFieldLabel,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
        );

  @override
  ThemeData appBarTheme(BuildContext context) {
    final theme = Theme.of(context);
    return theme.copyWith(
      primaryColor: theme.colorScheme.background,
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) => [
        IconButton(
          onPressed: () => query = '',
          icon: const Icon(Icons.close),
        ),
      ];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
        onPressed: () => close(context, null),
        icon: AnimatedIcon(
          progress: transitionAnimation,
          icon: AnimatedIcons.menu_arrow,
        ),
      );
}
