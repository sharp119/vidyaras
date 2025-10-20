import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../features/tests/3_domain/models/content_data.dart';

/// Universal widget to render any content type (text, LaTeX, image, etc.)
/// Supports the flexible content system from the database
class ContentWidget extends StatelessWidget {
  final ContentData contentData;
  final TextStyle? textStyle;
  final double? imageHeight;
  final double? imageWidth;

  const ContentWidget({
    super.key,
    required this.contentData,
    this.textStyle,
    this.imageHeight,
    this.imageWidth,
  });

  @override
  Widget build(BuildContext context) {
    switch (contentData.type) {
      case 'text':
        return _buildTextContent(context);
      case 'latex':
        return _buildLatexContent(context);
      case 'image_url':
        return _buildImageContent(context);
      case 'video_url':
        return _buildVideoPlaceholder(context);
      default:
        return _buildUnsupportedContent(context);
    }
  }

  Widget _buildTextContent(BuildContext context) {
    return Text(
      contentData.content,
      style: textStyle ??
          const TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
    );
  }

  Widget _buildLatexContent(BuildContext context) {
    // TODO: Integrate flutter_math_fork package for LaTeX rendering
    // For now, display as text with a LaTeX indicator
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.functions, size: 16, color: Colors.blue),
              SizedBox(width: 4),
              Text(
                'LaTeX',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            contentData.content,
            style: textStyle ??
                const TextStyle(
                  fontSize: 16,
                  fontFamily: 'monospace',
                  color: Colors.black87,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageContent(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: contentData.content,
      height: imageHeight ?? 200,
      width: imageWidth ?? double.infinity,
      fit: BoxFit.contain,
      placeholder: (context, url) => SizedBox(
        height: imageHeight ?? 200,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        height: imageHeight ?? 200,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.broken_image, size: 48, color: Colors.grey),
            SizedBox(height: 8),
            Text('Failed to load image', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoPlaceholder(BuildContext context) {
    return Container(
      height: imageHeight ?? 200,
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.play_circle_outline, size: 64, color: Colors.white),
          SizedBox(height: 8),
          Text(
            'Video Content',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildUnsupportedContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.orange[200]!),
      ),
      child: Row(
        children: [
          const Icon(Icons.warning, color: Colors.orange),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Unsupported content type: ${contentData.type}',
              style: const TextStyle(color: Colors.orange),
            ),
          ),
        ],
      ),
    );
  }
}
