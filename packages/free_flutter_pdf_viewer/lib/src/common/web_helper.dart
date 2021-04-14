import 'dart:html' as html;

/// Checks whether focus node of pdf page view has primary focus.
bool hasPrimaryFocus = false;

/// Prevent default menu.
void preventDefaultMenu() {
  html.window.document.onKeyDown.listen((e) => _preventSpecificDefaultMenu(e));
  html.window.document.onContextMenu.listen((e) => e.preventDefault());
}

/// Prevent specific default menu such as zoom panel,search.
void _preventSpecificDefaultMenu(e) {
  if (e.keyCode == 114 || (e.ctrlKey && e.keyCode == 70)) {
    e.preventDefault();
  }
  if (hasPrimaryFocus &&
      e.ctrlKey &&
      (e.keyCode == 48 || e.keyCode == 189 || e.keyCode == 187)) {
    e.preventDefault();
  }
}
