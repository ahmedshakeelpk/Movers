//
//  ForgotPasswordViewModel.swift
//  Movers
//
//  Created by Shakeel Ahmed on 11/01/2025.
//

import Combine
import Foundation
import SwiftUI

class ForgotPasswordViewModel: ObservableObject {
    
//    @Published var textFieldEmail = "maaz1@ali.com"
    @Published var textFieldEmail = ""
    @Published var emailErrorMessage = ""
    @Published var navigateToLoginView: Bool = false
    @Published var dissmissToBackScreen: Bool = false

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
    
    struct ModelForgotResponse: Codable {
        let name: String?
    }
    
    func forgotPassword() {
        let parameters = [
            "email": textFieldEmail
        ] as! [String: Any]
        print("forgotPassword: \(parameters)")
        APIs.postAPI(apiName: .forgotPassword, parameters: parameters) { responseData, success, errorMsg, statusCode  in
            if success { }
            do {
                let model: ApiResponse<[ModelForgotResponse]>? = try APIs.decodeDataToObject(data: responseData)
                if model?.status == 200 {
                    showPopup(title: "Success!", message: model?.message ?? "", imageIcon: .successIcon) {
                        self.dissmissToBackScreen = true
                    }
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

extension ForgotPasswordViewModel {
    // MARK: - ModelLoginResponse
    struct ModelLoginResponse: Codable {
        let message: Message
        let data: String
        let status: Int
    }

    // MARK: - Message
    struct Message: Codable {
        let token: String
        let user: User
    }

    // MARK: - User
    struct User: Codable {
        let email: String
        let id: Int
        let phone, name: String
    }
}
