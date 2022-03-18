//
//  SplashViewController.swift
//  iosTestApp1
//
//  Created by PNX on 2022/02/26.
//

import UIKit

class SplashViewController: BaseViewController {
    
    /////////////////////////
    /// 트래킹용 스크린 네임 세팅
    override var strScreenName : String? { get { return "스플래시"} set(strNew) { super.strScreenName = strNew } }
    static var strScreenName : String? = "스플래스"
    /////////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initView()
        self.initData()
        var test = "testet"
    }
    
    //============================================================
    // MARK: - View Setting
    //============================================================
    
    /// 뷰 초기 세팅
    func initView() {
        
    }
    
    //============================================================
    // MARK: - Data Setting
    //============================================================
    
    /// 데이터 초기 세팅
    func initData() {
        
    }
    
    //============================================================
    // MARK: - Button Action
    //============================================================
    
}
