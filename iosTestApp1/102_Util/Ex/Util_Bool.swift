//
//  Util_Bool.swift
//  CodeAble
//
//  Created by Ahngunism on 2022/01/17.
//  Copyright © 2022 OKPOS. All rights reserved.
//

extension Bool {
	/// Bool 값의 반대값
	var reverse : Bool { get { return !self } }
    
    /// Bool 값의 반대값 세팅
    mutating func reversed() {
        self = self.reverse
    }
}
