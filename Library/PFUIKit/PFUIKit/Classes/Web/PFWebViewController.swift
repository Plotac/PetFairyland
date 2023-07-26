//
//  PFWebViewController.swift
//  PFUIKit
//
//  Created by Ja on 2023/7/26.
//

import UIKit
import WebKit
import SnapKit

public class PFWebViewController: UIViewController {

    public var urlStr: String = "" {
        didSet {
            if !urlStr.isEmpty {
                load(url: urlStr)
            }
        }
    }
    
    private var progressObserver: NSKeyValueObservation?
    
    public lazy var webView: WKWebView = {
        return WKWebView()
    }()
    
    public lazy var progressView: UIProgressView = {
        return UIProgressView()
    }()
    
    public required init(urlStr: String) {
        super.init(nibName: nil, bundle: nil)
        self.urlStr = urlStr
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        progressObserver = nil
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        progressObserver = webView.observe(\WKWebView.estimatedProgress, options: [.new]) { [weak self] _, change in
            if let newProgress = change.newValue {
                self?.progressView.isHidden = newProgress == 1
                self?.progressView.setProgress(Float(newProgress == 1 ? 0 : newProgress), animated: !(newProgress == 1))
            }
        }
        load(url: urlStr)
    }
    
    public func load(url: String) {
        webView.load(URLRequest(url:URL(string: urlStr)!))
    }

}


extension PFWebViewController {
    func setupUI() {
        view.backgroundColor = .white
        navigationItem.title = title
        
        view.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(progressView)
        progressView.snp.makeConstraints { make in
            make.top.equalTo(webView)
            make.left.right.equalToSuperview()
            make.height.equalTo(2)
        }
    }
}
