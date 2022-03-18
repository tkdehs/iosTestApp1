//
//  Util_Apple.swift
//  HowMuchToday
//
//  Created by sangdon kim on 2022/02/10.
//  Copyright © 2022 Ahngunism. All rights reserved.
//

import Foundation
import AuthenticationServices

class Util_Apple:NSObject{
    class func initAppleLoginButton(controller:BaseViewController, parentView:UIView) {
            /// 애플 로그인 버튼 생성
            if #available(iOS 13.0, *) {
                let btnAppleLogin: ASAuthorizationAppleIDButton = ASAuthorizationAppleIDButton.init(type: .signIn, style: .black)
                parentView.addSubview(btnAppleLogin)
                btnAppleLogin.snp.makeConstraints{ (make) in
                    make.edges.equalToSuperview()
                }
                btnAppleLogin.addTarget {
                    let appleIDProvider = ASAuthorizationAppleIDProvider()
                    let request = appleIDProvider.createRequest()
                    request.requestedScopes = [.fullName, .email]
                          
                    let authorizationController = ASAuthorizationController(authorizationRequests: [request])
                    authorizationController.delegate = controller
                    authorizationController.presentationContextProvider = controller
                    authorizationController.performRequests()
                }
            } else {parentView
                /// iOS 13.0 미만 버전 처리
                .isHidden = true
                
            }
    }
    
}
extension BaseViewController : ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {

    //============================================================
    // MARK: - ASAuthorizationControllerDelegate
    //============================================================
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        let sendObj = OBJ_JoinParam.init()
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            sendObj.strLoginId = appleIDCredential.user
            sendObj.strEmail = appleIDCredential.user
            sendObj.strPassword = appleIDCredential.user
            sendObj.strSnsToken = appleIDCredential.user

        } else if let passwordCredential = authorization.credential as? ASPasswordCredential {
            sendObj.strLoginId = passwordCredential.user
            sendObj.strEmail = passwordCredential.user
            sendObj.strPassword = passwordCredential.user
            sendObj.strSnsToken = passwordCredential.user

        }

        if let strAppleID = sendObj.strSnsToken, strAppleID.isExist == true {
            /// 성공시 sns 로그인 진행
            NetworkCenter.request(url: .login,
                                  params: ["username": sendObj.strLoginId,
                                           "password": sendObj.strPassword,
                                           "accountType": "apple"],
                                  isErrorPopup: false,
                                  success: { (resultData: CommonModel<OBJ_User>) in
                /// 로그인 정보가 있을경우 기존 로그인 정보로 로그인 진행
                if let objUser = resultData.data, let strToken = objUser.strToken {
                    /// 유저 OBJ 세팅
                    CommonData.shared.objUser = resultData.data
                    /// 유저 토큰 저장
                    CommonData.shared.strUserToekn = strToken
                    /// 초기 프로세스 실행
                    GET_APPDELEGATE().startMainProcess()
                } else {
                    Util.showHMTCommonPopup(strTitle: "",strContent: resultData.message)
                }
            }, fail: { (strCode, strMsg) in
                /// 로그인 정보가 없을경우 회원가입 진행
                let vc = TermAgreeViewController()
                vc.joinType = .apple
                vc.sendObj = sendObj
                self.navigationController?.pushViewController(vc, animated: true)
            })
        } else {
            Util.showToastMessage(msg: ERROR_TEXT_RETRY_AGAIN)
        }
    }

    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        DLog(error)
    }


    //============================================================
    // MARK: - ASAuthorizationControllerPresentationContextProviding
    //============================================================
    @available(iOS 13.0, *)
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        if let window = GET_APPDELEGATE().window {
            return window
        } else {
            return UIWindow()
        }
    }
}

