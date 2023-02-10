//
//  WebViewController.swift
//  ImageSearch
//
//  Created by Алексей on 06.02.2023.
//

import UIKit
import WebKit

final class WebViewController: UIViewController {
    
    //MARK: - @IBOutlets
    @IBOutlet private var imageWebView: WKWebView!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    
    //MARK: - Pablic properties
    var link = URL(string: "")
    
    //MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadWebView()
    }
    
    //MARK: - Private methods
    private func loadWebView() {
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        imageWebView.navigationDelegate = self
        guard let link = link else { return }
        let urlRequrst = URLRequest(url: link)
        DispatchQueue.main.async {
            self.imageWebView.load(urlRequrst)
        }
        
    }
}

//MARK: - WKNavigationDelegate
extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
    }
}

