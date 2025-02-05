//
//  SignUpViewModel.swift
//  Movers
//
//  Created by Shakeel Ahmed on 09/01/2025.
//

import Combine
import Foundation

class SignUpViewModel: ObservableObject {
    
    @Published var textFieldName = ""
    @Published var textFieldEmail = ""
    @Published var textFieldPhone = ""
    @Published var textFieldPassword = ""
    @Published var textFieldReEnterPassword = ""
    @Published var emailErrorMessage = ""
    @Published var passwordErrorMessage = ""
    @Published var isPasswordVisible: Bool = false
    @Published var isReEnterPasswordVisible: Bool = false
    @Published var dissmissToBackScreen: Bool = false
    @Published var keyboardHeight: CGFloat = 0

    // Manually update isFormValid
    @Published var isFormValid: Bool = false
    
    @Published var isPasswordValid: Bool = false {
        didSet {
            updateFormValidity()  // Ensure isFormValid is updated whenever password validity changes
        }
    }

    func updateFormValidity() {
        isFormValid = !textFieldName.isEmpty &&
                      !textFieldEmail.isEmpty &&
                      textFieldPassword.count > 7 &&
                      isPasswordValid
    }
    
    // Call this function to manually check if the password is valid
    func validatePassword() {
        isPasswordValid = textFieldPassword == textFieldReEnterPassword
        if !isPasswordValid && !textFieldReEnterPassword.isEmpty && !textFieldPassword.isEmpty {
            passwordErrorMessage = "Password and enter password not match"
        }
        else {
            passwordErrorMessage = ""
        }
    }
    
    var loadingState: LoadingState
    
    init() {
        loadingState = LoadingState()
    }
    
    var modelRegisterResponse: SignUpView.ModelRegisterResponse? {
        didSet {
            showPopup(title: "Success!", message: "User register successfully please login with your details", imageIcon: .successIcon) {
                self.dissmissToBackScreen = true
            }
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

    func register() {
        let parameters = [
            "name": textFieldName,
            "email": textFieldEmail,
            "phone": textFieldPhone,
            "password": textFieldPassword
        ] as! [String: Any]
        APIs.postAPI(apiName: .register, parameters: parameters) { responseData, success, errorMsg, statusCode  in
            if success { }
            do {
                let model: ApiResponse<SignUpView.ModelRegisterResponse>? = try APIs.decodeDataToObject(data: responseData)
                if model?.status == 200 {
                    self.modelRegisterResponse = model?.data
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

extension SignUpView {
    // MARK: - ModelRegisterResponse
    struct ModelRegisterResponse: Codable {
        let token: String?
        let user: User?
    }

    // MARK: - User
    struct User: Codable {
        let email, phone: String?
        let id: Int?
        let name: String?
    }
}

// MARK: - ModelErrorResponse
struct ModelErrorResponse: Codable {
    let message: String?
    let errors: Errors?
}

// MARK: - Errors
struct Errors: Codable {
    let password: [String]?
}


struct ApiResponse<T: Codable>: Codable {
    let status: Int?
    let message: String?
    let data: T?
    let modelErrorResponse: ModelErrorResponse?
}
