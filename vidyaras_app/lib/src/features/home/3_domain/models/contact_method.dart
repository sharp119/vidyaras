import 'package:flutter/material.dart';

/// Enum representing different contact methods for enrollment
enum ContactMethod {
  share('Share via Apps', Icons.share_outlined),
  phone('Call Us', Icons.phone_outlined);

  const ContactMethod(this.label, this.icon);

  final String label;
  final IconData icon;
}
