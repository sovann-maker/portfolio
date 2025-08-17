import 'dart:js_interop';

/// JavaScript interop bindings for modern WebAssembly-compatible Flutter web
@JS('window.open')
external void windowOpen(String url, [String? target, String? features]);

@JS('window.location.href')
external String get windowLocationHref;

@JS('window.location.href')
external set windowLocationHref(String url);

/// Helper function to open URL in new tab
void openUrlInNewTab(String url) {
  windowOpen(url, '_blank');
}

/// Helper function to navigate to URL in same tab
void navigateToUrl(String url) {
  windowLocationHref = url;
}

/// Helper function for mailto links
void openMailto(String email, {String? subject, String? body}) {
  final uri = StringBuffer('mailto:$email');
  final params = <String>[];
  
  if (subject != null) {
    params.add('subject=${Uri.encodeComponent(subject)}');
  }
  
  if (body != null) {
    params.add('body=${Uri.encodeComponent(body)}');
  }
  
  if (params.isNotEmpty) {
    uri.write('?${params.join('&')}');
  }
  
  windowLocationHref = uri.toString();
}