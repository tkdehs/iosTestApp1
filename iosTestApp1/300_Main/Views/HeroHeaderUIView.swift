//
//  HeroHeaderUIView.swift
//  iosTestApp1
//
//  Created by PNX on 2022/03/04.
//

import UIKit

class HeroHeaderUIView: UIView {

    private let heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "heroImage")
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(heroImageView)
        addGradiant()
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
