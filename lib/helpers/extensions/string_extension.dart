extension StringExtension on String {
  String capitalizeString() => "${this[0].toUpperCase()}${this.substring(1)}";
}
