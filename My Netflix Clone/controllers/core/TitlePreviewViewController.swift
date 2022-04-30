//
//  TitlePreviewViewController.swift
//  My Netflix Clone
//
//  Created by said fatah on 30/4/2022.
//

import UIKit
import WebKit

class TitlePreviewViewController: UIViewController {
    private let titleLabel:UILabel = {
        let label = UILabel()
        label.text = "Harry potter"
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    private let overviewLabel:UILabel = {
        let label = UILabel()
        label.text = "abra kdabra abra kdabra abra kdabra abra kdabra abra kdabra abra kdabra abra kdabra "
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    private let downloadButton:PrimaryUIButton = {
        let button = PrimaryUIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.setTitle("Download", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    private let webView:WKWebView = {
        let webview = WKWebView()
        
        webview.translatesAutoresizingMaskIntoConstraints = false
        
        return webview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        view.addSubview(titleLabel)
        view.addSubview(downloadButton)
        view.addSubview(overviewLabel)
        setupConstraints()
        
    }
    
    private func setupConstraints(){
        let webViewConstraints:[NSLayoutConstraint]  = [
            webView.topAnchor.constraint(equalTo: view.topAnchor,constant: 50),
            webView.heightAnchor.constraint(equalToConstant: 400),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        ]
        NSLayoutConstraint.activate(webViewConstraints)
 
        
        let titleLabelConstraints:[NSLayoutConstraint] = [
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor ,constant: 10),
            titleLabel.topAnchor.constraint(equalTo: webView.bottomAnchor,constant: 25),
            titleLabel.bottomAnchor.constraint(equalTo: downloadButton.topAnchor),
            titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor),
        ]
        NSLayoutConstraint.activate(titleLabelConstraints)
        
        let downloadButtonConstraints:[NSLayoutConstraint] = [
            downloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor ),
            downloadButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 15),
            downloadButton.bottomAnchor.constraint(equalTo: overviewLabel.topAnchor),
            downloadButton.widthAnchor.constraint(equalTo: view.widthAnchor),
            downloadButton.heightAnchor.constraint(equalToConstant: 50),
        ]
        NSLayoutConstraint.activate(downloadButtonConstraints)
        
     
        let overviewLabelConstraints:[NSLayoutConstraint]  = [
            overviewLabel.topAnchor.constraint(equalTo: downloadButton.bottomAnchor,constant: 15),
            overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10),
            overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10),
   
        ]
        NSLayoutConstraint.activate(overviewLabelConstraints)
        
    }
    
    public func configure(with model:TitlePreviewViewModel ){
        titleLabel.text = model.title
        overviewLabel.text = model.overview
        guard let url = URL(string: "https://www.youtube.com/embed/\(model.youtubeVideo.id.videoId)") else {return}
        webView.load(URLRequest(url: url))
    }
  
}


