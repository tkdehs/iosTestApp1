//
//  Util_CGFloat.swift
//  CodeAble
//
//  Created by Ahngunism on 2022/01/17.
//  Copyright © 2022 OKPOS. All rights reserved.
//

import UIKit

extension CGFloat {
    
    /// 값 증가
    /// - Parameter cfValue: 증가값
    mutating func append( _ cfValue : CGFloat ) {
        self = self + cfValue
    }
    
    /// 값 증가
    /// - Parameter cfValue: 증가값
    mutating func append( _ arrValue : CGFloat... ) {
        for value in arrValue {
            self = self + value
        }
    }
}
