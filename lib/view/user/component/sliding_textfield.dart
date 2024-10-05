import 'dart:async';

import 'package:crave_wave_app/components/color.dart';
import 'package:flutter/material.dart';

class SlidingTextField extends StatefulWidget {
  final TextEditingController controller;
  const SlidingTextField({
    super.key,
    required this.controller,
  });

  @override
  State<SlidingTextField> createState() => _SlidingTextFieldState();
}

class _SlidingTextFieldState extends State<SlidingTextField>
    with SingleTickerProviderStateMixin {
  final List<String> _hints = [
    'Search "Burger"',
    'Search "Pasta"',
    'Search "Pizza"',
    'Search "Cake"',
    'Search "Chinese"',
    'Search "Icecream"',
    'Search "Momos"',
    'Search "Pancake"',
    'Search "Pizza"',
    'Search "Rolls"',
    'Search "Shakes"',
    'Search "Shawarma"',
    'Search "Snacks"',
    'Search "Waffle"',
  ];
  int _currentHintIndex = 0;
  Timer? _timer;
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  bool _showHint = true;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    // Slide animation for sliding text effect
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1), // Start from above
      end: const Offset(0, 0), // Slide in to normal position
    ).animate(_animationController);

    // Start the hint text cycling and animation
    _startHintTextRotation();

    widget.controller.addListener(_onTextChanged);
    _focusNode.addListener(_onFocusChanged);
  }

  void _onTextChanged() {
    setState(() {
      // Show hint if the text field is empty, otherwise hide it
      _showHint = widget.controller.text.isEmpty && !_focusNode.hasFocus;
    });
  }

  void _onFocusChanged() {
    setState(() {
      // Hide the hint when the field is focused, show it when unfocused and empty
      _showHint = !_focusNode.hasFocus && widget.controller.text.isEmpty;
    });
  }

  void _startHintTextRotation() {
    // Start an infinite timer to rotate hints and reset animation
    _timer = Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      if (_showHint) {
        _animationController.reset(); // Reset the animation
        setState(() {
          _currentHintIndex =
              (_currentHintIndex + 1) % _hints.length; // Update hint
        });
        _animationController.forward(); // Play the slide animation
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animationController.dispose();
    _focusNode.dispose();
    // No need to dispose the controller here since it's passed by the parent widget
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: backgroundColor,
      controller: widget.controller,
      focusNode: _focusNode,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 1, color: Colors.grey.shade400)),
        enabled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(width: 1, color: Colors.grey.shade200),
        ),
        prefixIcon: Padding(
          padding:
              const EdgeInsets.only(left: 8.0), // Add padding to prefix icon
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.search, color: backgroundColor), // Search icon
              const SizedBox(width: 8), // Space between icon and text
              // Show the hint only when the text field is empty
              if (_showHint)
                ClipRect(
                  child: AnimatedBuilder(
                    animation: _slideAnimation,
                    builder: (context, child) {
                      return SlideTransition(
                        position: _slideAnimation,
                        child: Text(
                          _hints[_currentHintIndex],
                          key: ValueKey<String>(_hints[_currentHintIndex]),
                          style: const TextStyle(
                              color: backgroundColor, fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
        hintText: null,
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w500,
        ),
        fillColor: Colors.grey.shade200,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
      ),
    );
  }
}
