import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const Color violet = Color(0xFF8416BC);

class MealInputWidgets {
  static Widget buildValidatedTextField({
    required TextEditingController controller,
    required String hint,
    required String errorHint,
    required bool showError,
    required VoidCallback onValidInput,
    int maxLines = 1,
  }) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, _) {
        bool localError = showError && value.text.trim().isEmpty;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: localError ? violet : Colors.transparent,
              width: 1.4,
            ),
          ),
          child: TextField(
            controller: controller,
            maxLines: maxLines,
            style: const TextStyle(color: Colors.white),
            onChanged: (_) {
              if (localError && controller.text.trim().isNotEmpty) {
                onValidInput();
              }
            },
            decoration: InputDecoration(
              hintText: localError ? errorHint : hint,
              hintStyle: TextStyle(
                color: localError ? Colors.redAccent : Colors.white54,
              ),
              filled: true,
              fillColor: const Color(0xFF1E1E1E),
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            ),
          ),
        );
      },
    );
  }

  /// SMALL FIELD (Ingredient / Qty)
  static Widget buildSmallFieldValidated(
    String hint,
    TextEditingController controller,
    bool showError, {
    required String errorHint,
    VoidCallback? onValidInput,
  }) {
    bool isQuantityField = hint.toLowerCase().contains("qty");

    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, _) {
        bool localError = showError && value.text.trim().isEmpty;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: localError ? violet : Colors.transparent,
              width: 1.4,
            ),
          ),
          child: TextField(
            controller: controller,

            /// FIXED KEYBOARD TYPE
            keyboardType: isQuantityField
                ? const TextInputType.numberWithOptions(decimal: true)
                : TextInputType.text,

            /// ONLY APPLY NUMBER FILTER TO QTY
            inputFormatters: isQuantityField
                ? [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))]
                : null,

            style: const TextStyle(color: Colors.white, fontSize: 13),

            onChanged: (_) {
              if (localError && controller.text.trim().isNotEmpty) {
                onValidInput?.call();
              }
            },

            decoration: InputDecoration(
              hintText: localError ? errorHint : hint,
              hintStyle: TextStyle(
                color: localError ? Colors.redAccent : Colors.white54,
                fontSize: 13,
              ),
              filled: true,
              fillColor: const Color(0xFF1E1E1E),
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            ),
          ),
        );
      },
    );
  }

  static Widget buildTextFieldValidated(
    TextEditingController controller,
    bool showError, {
    required String errorHint,
    VoidCallback? onValidInput,
  }) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, _) {
        bool localError = showError && value.text.trim().isEmpty;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: localError ? violet : Colors.transparent,
              width: 1.4,
            ),
          ),
          child: TextField(
            controller: controller,
            maxLines: 2,
            style: const TextStyle(color: Colors.white),
            onChanged: (_) {
              if (localError && controller.text.trim().isNotEmpty) {
                onValidInput?.call();
              }
            },
            decoration: InputDecoration(
              hintText: localError ? errorHint : "Step details",
              hintStyle: TextStyle(
                color: localError ? Colors.redAccent : Colors.white54,
              ),
              filled: true,
              fillColor: const Color(0xFF1E1E1E),
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            ),
          ),
        );
      },
    );
  }

  static Widget buildMacroField(
      String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70, fontSize: 12),
        filled: true,
        fillColor: const Color(0xFF2C2C2C),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      ),
    );
  }

  static Widget buildAddButton(String label, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.white30),
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          "+ $label",
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
      ),
    );
  }
}
