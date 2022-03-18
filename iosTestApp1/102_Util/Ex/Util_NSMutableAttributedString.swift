//
//  Util_ NSMutableAttributedString.swift
//  CodeAble
//
//  Created by Ahngunism on 2022/01/17.
//  Copyright © 2022 OKPOS. All rights reserved.
//

import UIKit

extension NSMutableAttributedString {
    
    /// 일반 텍스트 추가
    /// - Parameters:
    ///   - strOri: 원문 텍스트
    ///   - size: 사이즈
    ///   - color: 컬러
    func appendNormalText(_ strOri: String, size: CGFloat = 14, color: UIColor? = nil) {
        var attributes:[NSAttributedString.Key : Any] = [ .font : FONT_APPLE_SD_GOTHIC_REGULAR(size) ]
        if let color = color { attributes[.foregroundColor] = color }
        self.append(NSAttributedString(string: strOri, attributes:attributes))
    }
    
    /// 볼드 텍스트 추가
    /// - Parameters:
    ///   - strOri: 원문 텍스트
    ///   - size: 사이즈
    ///   - color: 컬러
    func appendBoldText(_ strOri: String, size: CGFloat = 14, color: UIColor? = nil) {
        var attributes:[NSAttributedString.Key : Any] = [ .font : FONT_APPLE_SD_GOTHIC_BOLD(size) ]
        if let color = color { attributes[.foregroundColor] = color }
        self.append(NSAttributedString(string: strOri, attributes:attributes))
    }
    
    /// 하이라이트 텍스트 추가
    /// - Parameters:
    ///   - strOri: 원문 텍스트
    ///   - size: 사이즈
    func appendHighlightedText(_ strOri: String, size: CGFloat = 14) {
        let attributes:[NSAttributedString.Key : Any] = [
            .font : UIFont.systemFont(ofSize: size),
            .foregroundColor : UIColor.white,
            .backgroundColor : UIColor.orange
        ]
        
        self.append(NSAttributedString(string: strOri, attributes:attributes))
    }
    
    /// 밑줄 텍스트 추가
    /// - Parameters:
    ///   - strOri: 원문 텍스트
    ///   - size: 사이즈
    func appendUnderlinedText(_ strOri: String, size: CGFloat = 14) {
        let attributes:[NSAttributedString.Key : Any] = [
            .font :  UIFont.systemFont(ofSize: size),
            .underlineStyle : NSUnderlineStyle.single.rawValue
        ]
        
        self.append(NSAttributedString(string: strOri, attributes:attributes))
    }
    
}
