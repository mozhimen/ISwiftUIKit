// The Swift Programming Language
// https://docs.swift.org/swift-book
//
//  WebView.swift
//
//
//  Created by 이웅재(NuPlay) on 2021/07/26.
//  https://github.com/NuPlay/RichText

import SwiftUI
import WebKit
import SafariServices

struct WebView {
    @Environment(\.multilineTextAlignment) var alignment
    @Binding var dynamicHeight: CGFloat
    
    let html: String
    let conf: Configuration
    let width: CGFloat
    
    init(width: CGFloat, dynamicHeight: Binding<CGFloat>, html: String, configuration: Configuration) {
        self._dynamicHeight = dynamicHeight
        
        self.html = html
        self.conf = configuration
        self.width = width
    }
}

#if canImport(UIKit)
import UIKit
extension WebView: UIViewRepresentable {
    func makeUIView(context: Context) -> WKWebView {
        let configuration = WKWebViewConfiguration()
        configuration.userContentController.add(context.coordinator, name: "notifyCompletion")
        let webview = WKWebView(frame: .zero, configuration: configuration)
        
        webview.scrollView.bounces = false
        webview.navigationDelegate = context.coordinator
        webview.scrollView.isScrollEnabled = false
        
        DispatchQueue.main.async {
            webview.loadHTMLString(generateHTML(), baseURL: conf.baseURL)
        }
        
        webview.isOpaque = false
        webview.backgroundColor = UIColor.clear
        webview.scrollView.backgroundColor = UIColor.clear
        
        return webview
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        DispatchQueue.main.async {
            uiView.loadHTMLString(generateHTML(), baseURL: conf.baseURL)
            uiView.frame.size = .init(width: width, height: dynamicHeight)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}
#else
import AppKit
private class ScrollAdjustedWKWebView: WKWebView {
    override public func scrollWheel(with event: NSEvent) {
        nextResponder?.scrollWheel(with: event)
    }
}

extension WebView: NSViewRepresentable {
    func makeNSView(context: Context) -> WKWebView {
        let configuration = WKWebViewConfiguration()
        configuration.userContentController.add(context.coordinator, name: "notifyCompletion")
        let webview = ScrollAdjustedWKWebView(frame: .zero, configuration: configuration)
        webview.navigationDelegate = context.coordinator
        DispatchQueue.main.async {
            webview.loadHTMLString(generateHTML(), baseURL: conf.baseURL)
        }
        webview.setValue(false, forKey: "drawsBackground")
        
        return webview
    }
    
    func updateNSView(_ nsView: WKWebView, context _: Context) {
        DispatchQueue.main.async {
            nsView.loadHTMLString(generateHTML(), baseURL: conf.baseURL)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}
#endif

extension WebView {
    class Coordinator: NSObject, WKNavigationDelegate, WKScriptMessageHandler {
        var parent: WebView
        
        init(_ parent: WebView) {
            self.parent = parent
        }
        
        
        func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
            if message.name == "notifyCompletion" {
                if let height = message.body as? NSNumber {
                    let cgFloatHeight = CGFloat(height.doubleValue)
                    DispatchQueue.main.async {
                        withAnimation(self.parent.conf.transition) {
                            self.parent.dynamicHeight = cgFloatHeight
                        }
                    }
                }
            }
        }
        
        func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
            print("webView didCommit")
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            print("webView didFinish")
        }
        
        //        func webView(_ webView: WKWebView, respondTo challenge: URLAuthenticationChallenge) async -> (URLSession.AuthChallengeDisposition, URLCredential?) {
        //            print("webView respondTo")
        //        }
        
        //        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction) async -> WKNavigationActionPolicy {
        //            print("webView decidePolicyFor")
        //        }
        
        //        func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse) async -> WKNavigationResponsePolicy {
        //            print("webView decidePolicyFor navigationResponse")
        //        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: any Error) {
            print("webView didFail withError")
        }
        
        @available(iOS 14.5, *)
        func webView(_ webView: WKWebView, navigationAction: WKNavigationAction, didBecome download: WKDownload) {
            print("webView navigationAction didBecome")
        }
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            print("webView didStartProvisionalNavigation")
        }
        
        //        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, preferences: WKWebpagePreferences) async -> (WKNavigationActionPolicy, WKWebpagePreferences) {
        //            print("webView decidePolicyFor preferences")
        //        }
        
        //        func webView(_ webView: WKWebView, shouldAllowDeprecatedTLSFor challenge: URLAuthenticationChallenge) async -> Bool {
        //            print("webview shouldAllowDeprecatedTLSFor")
        //        }
        
        func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping @MainActor (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
            print("webview decidePolicyFor didReceive completionHandler")
            // 默认处理：让系统处理所有认证挑战
            completionHandler(.performDefaultHandling, nil)
        }
        
        @available(iOS 14.5, *)
        func webView(_ webView: WKWebView, navigationResponse: WKNavigationResponse, didBecome download: WKDownload) {
            print("webview navigationResponse didBecome")
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping @MainActor (WKNavigationActionPolicy) -> Void) {
            print("webview decidePolicyFor decisionHandler")
            guard navigationAction.navigationType == WKNavigationType.linkActivated,
                  var url = navigationAction.request.url else {
                decisionHandler(WKNavigationActionPolicy.allow)
                print("webview fail")
                return
            }
            
            if case let .custom(action) = parent.conf.linkOpenType {
                action(url)
            } else {
                if url.scheme == nil {
                    guard let httpsURL = URL(string: "https://\(url.absoluteString)") else {
                        decisionHandler(WKNavigationActionPolicy.cancel)
                        return
                    }
                    url = httpsURL
                }
                
                switch url.scheme {
                case "mailto", "tel":
#if canImport(UIKit)
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
#else
                    NSWorkspace.shared.open(url)
#endif
                case "http", "https":
                    switch parent.conf.linkOpenType {
#if canImport(UIKit)
                    case let .SFSafariView(conf, isReaderActivated, isAnimated):
                        if let reader = isReaderActivated {
                            conf.entersReaderIfAvailable = reader
                        }
                        let root = UIApplication.shared.windows.first?.rootViewController
                        root?.present(SFSafariViewController(url: url, configuration: conf), animated: isAnimated, completion: nil)
#endif
                    case .Safari:
#if canImport(UIKit)
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
#else
                        NSWorkspace.shared.open(url)
#endif
                    case .none, .custom:
                        break
                    }
                default:
#if canImport(UIKit)
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
#else
                    NSWorkspace.shared.open(url)
#endif
                }
            }
            
            decisionHandler(WKNavigationActionPolicy.cancel)
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping @MainActor (WKNavigationResponsePolicy) -> Void) {
            print("webview decidePolicyFor decisionHandler")
        }
        
        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: any Error) {
            print("webview didFailProvisionalNavigation withError")
        }
        
        func webView(_ webView: WKWebView, authenticationChallenge challenge: URLAuthenticationChallenge, shouldAllowDeprecatedTLS decisionHandler: @escaping @MainActor (Bool) -> Void) {
            print("webview authenticationChallenge shouldAllowDeprecatedTLS")
        }
        
        func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
            print("webview didReceiveServerRedirectForProvisionalNavigation")
        }
        
        //        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, preferences: WKWebpagePreferences, decisionHandler: @escaping @MainActor (WKNavigationActionPolicy, WKWebpagePreferences) -> Void) {
        //            print("webview decidePolicyFor preferences")
        //        }
    }
}

extension WebView {
    func generateHTML() -> String {
        return """
            <HTML>
            <head>
                <meta name='viewport' content='width=device-width, shrink-to-fit=YES, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'>
            </head>
            \(generateCSS())
            <div id="NuPlay_RichText">\(html)</div>
            </BODY>
            <script>
                function syncHeight() {
                  window.webkit.messageHandlers.notifyCompletion.postMessage(
                    document.getElementById('NuPlay_RichText').offsetHeight
                  );
                }
                window.onload = function () {
                  syncHeight();
            
                  var imgs = document.getElementsByTagName('img');
                  for (var i = 0; i < imgs.length; i++) {
                    imgs[i].onload = syncHeight;
                  }
                };
            </script>
            </HTML>
            """
    }
    
    func generateCSS() -> String {
        switch conf.colorScheme {
        case .light:
            return """
            <style type='text/css'>
                \(conf.css(isLight: true,isTransparent: false, alignment: alignment))
                \(conf.customCSS)
                body {
                    margin: 0;
                    padding: 0;
                }
            </style>
            <BODY>
            """
        case .dark:
            return """
            <style type='text/css'>
                \(conf.css(isLight: false,isTransparent: false, alignment: alignment))
                \(conf.customCSS)
                body {
                    margin: 0;
                    padding: 0;
                }
            </style>
            <BODY>
            """
        case .tran:
            return """
            <style type='text/css'>
                \(conf.css(isLight: false,isTransparent: true, alignment: alignment))
                \(conf.customCSS)
                body {
                    margin: 0;
                    padding: 0;
                }
            </style>
            <BODY>
            """
        case .auto:
            return """
            <style type='text/css'>
            @media (prefers-color-scheme: light) {
                \(conf.css(isLight: true,isTransparent: false, alignment: alignment))
            }
            @media (prefers-color-scheme: dark) {
                \(conf.css(isLight: false,isTransparent: false, alignment: alignment))
            }
            \(conf.customCSS)
            body {
                margin: 0;
                padding: 0;
            }
            </style>
            <BODY>
            """
        }
    }
}
