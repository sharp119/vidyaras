import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

/// Star rating display with number
/// Used for course ratings
class StarRating extends StatelessWidget {
  const StarRating({
    super.key,
    required this.rating,
    this.size = 16,
    this.showNumber = true,
    this.numberStyle,
  });

  final double rating;
  final double size;
  final bool showNumber;
  final TextStyle? numberStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.star,
          size: size,
          color: const Color(0xFFFBBF24), // Yellow/Amber
        ),
        if (showNumber) ...[
          SizedBox(width: size * 0.25),
          Text(
            rating.toStringAsFixed(1),
            style: numberStyle ??
                TextStyle(
                  fontSize: size * 0.875,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
          ),
        ],
      ],
    );
  }
}

/// Interactive star rating (for user input)
class InteractiveStarRating extends StatelessWidget {
  const InteractiveStarRating({
    super.key,
    required this.rating,
    required this.onRatingChanged,
    this.maxRating = 5,
    this.size = 32,
  });

  final double rating;
  final void Function(double) onRatingChanged;
  final int maxRating;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        maxRating,
        (index) => GestureDetector(
          onTap: () => onRatingChanged((index + 1).toDouble()),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size * 0.1),
            child: Icon(
              index < rating.floor()
                  ? Icons.star
                  : (index < rating ? Icons.star_half : Icons.star_border),
              size: size,
              color: const Color(0xFFFBBF24),
            ),
          ),
        ),
      ),
    );
  }
}
