//
//  ViewController.swift
//  BioMetric
//
//  Created by Aakash Gupta on 20/02/21.
//

import UIKit
import LocalAuthentication
class ViewController: UIViewController {

    var context = LAContext()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        context.localizedCancelTitle = "Cancel it"
        context.localizedFallbackTitle = "Use Password"
        context.localizedReason = "User Biometric for Authentication"
        context.touchIDAuthenticationAllowableReuseDuration =  LATouchIDAuthenticationMaximumAllowableReuseDuration
        evaluatePolicy()
    }
    
    func evaluatePolicy(){
        var evaluateError:NSError?
        if  context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error:&evaluateError){
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "User Biometric for Authentication") { (success, error) in
                print(success)
                 
                if let err = error {
                    let errorCode =  LAError.init(_nsError: err as NSError)
                    switch errorCode.code {
                    case .userCancel:
                        print("User cancelled")
                    case .userFallback:
                        print("userFallback- Display your custom screen to authenticate using yourself")
                    case .authenticationFailed:
                        print("authenticationFailed")
                    default:
                        print("unkown error")
                    }
                }
            }
        }
        else{
                print(evaluateError?.localizedDescription ?? "no error description")
            if let err = evaluateError {
                let errorCode =  LAError.init(_nsError: err as NSError)
                switch errorCode.code {
                case .biometryNotEnrolled:
                    print("biometryNotEnrolled")
                case .biometryNotAvailable:
                    print("biometryNotAvailable")
                case .appCancel:
                    print("appCancel")
                default:
                    print("unkown error")
                }
            }
        }
        
    }


}

