//
//  HeroHeaderUIView.swift
//  iosTestApp1
//
//  Created by PNX on 2022/03/04.
//

import UIKit
import SnapKit

protocol HeroHeaderUIViewDelegate: AnyObject {
    func heroHeaderUIViewPlayTarget(model:TitlePreviewViewModel)
}

class HeroHeaderUIView: UIView {

    private var titleData: Title?
    
    public var delegate: HeroHeaderUIViewDelegate?
    
    private let downloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("Download", for: .normal)
        button.titleLabel?.textColor = UIColor.white
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        
        return button
    }()
    
    private let playButton: UIButton = {
       let button = UIButton()
        button.setTitle("Play", for: .normal)
        button.titleLabel?.textColor = UIColor.white
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        
        return button
    }()
    
    private let heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "heroImage")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(heroImageView)
        addGradiant()
        addSubview(playButton)
        addSubview(downloadButton)
        applyConstraints()
        buttonEvent()
    }
    
    private func applyConstraints(){
        playButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(90)
            make.bottom.equalToSuperview().offset(-50)
            make.width.equalTo(100)
        }
        
        downloadButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-90)
            make.bottom.equalToSuperview().offset(-50)
            make.width.equalTo(100)
        }
    }
    
    private func buttonEvent(){
        playButton.addTarget { [weak self] in
            guard let title = self?.titleData , let titleName = title.original_title ?? title.original_name else {return}
            APICaller.shared.getMovie(with: titleName) { [weak self] result in
                switch result {
                case .success(let videoElement):
                    let veiwModel = TitlePreviewViewModel(titleOrgData:title, title: titleName, youtuveView: videoElement, titleOverview: title.overview ?? "")
                    self?.delegate?.heroHeaderUIViewPlayTarget(model: veiwModel)
                case .failure(let error):
                    DLog(error.localizedDescription)
                }
            }
        }
        
        downloadButton.addTarget { [weak self] in
            guard let title = self?.titleData else {
                return
            }
            DataPersistenceManager.shared.downloadTitleWith(model: title) { result in
                switch result {
                case .success():
                    DLog("success download")
                case .failure(let error):
                    DLog(error.localizedDescription)
                }
            }
        }
    }
    
    private func addGradiant(){
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }
    
    public func configure(with model:Title) {
        titleData = model
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.poster_path ?? "")") else {
            return
        }
        heroImageView.sd_setImage(with: url, completed: nil)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        heroImageView.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
