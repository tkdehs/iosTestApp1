//
//  HeroHeaderUIView.swift
//  iosTestApp1
//
//  Created by PNX on 2022/03/04.
//

import UIKit
import SnapKit

class HeroHeaderUIView: UIView {

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
    
    private func addGradiant(){
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        heroImageView.frame = bounds
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
