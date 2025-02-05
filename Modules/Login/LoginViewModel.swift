//
//  LoginViewModel.swift
//  Movers
//
//  Created by Shakeel Ahmed on 09/01/2025.
//

import Combine
import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {
    
    @Published var textFieldEmail = "ahmed@gmail.com"
//    @Published var textFieldEmail = "maaz1@ali.com"
    @Published var textFieldPassword = "11111111"
//    @Published var textFieldEmail = ""
//    @Published var textFieldPassword = ""
    @Published var emailErrorMessage = ""
    @Published var passwordErrorMessage = ""
    @Published var isPasswordVisible: Bool = false
    @Published var navigateToSignUpView: Bool = false
    @Published var navigateToForgotPasswordView: Bool = false
    
    var isFormValid: Bool {
        return !textFieldEmail.isEmpty && !textFieldPassword.isEmpty && textFieldPassword.count > 7
    }
    
    var modelLoginResponse: LoginViewModel.ModelLoginResponse? {
        didSet {
            kUserData = modelLoginResponse?.user
            setRootViewController(HomeTabBarView())
        }
    }
    
    func validateEmail() {
        if !isValidEmail(textFieldEmail) && !textFieldEmail.isEmpty {
            emailErrorMessage = "Please enter a valid email address."
        } else {
            emailErrorMessage = "" // Clear the error message if valid
        }
    }

    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    
    func login() {
        let parameters = [
            "email": textFieldEmail,
            "password": textFieldPassword
        ] as! [String: Any]
        
        APIs.postAPI(apiName: .login, parameters: parameters) { responseData, success, errorMsg, statusCode  in
            if success { }
            
            do {
                let model: ApiResponse<LoginViewModel.ModelLoginResponse>? = try APIs.decodeDataToObject(data: responseData)
                if model?.status == 200 {
                    self.modelLoginResponse = model?.data
                }
                else {
                    showPopup(title: "Error!", message: model?.message ?? "", imageIcon: .errorIcon) {
                        
                    }
                }
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
            }
        }
    }
}

extension LoginViewModel {
    // MARK: - ModelLoginResponse
    struct ModelLoginResponse: Codable {
        let token: String?
        let user: User?
    }

    // MARK: - User
    struct User: Codable {
        let email: String?
        let id: Int?
        let phone, name: String?
    }
}
