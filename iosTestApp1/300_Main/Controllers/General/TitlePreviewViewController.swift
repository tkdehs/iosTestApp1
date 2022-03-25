//
//  TitlePreviewViewController.swift
//  iosTestApp1
//
//  Created by sangdon kim on 2022/03/10.
//

import UIKit
import WebKit
import SnapKit

class TitlePreviewViewController: UIViewController {
    
    private var titleData: Title?
    
    private let webView: WKWebView = {
        let webView = WKWebView()
        return webView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.text = "Harry potter"
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.text = "This is the best movie"
        label.numberOfLines = 0
        return label
    }()
    
    private let downlaodButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("Download", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius =      15
        button.layer.masksToBounds = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(webView)
        view.addSubview(titleLabel)
        view.addSubview(overviewLabel)
        view.addSubview(downlaodButton)

        configureConstraints()
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.topItem?.title = ""
        buttonEvent()
    }
    
    private func buttonEvent(){
        if let title = self.titleData {
            downlaodButton.addTarget {
                DataPersistenceManager.shared.downloadTitleWith(model: title) { result in
                    switch result {
                    case .success():
                        DLog("success download")
                    case .failure(let error):
                        DLog(error.localizedDescription)
                    }
                }
            }
        } else {
            downlaodButton.isHidden = true
        }
    }
    
    func configureConstraints(){
        webView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(250)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(webView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview()
        }
        
        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview()
        }
        downlaodButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(overviewLabel.snp.bottom).offset(25)
            make.width.equalTo(140)
            make.height.equalTo(40)
        }
    }

    func configure(with model: TitlePreviewViewModel) {
        titleLabel.text = model.title
        titleData = model.titleOrgData
        overviewLabel.text = model.titleOverview
        
        guard let url = URL(string: "https://www.youtube.com/embed/\(model.youtuveView.id.videoId)") else {
            return
        }
        
        webView.load(URLRequest(url: url))
    }
}
