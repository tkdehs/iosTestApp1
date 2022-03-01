//
//  Util_UILabel.swift
//  CodeAble
//
//  Created by Ahngunism on 2022/01/17.
//  Copyright © 2022 OKPOS. All rights reserved.
//

import UIKit

extension UILabel {
    
    convenience init(frame: CGRect, text strString : String?, font fText : UIFont? = nil, color coText : UIColor? = nil, alignment aText : NSTextAlignment? = nil, nLineCount : Int = 0 ) {
        self.init(frame:frame)
        self.setLabel( text: strString, font: fText, color: coText, alignment: aText, nLineCount: nLineCount)
    }
    
	/// 텍스트에 따른 라벨
	func getLabelHeightFromText ( cfConstraintedWidth : CGFloat? = nil ) -> CGFloat{
		guard let strText = self.text else { return 0 }
		
        var cfWidth: CGFloat = self.width
		
		if let cfConstraintedWidth = cfConstraintedWidth {
			cfWidth = cfConstraintedWidth
		}
		
		return strText.height(constraintedWidth: cfWidth, font: self.font, lineBreakMode: self.lineBreakMode, nLineCount: self.numberOfLines )
	}
	
	/// 텍스트/폰트/얼라인/컬러 세팅
	func setLabel ( text strString : String?, font fText : UIFont? = nil, color coText : UIColor? = nil, alignment aText : NSTextAlignment? = nil, nLineCount : Int = 0 ) {
		if let strString = strString {
			self.text = strString
			if let fText = fText {
				self.font = fText
			}
			if let coText = coText {
				self.textColor = coText
			}
            if let aText = aText {
                self.textAlignment = aText
            }
			self.numberOfLines = nLineCount
		} else {
			self.text = ""
		}
	}
    
    /// 텍스트/폰트/얼라인/컬러 세팅
    func setPriceLabel ( strPrice : String? = "0", fontPrice: UIFont? = nil, colorPrice: UIColor? = nil,
                         strUnit: String? = "원", fontUnit : UIFont? = nil, colorUnit: UIColor? = nil,
                         alignment: NSTextAlignment? = nil, nLineCount : Int = 0 ) {
        let astrResult: NSMutableAttributedString = NSMutableAttributedString.init()
        
        if let strPrice = strPrice {
            var priceAttribute: [NSAttributedString.Key : Any] = [:]
            if let fontPrice = fontPrice {
                priceAttribute[.font] = fontPrice
            }
            
            if let colorPrice = colorPrice {
                priceAttribute[.foregroundColor] = colorPrice
            }
            
            astrResult.append(NSAttributedString(string: strPrice, attributes: priceAttribute))
        }
        
        
        if let strUnit = strUnit {
            var unitAttribute: [NSAttributedString.Key : Any] = [:]
            if let fontUnit = fontUnit {
                unitAttribute[.font] = fontUnit
            }
            
            if let colorUnit = colorUnit {
                unitAttribute[.foregroundColor] = colorUnit
            }
            
            astrResult.append(NSAttributedString(string: strUnit, attributes: unitAttribute))
        }
        
        if let alignment = alignment {
            self.textAlignment = alignment
        }
        self.numberOfLines = nLineCount
        
        self.attributedText = astrResult
    }
    
    /// 텍스트 Append
    func appendText( strText: String? ) {
        if let strText = strText, let strSelf = self.text {
            self.text = "\(strSelf)\(strText)"
        }
    }
    
    /// Size To Fit : Width 고정
    ///
    /// - Parameter cfWidth: Width
    func sizeToFitWithFixWidth( cfWidthTarget : CGFloat? = nil ) {
        var cfWidth : CGFloat = self.width
        if let cfWidthTarget = cfWidthTarget {
            cfWidth = cfWidthTarget
        }
        self.setWidth(value: cfWidth)
        self.setHeight(value: self.getLabelHeightFromText(cfConstraintedWidth: cfWidth))
    }
    
    /// Size To Fit : Height 고정
    ///
    /// - Parameter cfHeight: Height
    func sizeToFitWithFixHeight( cfHeightTarget : CGFloat? = nil ) {
        var cfHeight : CGFloat = self.height
        if let cfHeightTarget = cfHeightTarget {
            cfHeight = cfHeightTarget
        }
        
        self.sizeToFit()
        self.setHeight(value: cfHeight)
    }
    
    /// 텍스트 클리어
    func clear() {
        self.text = ""
    }
    
    /// 넘버 폰트 세팅
    func setNumberFontize() {
        guard let strText = self.text else { return }
        let currentFont: UIFont = self.font
        let astrText: NSMutableAttributedString = NSMutableAttributedString.init()
        
        for char in strText {
            if ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"].contains(char) == true {
                let astrChar: NSMutableAttributedString = NSMutableAttributedString.init(string: String(char))
                if currentFont.fontName.contains("Bold") {
                    astrChar.addAttribute(NSAttributedString.Key.font, value: FONT_ROBOTO_KR_BOLD(currentFont.pointSize), range: NSRange.init(location: 0, length: 1))
                } else if currentFont.fontName.contains("Medium") {
                    astrChar.addAttribute(NSAttributedString.Key.font, value: FONT_ROBOTO_KR_MEDIUM(currentFont.pointSize), range: NSRange.init(location: 0, length: 1))
                } else {
                    astrChar.addAttribute(NSAttributedString.Key.font, value: FONT_ROBOTO_KR_REGULAR(currentFont.pointSize), range: NSRange.init(location: 0, length: 1))
                }
                
                astrText.append(NSAttributedString.init(attributedString: astrChar))
                
            } else {
                astrText.append(NSAttributedString.init(string: String(char)))
            }
        }
        
        self.attributedText = astrText
    }
    
    /// 클릭 이벤트 설정
    /// - Parameter callback: 콜백
    func setClickListener(callback:@escaping (UILabel)->Void){
        let gesture = LabelTapGesture(target: self, action: #selector(clickEvent(gesture:)))
        gesture.callback = callback
        self.addGestureRecognizer(gesture)
        self.isUserInteractionEnabled = true
    }
    
    @objc func clickEvent(gesture: LabelTapGesture){
        if let listener = gesture.callback {
            listener(self)
        }
    }
    
    class LabelTapGesture : UITapGestureRecognizer{
        var callback:((UILabel)->Void)? = nil
        
        override init(target: Any?, action: Selector?) {
            super.init(target: target, action: action)
        }
    }
    ///클릭 이벤트 설정 끝
}

