library colorize.test.polyfill;

import 'dart:html';

import 'package:colorize/polyfill.dart';
import 'package:unittest/unittest.dart';
import 'package:unittest/html_enhanced_config.dart';

void main() {
  useHtmlEnhancedConfiguration();
  group('Polyfill - ', () {
    var el;
    test('Throws Unsupported error if input type is wrong', () {
      el = new InputElement(type: 'date')..classes.add('colorize');
      document.body.children.add(el);
      expect(() => colorizeMe(), throwsUnsupportedError);
      el.remove();
    });
    
    test('Resizes the input element', () {
      var el = new InputElement()..classes.add('colorize');
      document.body.children.add(el);
      colorizeMe();
      expect(el.style.width, equals('44px'));
      expect(el.style.height, equals('23px'));
      el.remove();
    });
    
  });
  
  colorizeMe();
}