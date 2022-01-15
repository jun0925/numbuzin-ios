//
//  ViewController.swift
//  numbuzin
//
//  Created by jun0925 on 2022/01/15.
//

import UIKit
import Foundation
import WebKit

class ViewController: UIViewController {
    
    @IBOutlet weak var contentsView: UIView!
    
    // 웹뷰
    var webView: WKWebView!

    @IBOutlet weak var mIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let url = "https://m.numbuzin.com/"
        let request = URLRequest(url:URL(string:url)!)
        webView = WKWebView(frame: CGRect(x:contentsView.frame.origin.x, y:0, width:contentsView.frame.size.width, height:contentsView.frame.size.height))
        webView.navigationDelegate = self
        webView.uiDelegate = self
        webView.scrollView.bounces = false
        webView.load(request)
        contentsView.addSubview(webView)
        contentsView.sendSubviewToBack(webView)

        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.leadingAnchor.constraint(equalTo: contentsView.leadingAnchor, constant: 0).isActive = true
        webView.trailingAnchor.constraint(equalTo: contentsView.trailingAnchor, constant: 0).isActive = true
        webView.topAnchor.constraint(equalTo: contentsView.topAnchor, constant: 0).isActive = true
        webView.bottomAnchor.constraint(equalTo: contentsView.bottomAnchor, constant: 0).isActive = true

        self.mIndicator.hidesWhenStopped = true
    }
}


extension ViewController: WKUIDelegate, WKNavigationDelegate {

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.mIndicator.startAnimating()
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.mIndicator.stopAnimating()
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.mIndicator.stopAnimating()
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
    }

    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {

        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "확인", style: .cancel) { _ in
            completionHandler()
        }
        alertController.addAction(cancelAction)
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }

    }

    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {

        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { _ in
            completionHandler(false)
        }
        let okAction = UIAlertAction(title: "확인", style: .default) { _ in
            completionHandler(true)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
