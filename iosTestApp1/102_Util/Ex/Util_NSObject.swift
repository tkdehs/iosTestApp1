//
//  Util_NSObject.swift
//  CodeAble
//
//  Created by Ahngunism on 2022/01/17.
//  Copyright © 2022 OKPOS. All rights reserved.
//

import UIKit

extension NSObject {
    /// 클래스명
    var className : String { get { return String(describing: type(of: self)) } }
}
