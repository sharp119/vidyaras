import 'package:flutter/material.dart';
import '../../../../shared/presentation/theme/app_colors.dart';

/// Question navigator showing numbered boxes for each question
/// with different states (current, answered, not answered)
class QuestionNavigator extends StatefulWidget {
  const QuestionNavigator({
    super.key,
    required this.totalQuestions,
    required this.currentQuestionIndex,
    required this.answeredQuestions,
    required this.onQuestionTap,
  });

  final int totalQuestions;
  final int currentQuestionIndex;
  final Set<int> answeredQuestions; // Set of answered question indices
  final Function(int) onQuestionTap;

  @override
  State<QuestionNavigator> createState() => _QuestionNavigatorState();
}

class _QuestionNavigatorState extends State<QuestionNavigator> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Scroll to current question after initial build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToCurrentQuestion();
    });
  }

  @override
  void didUpdateWidget(QuestionNavigator oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Auto-scroll when current question changes
    if (oldWidget.currentQuestionIndex != widget.currentQuestionIndex) {
      _scrollToCurrentQuestion();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToCurrentQuestion() {
    if (!_scrollController.hasClients) return;

    // Calculate the position of the current question box
    // Each box is 56px wide + 8px spacing = 64px total
    const boxWidth = 56.0;
    const spacing = 8.0;
    const totalBoxWidth = boxWidth + spacing;

    // Calculate scroll position to center the current question
    final targetScrollPosition = (widget.currentQuestionIndex * totalBoxWidth) -
        (MediaQuery.of(context).size.width / 2) +
        (boxWidth / 2);

    // Clamp to valid scroll range
    final maxScroll = _scrollController.position.maxScrollExtent;
    final minScroll = _scrollController.position.minScrollExtent;
    final clampedPosition = targetScrollPosition.clamp(minScroll, maxScroll);

    // Animate to the position
    _scrollController.animateTo(
      clampedPosition,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(
          top: BorderSide(
            color: AppColors.border.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            const Text(
              'Question Navigator',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),

            // Question number grid - Horizontally scrollable with auto-scroll
            SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(widget.totalQuestions, (index) {
                  final isCurrent = index == widget.currentQuestionIndex;
                  final isAnswered = widget.answeredQuestions.contains(index);

                  return Padding(
                    padding: EdgeInsets.only(
                      right: index < widget.totalQuestions - 1 ? 8.0 : 0.0,
                    ),
                    child: _QuestionNumberBox(
                      number: index + 1,
                      isCurrent: isCurrent,
                      isAnswered: isAnswered,
                      onTap: () => widget.onQuestionTap(index),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 20),

            // Legend
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _LegendItem(
                  color: AppColors.textPrimary,
                  label: 'Current',
                ),
                const SizedBox(width: 24),
                _LegendItem(
                  color: AppColors.success,
                  label: 'Answered',
                ),
                const SizedBox(width: 24),
                _LegendItem(
                  color: AppColors.border,
                  label: 'Not Answered',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Individual question number box
class _QuestionNumberBox extends StatelessWidget {
  const _QuestionNumberBox({
    required this.number,
    required this.isCurrent,
    required this.isAnswered,
    required this.onTap,
  });

  final int number;
  final bool isCurrent;
  final bool isAnswered;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color textColor;
    Color borderColor;
    double borderWidth;

    if (isCurrent) {
      backgroundColor = AppColors.textPrimary;
      textColor = AppColors.textOnPrimary;
      borderColor = AppColors.textPrimary;
      borderWidth = 2;
    } else if (isAnswered) {
      backgroundColor = AppColors.surface;
      textColor = AppColors.success;
      borderColor = AppColors.success;
      borderWidth = 2;
    } else {
      backgroundColor = AppColors.surface;
      textColor = AppColors.textSecondary;
      borderColor = AppColors.border;
      borderWidth = 1;
    }

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(
            color: borderColor,
            width: borderWidth,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            number.toString(),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}

/// Legend item showing color and label
class _LegendItem extends StatelessWidget {
  const _LegendItem({
    required this.color,
    required this.label,
  });

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    final bool isCurrent = color == AppColors.textPrimary;
    final bool isNotAnswered = color == AppColors.border;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: isCurrent
                ? AppColors.textPrimary
                : (isNotAnswered ? AppColors.surface : AppColors.surface),
            border: Border.all(
              color: color,
              width: isCurrent || !isNotAnswered ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
