//
//  Util.swift
//  iosTestApp1
//
//  Created by PNX on 2022/02/26.
//
import UIKit
import SVProgressHUD

class Util {
    static let shard = Util()
    
    func delayAction ( dDelay : Double, complete : @escaping () -> () ) {
        let dDelay = dDelay * Double(NSEC_PER_SEC)
        let time = DispatchTime.now() + Double(Int64(dDelay)) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: time) {
            complete()
        }
    }
    /// 프로그레시브 뷰 ON
    /// - Parameter strTitle: 프로그레시브 타이틀
    func showProgress(strTitle: String? = nil) {
        if let strTitle = strTitle {
            SVProgressHUD.setDefaultStyle(.light)
            SVProgressHUD.setBackgroundLayerColor(.white)
            SVProgressHUD.setBackgroundColor(.white)
            SVProgressHUD.setDefaultMaskType(.clear)
            SVProgressHUD.show(withStatus: strTitle)
        } else {
            SVProgressHUD.setDefaultStyle(.light)
            SVProgressHUD.setBackgroundLayerColor(.white)
            SVProgressHUD.setBackgroundColor(.white)
            SVProgressHUD.setDefaultMaskType(.clear)
            SVProgressHUD.show()
        }
    }
    
    /// 프로그레시브 뷰 OFF
    func dismissProgress() {
        SVProgressHUD.dismiss()
    }
    
}
