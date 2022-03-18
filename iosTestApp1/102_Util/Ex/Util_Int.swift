//
//  Util_Int.swift
//  CodeAble
//
//  Created by Ahngunism on 2022/01/17.
//  Copyright © 2022 OKPOS. All rights reserved.
//

import UIKit

extension Int {
    
    /// 홀수 여부
    var isOdd: Bool { get {
        if self % 2 == 0    { return false }
        else                { return true }
    } }
    
    /// Convert to Bool
    /// - Returns: Bool Value
    func convertBool() -> Bool {
        if self == 1 { return true }
        else         { return false }
    }
    
    /// 가격에 세자리마다 comma(,) 추가
    var strAddComma : String { get {
            let numPrice : NSNumber = NSNumber.init(value: self)
            let strPrice : NSString = NumberFormatter.localizedString(from: numPrice, number: NumberFormatter.Style.decimal) as NSString
            return strPrice as String
        } }
}
