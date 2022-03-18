//
//  Util_UITextView.swift
//  CodeAble
//
//  Created by Ahngunism on 2022/01/17.
//  Copyright © 2022 OKPOS. All rights reserved.
//

import UIKit

extension UITextView {
    var visibleRange: NSRange {
        if let start = closestPosition(to: contentOffset), let end = characterRange(at: CGPoint(x: contentOffset.x + bounds.origin.x, y: contentOffset.y + bounds.maxY))?.end {
            return NSMakeRange(offset(from: beginningOfDocument, to: start), offset(from: start, to: end))
        }
        return NSRange(location: 0, length: 0)
    }
    
    /// 텍스트 값 유무 여부
    var isExistText : Bool { get {
        if let strText = self.text, strText.length > 0 { return true }
        else { return false }
        } }
    
    /// 텍스트 값 Empty 여부
    var isEmptyText : Bool { get { return self.isExistText.reverse } }
    
    /// 텍스트 길이
    var nLength : Int { get {
        if let strText = self.text { return strText.length }
        else { return 0 }
        } }
    
    /// 키보드 완료 버튼 추가
    func addKeyboardCompleteButton (strTitle: String = "닫기") {
        let tbKeyboard = UIToolbar.init(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 42))
        let barFlexible = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: #selector(resignFirstResponder))
        let barBtnDone = UIBarButtonItem.init(title: strTitle, style: UIBarButtonItem.Style.plain, target: self, action: #selector(resignFirstResponder))
        tbKeyboard.items = [barFlexible,barBtnDone]
        self.inputAccessoryView = tbKeyboard
    }
    
}
