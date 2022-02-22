import 'dart:async';

import 'package:flutter/material.dart';
import 'package:heal_happy/common/presentation/loading.dart';
import 'package:heal_happy/common/utils/constants.dart';
import 'package:heal_happy/common/utils/extensions.dart';
import 'package:stream_transform/stream_transform.dart';

typedef AutocompleteDelegate<T> = Future<List<T>> Function(String query);

class AutocompleteFormField<T> extends StatelessWidget {
  final InputDecoration? decoration;
  final FocusNode? focusNode;
  final bool autofocus;
  final int maxLines;
  final int? itemExtent;
  final int characterThreshold;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final int nbVisibleResults;
  final TextEditingController? controller;
  final Widget Function(BuildContext context, T entry) itemBuilder;
  final AutocompleteDelegate<T> delegate;
  final Function(T entry) onItemSelected;

  const AutocompleteFormField(
      {Key? key,
      this.itemExtent,
      this.keyboardType,
      this.validator,
      this.maxLines = 1,
      this.autofocus = false,
      this.controller,
      this.nbVisibleResults = 3,
      this.characterThreshold = 3,
      required this.onItemSelected,
      required this.itemBuilder,
      required this.delegate,
      this.focusNode,
      this.decoration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _RawAutocompleteField(
      onItemSelected: onItemSelected,
      itemBuilder: itemBuilder,
      delegate: delegate,
      validator: validator,
      nbVisibleResults: nbVisibleResults,
      maxLines: maxLines,
      autofocus: autofocus,
      decoration: decoration,
      characterThreshold: characterThreshold,
      focusNode: focusNode,
      controller: controller,
      isForm: true,
      itemExtent: itemExtent,
      keyboardType: keyboardType,
    );
  }
}

class AutocompleteField<T> extends StatelessWidget {
  final InputDecoration? decoration;
  final FocusNode? focusNode;
  final bool autofocus;
  final int maxLines;
  final int characterThreshold;
  final int? itemExtent;
  final int nbVisibleResults;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final Widget Function(BuildContext context, T entry) itemBuilder;
  final AutocompleteDelegate<T> delegate;
  final Function(T entry) onItemSelected;

  const AutocompleteField(
      {Key? key,
      this.itemExtent,
      this.keyboardType,
      this.nbVisibleResults = 3,
      this.maxLines = 1,
      this.autofocus = false,
      this.characterThreshold = 3,
      this.controller,
      required this.onItemSelected,
      required this.itemBuilder,
      required this.delegate,
      this.focusNode,
      this.decoration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _RawAutocompleteField(
      onItemSelected: onItemSelected,
      itemBuilder: itemBuilder,
      delegate: delegate,
      characterThreshold: characterThreshold,
      maxLines: maxLines,
      nbVisibleResults: nbVisibleResults,
      autofocus: autofocus,
      decoration: decoration,
      focusNode: focusNode,
      controller: controller,
      isForm: false,
      itemExtent: itemExtent,
      keyboardType: keyboardType,
    );
  }
}

class AutocompleteBloc<T> {
  final AutocompleteDelegate<T> delegate;
  final _query = StreamController<String>.broadcast();
  final _results = StreamController<List<T>>.broadcast();

  AutocompleteBloc(this.delegate) {
    final StreamTransformer<String, String> debounce = StreamTransformer.fromBind((s) => s.debounce(const Duration(milliseconds: 500)));

    _query.stream.distinct().transform(debounce).listen(_search);
  }

  void _search(String query) async {
    final results = await delegate(query.trim());
    if (!_results.isClosed) {
      _results.add(results);
    }
  }

  void refresh(String query) async {
    _search(query);
  }

  Sink<String> get query => _query.sink;

  Stream<List<T>> get results => _results.stream;

  Future<void> dispose() async {
    await _query.close();
    await _results.close();
  }
}

class _RawAutocompleteField<T> extends StatefulWidget {
  final InputDecoration? decoration;
  final bool isForm;
  final FocusNode? focusNode;
  final bool autofocus;
  final int maxLines;
  final int? itemExtent;
  final int characterThreshold;
  final int nbVisibleResults;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final Widget Function(BuildContext context, T entry) itemBuilder;
  final AutocompleteDelegate<T> delegate;
  final Function(T entry) onItemSelected;

  const _RawAutocompleteField(
      {Key? key,
      this.isForm = false,
      this.itemExtent,
      this.nbVisibleResults = 3,
      this.validator,
      this.keyboardType,
      this.maxLines = 1,
      this.autofocus = false,
      this.controller,
      this.characterThreshold = 3,
      required this.onItemSelected,
      required this.itemBuilder,
      required this.delegate,
      this.focusNode,
      this.decoration})
      : super(key: key);

  @override
  _RawAutocompleteFieldState<T> createState() => _RawAutocompleteFieldState<T>();
}

class _RawAutocompleteFieldState<T> extends State<_RawAutocompleteField<T>> {
  late final FocusNode _focusNode;
  late final TextEditingController _controller;
  late final AutocompleteBloc<T> _bloc = AutocompleteBloc<T>(widget.delegate);
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();

  @override
  void initState() {
    _controller = widget.controller ?? TextEditingController(text: '');

    _focusNode = widget.focusNode ?? FocusNode();

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        if (_controller.text.length >= widget.characterThreshold) {
          _showOverlay();
          WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
            _bloc.refresh(_controller.text);
          });
        }
      } else {
        _hideOverlay();
      }
    });
    super.initState();
  }

  void _showOverlay() {
    if (_overlayEntry != null) {
      _hideOverlay();
    }
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context)!.insert(_overlayEntry!);
  }

  void _hideOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }

  OverlayEntry _createOverlayEntry() {
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height + 5.0),
          child: Material(
            elevation: 4.0,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: (widget.itemExtent ?? size.height) * widget.nbVisibleResults.toDouble()),
              child: StreamBuilder<List<T>>(
                stream: _bloc.results,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Padding(
                      padding: const EdgeInsets.all(kNormalPadding),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Center(child: Loading()),
                        ],
                      ),
                    );
                  }

                  if (!snapshot.hasData || snapshot.requireData.isEmpty) {
                    return InkWell(
                      onTap: () {
                        _hideOverlay();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(kNormalPadding),
                        child: Row(
                          children: [
                            Expanded(child: Text(context.l10n.noResults)),
                            const Icon(Icons.close, color: Colors.grey),
                          ],
                        ),
                      ),
                    );
                  }

                  return Scrollbar(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final data = snapshot.data!;
                        final entry = data[index];

                        return InkWell(
                          onTap: () {
                            widget.onItemSelected(entry);
                            _hideOverlay();
                          },
                          child: widget.itemBuilder(context, entry),
                        );
                      },
                      itemCount: snapshot.data!.length,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: widget.isForm
          ? TextFormField(
              focusNode: _focusNode,
              maxLines: widget.maxLines,
              autofocus: widget.autofocus,
              validator: widget.validator,
              keyboardType: widget.keyboardType,
              controller: _controller,
              onChanged: (value) {
                if (value.length >= widget.characterThreshold) {
                  _bloc.query.add(value);
                  if (_overlayEntry == null) {
                    _showOverlay();
                  }
                } else {
                  _hideOverlay();
                }
              },
              decoration: widget.decoration,
            )
          : TextField(
              focusNode: _focusNode,
              maxLines: widget.maxLines,
              autofocus: widget.autofocus,
              keyboardType: widget.keyboardType,
              controller: _controller,
              onChanged: (value) {
                if (value.length >= widget.characterThreshold) {
                  _bloc.query.add(value);
                  if (_overlayEntry == null) {
                    _showOverlay();
                  }
                } else {
                  _hideOverlay();
                }
              },
              decoration: widget.decoration,
            ),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}
