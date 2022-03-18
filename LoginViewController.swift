//
//  LoginViewController.swift
//  iosTestApp1
//
//  Created by sangdon kim on 2022/03/02.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: BaseViewController {
    
    /////////////////////////
    /// 트래킹용 스크린 네임 세팅
    override var strScreenName : String? { get { return "로그인"} set(strNew) { super.strScreenName = strNew } }
    static var strScreenName : String? = "로그인"
    /////////////////////////
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPw: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initView()
        self.initData()
    }
    
    //============================================================
    // MARK: - View Setting
    //============================================================
    
    /// 뷰 초기 세팅
    func initView() {
        tfEmail.text = "test@naver.com"
        tfPw.text = "123456"
    }
    
    //============================================================
    // MARK: - Data Setting
    //============================================================
    
    /// 데이터 초기 세팅
    func initData() {
        if let user = Auth.auth().currentUser {
            
        }
    }
    
    //============================================================
    // MARK: - Button Action
    //============================================================
    
    /// login
    /// - Parameter sender: 버튼 컨트롤
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        DLog("[USER_ACTION] login")
        if let email = self.tfEmail.text, let pw = self.tfPw.text {
            DLog("로그인 유효성 검사 성공")
            Auth.auth().signIn(withEmail: email, password: pw) { user, error in

                if user != nil {
                   let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    /*
                     self.window = UIWindow(frame: UIScreen.main.bounds)
                     self.tcMain = MainTabBarController()
                     self.ncMain = UINavigationController.init(rootViewController: self.tcMain)
                     self.ncMain?.isNavigationBarHidden = true
                     self.window?.rootViewController = self.ncMain
                     self.window?.makeKeyAndVisible()
                     */
                    let ncMain = UINavigationController.init(rootViewController: MainViewController())
                    ncMain.isNavigationBarHidden = true
                    appDelegate.window?.rootViewController = ncMain
                    appDelegate.window?.makeKeyAndVisible()
                    
                    let option: UIView.AnimationOptions = .curveEaseIn
                    let duration: TimeInterval = 0.3
                    
                    if let window = appDelegate.window {
                        UIView.transition(with: window, duration: duration, options: option) {
                            
                        } completion: { bool in
                            
                        }
                    }

                    
//                    let vc = MainViewController()
//                    self.navigationController?.pushViewController(vc, animated: true)
                } else {
                    if let msg = error?.localizedDescription {
                        let alert = UIAlertController(title: "오류", message: msg, preferredStyle: .alert)
                        alert.addAction(UIAlertAction.init(title: "확인", style: .destructive, handler: { action in
                            
                        }))
                        
                        self.present(alert, animated: false, completion: nil)
                    }
                }
            }
        }
    }
}
