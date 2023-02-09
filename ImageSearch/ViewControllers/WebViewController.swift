//
//  WebViewController.swift
//  ImageSearch
//
//  Created by Алексей on 06.02.2023.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    //MARK: - @IBOutlets
    @IBOutlet var imageWebView: WKWebView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    //MARK: - Pablic properties
    var link = URL(string: "")
    
    //MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageWebView.navigationDelegate = self
        guard let link = link else { return }
        let urlRequrst = URLRequest(url: link)
        imageWebView.load(urlRequrst)
        
        
        
    }
}

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
    }
}

