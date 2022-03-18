//
//  Util_UITableViewCell.swift
//  CodeAble
//
//  Created by Ahngunism on 2022/01/17.
//  Copyright © 2022 OKPOS. All rights reserved.
//

import UIKit

extension UITableViewCell {
	override open func awakeFromNib() {
		super.awakeFromNib()
		/// 셀렉션 제거
		selectionStyle = .none
	}
}

