library;

import 'package:flutter/material.dart';

/// A customizable dropdown widget that displays a menu in an overlay.
class StyledDropDown extends StatefulWidget {
  /// Optional label displayed above the dropdown.
  final String? label;
  final Color? mainContainerColor;
  final BorderRadiusGeometry? mainContainerRaduis;
  final BoxBorder? mainContainerBorder;
  final Widget? dropIcon;
  final Color? itemContainerColor;
  final double? itemContainerHight;
  final TextDirection itemDirection;
  final bool? itemIsImage;
  final Color? activeColorbtn;
  final Color? fillColorbtn;
  final Color? dropDownBodyColor;
  final TextStyle? labelStyle;
  final TextStyle? itemTextStyle;
  final TextStyle? valueTextStyle;

  /// The currently selected value.
  final String value;

  /// The list of items to display in the dropdown menu.
  final List<String> items;

  /// Callback invoked when a new item is selected.
  final Function(String) onChanged;

  /// Maximum height of the dropdown menu.
  final double maxHeight;

  /// Right padding for the dropdown menu.
  final double menuRightPadding;

  /// Optional: Provide a custom builder for each dropdown item.
  /// If null, default rendering (radio+text/image) is used.
  final Widget Function(BuildContext context, String item, bool selected)?
      itemBuilder;

  /// Whether the dropdown selection is required.
  final bool isRequired;

  /// Optional: Custom error message when required and not selected.
  final String? requiredErrorText;

  const StyledDropDown({
    super.key,
    this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.maxHeight = 300,
    this.menuRightPadding = 5.0,
    this.mainContainerColor = Colors.white,
    this.dropDownBodyColor = Colors.white,
    this.mainContainerRaduis = const BorderRadius.all(Radius.circular(8)),
    this.mainContainerBorder = const Border.fromBorderSide(
      BorderSide(color: Color(0xFFE0E0E0)),
    ),
    this.dropIcon = const Icon(Icons.keyboard_arrow_down),
    this.itemContainerColor = const Color(0xFFF5F5F5),
    this.itemContainerHight = 40,
    this.itemDirection = TextDirection.ltr,
    this.itemIsImage,
    this.activeColorbtn,
    this.fillColorbtn,
    this.labelStyle,
    this.itemTextStyle,
    this.valueTextStyle,
    this.itemBuilder,
    this.isRequired = false,
    this.requiredErrorText,
  });

  @override
  State<StyledDropDown> createState() => _StyledDropDownState();
}

class _StyledDropDownState extends State<StyledDropDown> {
  final LayerLink _layerLink = LayerLink();
  bool _isOpen = false;
  OverlayEntry? _overlayEntry;

  String? _errorText;

  @override
  void initState() {
    super.initState();
    // Validate that value is in items or items is not empty
    if (widget.items.isNotEmpty && !widget.items.contains(widget.value)) {
      debugPrint(
        'Warning: CustomDropdown value "${widget.value}" is not in items list.',
      );
    }
    _validate();
  }

  @override
  void didUpdateWidget(covariant StyledDropDown oldWidget) {
    super.didUpdateWidget(oldWidget);
    _validate();
  }

  void _validate() {
    if (widget.isRequired) {
      if (widget.value.isEmpty || !widget.items.contains(widget.value)) {
        setState(() {
          _errorText = widget.requiredErrorText ?? 'This field is required';
        });
      } else {
        setState(() {
          _errorText = null;
        });
      }
    } else {
      setState(() {
        _errorText = null;
      });
    }
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool showError = _errorText != null && _errorText!.isNotEmpty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null && widget.label!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: [
                Text(
                  widget.label!,
                  style: widget.labelStyle ??
                      Theme.of(context).textTheme.labelMedium,
                ),
                if (widget.isRequired)
                  const Text(' *', style: TextStyle(color: Colors.red)),
              ],
            ),
          ),
        CompositedTransformTarget(
          link: _layerLink,
          child: GestureDetector(
            onTap: _toggleDropdown,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: widget.mainContainerColor,
                borderRadius: widget.mainContainerRaduis,
                border: widget.mainContainerBorder,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widget.itemIsImage == true
                      ? Image.asset(
                          widget.value,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        )
                      : Text(
                          widget.value,
                          style: widget.valueTextStyle ??
                              Theme.of(context).textTheme.bodyMedium,
                        ),
                  widget.dropIcon ?? const Icon(Icons.keyboard_arrow_down),
                ],
              ),
            ),
          ),
        ),
        if (showError)
          Padding(
            padding: const EdgeInsets.only(top: 6.0, left: 4.0),
            child: Text(
              _errorText!,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }

  void _toggleDropdown() {
    if (_isOpen) {
      _overlayEntry?.remove();
      _isOpen = false;
    } else {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
      _isOpen = true;
    }
    setState(() {});
  }

  OverlayEntry _createOverlayEntry() {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: _toggleDropdown,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.transparent,
          child: Stack(
            children: [
              Positioned(
                left: offset.dx,
                top: offset.dy + size.height + 5,
                width: size.width,
                child: Container(
                  padding: EdgeInsets.only(right: widget.menuRightPadding),
                  child: Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(8),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: widget.maxHeight,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: widget.dropDownBodyColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Directionality(
                          textDirection: widget.itemDirection,
                          child: ListView(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            children: widget.items.map((item) {
                              final bool selected = item == widget.value;
                              Widget child;
                              if (widget.itemBuilder != null) {
                                child = widget.itemBuilder!(
                                  context,
                                  item,
                                  selected,
                                );
                              } else {
                                child = Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Show radio only if itemBuilder is not provided
                                    Radio<String>(
                                      value: item,
                                      groupValue: widget.value,
                                      onChanged:
                                          null, // handled by GestureDetector
                                      activeColor:
                                          widget.activeColorbtn ?? Colors.blue,
                                      fillColor: WidgetStateProperty.all(
                                        widget.fillColorbtn ?? Colors.blue,
                                      ),
                                    ),
                                    widget.itemIsImage == true
                                        ? Image.asset(
                                            item,
                                            width: 50,
                                            height: 50,
                                            fit: BoxFit.cover,
                                          )
                                        : Text(
                                            item,
                                            style: widget.itemTextStyle ??
                                                Theme.of(
                                                  context,
                                                ).textTheme.bodyMedium,
                                          ),
                                  ],
                                );
                              }
                              return GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  widget.onChanged(item);
                                  _toggleDropdown();
                                  _validate();
                                },
                                child: Container(
                                  height: widget.itemContainerHight,
                                  color: widget.itemContainerColor,
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 5,
                                    horizontal: 5,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      right: 5.0,
                                      left: 5,
                                    ),
                                    child: child,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
