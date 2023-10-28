enum MaskSplitCharacter {
  none,
  dash,
  space,
}

extension MaskSplitCharacterExtension on MaskSplitCharacter {
  String get value {
    switch (this) {
      case MaskSplitCharacter.none:
        return '';
      case MaskSplitCharacter.dash:
        return '-';
      case MaskSplitCharacter.space:
        return ' ';
      default:
        return '';
    }
  }
}
