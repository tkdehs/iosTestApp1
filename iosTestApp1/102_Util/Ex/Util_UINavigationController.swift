//
//  Util_UINavigationController.swift
//  CodeAble
//
//  Created by Ahngunism on 2022/01/17.
//  Copyright © 2022 OKPOS. All rights reserved.
//

import UIKit
import SafariServices

extension UINavigationController: SFSafariViewControllerDelegate {
    
    /// 타켓 뷰컨트롤러 클래스로 Pop
    ///
    /// - Parameter vcTargetClass: 타켓 뷰컨트롤러 클래스
    func popTargetViewController( vcTargetClass : AnyClass? = nil, arrTargetClass : [AnyClass]? = nil, isRequied: Bool = true, isRoot: Bool = false, animated: Bool = true ) {
        if let arrTargetClass = arrTargetClass {
            for targetClass in arrTargetClass {
                for vcSub in self.viewControllers {
                    if vcSub.isKind(of: targetClass) == true {
                        self.popToViewController(vcSub, animated: animated)
                        return
                    }
                }
            }
        } else if let vcTargetClass = vcTargetClass {
            for vcSub in self.viewControllers {
                if vcSub.isKind(of: vcTargetClass) == true {
                    self.popToViewController(vcSub, animated: animated)
                    return
                }
            }
        }
        
        if isRequied == true {
            if isRoot == true {
                self.popToRootViewController(animated: animated)
            } else {
                self.popViewController(animated: animated)
            }
        }
    }
    
    /// Pop 후 즉시 Push
    /// - Parameter vcPush: Push ViewController
    func popAndPushViewController(vcPush: UIViewController) {
        self.popViewController(animated: true)
        Util.shard.delayAction(dDelay: 0.25, complete: {
            self.pushViewController(vcPush, animated: true)
        })
    }
    
    
    /// PopTo 후 즉시 Push
    /// - Parameters:
    ///   - vcPop: pop할 뷰컨트롤러
    ///   - vcPush: push할 뷰 컨트롤러
    func popAndPushViewController(vcPop:UIViewController,vcPush: UIViewController) {
        self.popToViewController(vcPop, animated: true)
        Util.shard.delayAction(dDelay: 0.25, complete: {
            self.pushViewController(vcPush, animated: true)
        })
    }
    
    /// Pop 후 즉시 Present Modal
    /// - Parameter vcPresent: Modal ViewController
    func popAndPresentViewController(vcPresent: UIViewController) {
        self.popViewController(animated: true)
        Util.shard.delayAction(dDelay: 0.25, complete: {
            UIApplication.getTopViewController()?.present(vcPresent, animated: true, completion: {})
        })
    }
    
    //============================================================
    // MARK: - SFSafariViewControllerDelegate
    //============================================================
    
    public func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        DLog("Safari ViewController Did Finish")
    }
}
