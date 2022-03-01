//
//  BaseViewViewController.swift
//  iosTestApp1
//
//  Created by PNX on 2022/02/26.
//

import UIKit

class BaseViewController: UIViewController, UINavigationControllerDelegate, UIGestureRecognizerDelegate, UITextFieldDelegate {
    /// 스크린 네임
    var strScreenName : String?

    /// 메인 스크롤뷰
    var mainScrollView: UIScrollView?
    
    /// 스크롤뷰 Bottom
    var conScrollViewBottom : NSLayoutConstraint?
    var cfScrollViewBottomOrigin : CGFloat?
    
    /// 액티브 텍스트 필드
    var tfActive: UITextField?
    
    /// 상단 Sage Area Height
    var topSafeAreaHeight: CGFloat = 0
    /// 하단 Sage Area Height
    var bottomSafeAreaHeight: CGFloat = 0
    
    /// 리플래시 필요 여부
    var isNeedRefresh: Bool = false
    
    /// 로딩중 여부
    var isLoading: Bool = false
    
    /// 데이터 종료 여부
    var isFinish: Bool = false
    
    /// 슈퍼 뷰 컨트롤러
    var vcSuper: BaseViewController?
    
    /// 베이스 테이블뷰
    var tvBase: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hidesBottomBarWhenPushed = true
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.hidesBottomBarWhenPushed = true
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.isToolbarHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        /// Light 모드 고정
        if #available(iOS 13.0, *) { overrideUserInterfaceStyle = .light }
        
        /// Safe Area 세팅
//        if #available(iOS 11.0, *) {
//            let window = UIApplication.shared.windows[0]
//            let safeFrame = window.safeAreaLayoutGuide.layoutFrame
//            self.topSafeAreaHeight = safeFrame.minY
//            self.bottomSafeAreaHeight = window.frame.maxY - safeFrame.maxY
//        }
//
        /// 키보드 OFF 액션
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let strScreenName = self.strScreenName {
            ILog("[VIEW_WILL_APPEAR] \(strScreenName)")
        }
        
        /// 키보드 노티피케이션 등록
        self.addKeyboardNotification(conScrollViewBottom: self.conScrollViewBottom)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidLoad()
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) {
            return .darkContent
        } else {
            return .default
        }
    }
    
    func refreshViewController() {
        
    }

    //============================================================
    // MARK: - Button Action
    //============================================================
    
    /// 백버튼 클릭시
    ///
    /// - Parameter sender: 버튼 컨트롤
    @IBAction func baseBackButtonPressed (_ sender : UIButton) {
        /// 네비 POP
        self.navigationController?.popViewController(animated: true)
    }
    
    func vibrate() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    
    //============================================================
    // MARK: - Keyboard Action
    //============================================================
    
    /// 키보드 노티피케이션 등록
    ///
    /// - Parameter conScrollViewBottom: 스크롤뷰 Bottom
    func addKeyboardNotification ( conScrollViewBottom : NSLayoutConstraint? ) {
        if let conScrollViewBottom = conScrollViewBottom {
            self.conScrollViewBottom = conScrollViewBottom
            if self.cfScrollViewBottomOrigin == nil {
                self.cfScrollViewBottomOrigin = conScrollViewBottom.constant
            }
            
            NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShowAction(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHideAction(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        }
    }
    
    /// 키보드 Show Action
    /// - Parameter noti: 키보드 Show Notification
    @objc func keyboardWillShowAction(_ noti: Notification) {
        let userInfo: NSDictionary? = noti.userInfo as NSDictionary?
        let keyboardSize: CGSize? = (userInfo?.object(forKey: UIResponder.keyboardFrameEndUserInfoKey) as AnyObject).cgRectValue.size
        let animationDuration: Double? = (userInfo?.object(forKey: UIResponder.keyboardAnimationDurationUserInfoKey) as AnyObject).doubleValue
        
        if let keyboardSize = keyboardSize, let animationDuration = animationDuration {
            UIView.animate(withDuration: animationDuration, animations: { () -> Void in
                self.conScrollViewBottom?.constant = keyboardSize.height - self.bottomSafeAreaHeight
                
                self.view.layoutIfNeeded()
            })
        }
        
    }
    
    /// 키보드 Hide Action
    /// - Parameter noti: 키보드 Hide Notification
    @objc func keyboardWillHideAction(_ noti: Notification) {
        let userInfo: NSDictionary? = noti.userInfo as NSDictionary?
        let animationDuration: Double? = (userInfo?.object(forKey: UIResponder.keyboardAnimationDurationUserInfoKey) as AnyObject).doubleValue
        if let animationDuration = animationDuration, let cfScrollViewBottomOrigin = self.cfScrollViewBottomOrigin {
            UIView.animate(withDuration: animationDuration, animations: { () -> Void in
                self.conScrollViewBottom?.constant = cfScrollViewBottomOrigin
                self.view.layoutIfNeeded()
            })
            
        } else {
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                self.conScrollViewBottom?.constant = 0
                self.view.layoutIfNeeded()
            })
        }
    }
    
    //============================================================
    // MARK: - UINavigationControllerDelegate
    //============================================================
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if let arrVC = self.navigationController?.viewControllers, arrVC.count > 1 {
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        } else {
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        }
    }
    
    //============================================================
    // MARK: - UITextFieldDelegate
    //============================================================
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.tfActive = textField
        self.tfActive?.addKeyboardCompleteButton()
        return true
    }
    
}
