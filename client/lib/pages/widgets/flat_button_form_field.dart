import 'package:coffee_break/domain/models/verb.dart';
import 'package:coffee_break/pages/search_verbs_page.dart';
import 'package:flutter/material.dart';

class FlatButtonFormField<T> extends StatefulWidget {
  const FlatButtonFormField({
    Key key,
    this.value,
    @required this.onPressed,
    @required this.labelBuilder,
    @required this.builder,
  })  : assert(onPressed != null),
        assert(labelBuilder != null),
        assert(builder != null),
        super(key: key);

  final T value;
  final Future<T> Function(T) onPressed;
  final String Function(T) labelBuilder;
  final Widget Function(T) builder;

  @override
  _FlatButtonFormFieldState createState() => _FlatButtonFormFieldState<T>();
}

class _FlatButtonFormFieldState<T> extends State<FlatButtonFormField<T>> {
  T _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) => FlatButton(
        padding: const EdgeInsets.all(0),
        splashColor: Colors.transparent,
        onPressed: () async {
          final value = await widget.onPressed(_value);
          setState(() => _value = value);
        },
        child: FormField<T>(
          builder: (state) {
            return InputDecorator(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: widget.labelBuilder(_value),
              ),
              isEmpty: _value == null,
              child: widget.builder(_value),
            );
          },
        ),
      );
}
