    //
    //  LoginView.swift
    //   Movers
    //
    //  Created by Shakeel Ahmed on 28/11/2024.
    //

    import SwiftUI

    struct LoginView: View {
        @Environment(\.dismiss) var myDismiss    
        @StateObject private var viewModel: LoginViewModel

        init() {
            _viewModel = StateObject(wrappedValue: LoginViewModel())
        }
        
        var navigationBar: some View {
            NavigationBarView(titleName: "Login", isLeftButtonClick: {
                
            }, isRightButtonClick: {})
        }
        
        var body: some View {
            ZStack {
                VStack(spacing: 0) {
                    navigationBar
                        .padding(.bottom, 0)
                        .padding(.horizontal, 16)
                    VStack {
                        EmailView
                        PasswordView
                        ForgotPasswordButtonView
                        Spacer()
                        RegisterButtonView
                        ButtonConfirmView
                            .padding(.bottom, 16)
                    }
                }
                .background(AppColor.colorBackGroundGray)
                .onTapGesture {
                    hideKeyboard()
                }
                NavigationLink(
                    destination: SignUpView(),
                    isActive: $viewModel.navigateToSignUpView,
                    label: { EmptyView() }
                )
                NavigationLink(
                    destination: ForgotPasswordView(),
                    isActive: $viewModel.navigateToForgotPasswordView,
                    label: { EmptyView() }
                )
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarHidden(true) // Hide the navigation bar here for the entire view
        }
            
        var EmailView: some View {
            VStack(alignment: .leading) {
                VStack {
                    HStack {
                        Image(.emailIcon) // Replace with your custom image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                        TextField("Email", text: $viewModel.textFieldEmail)
                            .onChange(of: viewModel.textFieldEmail) { _ in
                                viewModel.validateEmail()
                            }
                        .font(.system(size: 14, weight: .regular))
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 16)
                }
                .background(Color.white)
                .cornerRadius(10) // Add corner radius
                .overlay(
                    RoundedRectangle(cornerRadius: 10) // Rounded border
                        .stroke(viewModel.emailErrorMessage.isEmpty ? AppColor.colorBorder : Color.red, lineWidth: 1)
                )
                .padding(.horizontal, 16)
                
                // Error message below the text field
                if !viewModel.emailErrorMessage.isEmpty {
                    Text(viewModel.emailErrorMessage)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(.red)
                        .padding(.horizontal, 16)
                }
            }
            .padding(.top, 16)
        }
        
        var PasswordView: some View {
            VStack(alignment: .leading) {
                HStack {
                    Image(.passwordIcon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)

                    if viewModel.isPasswordVisible {
                        TextField("Password", text: $viewModel.textFieldPassword)
                            .font(.system(size: 14, weight: .regular))
                            .autocapitalization(.none)
                    } else {
                        SecureField("Password", text: $viewModel.textFieldPassword)
                            .font(.system(size: 14, weight: .regular))
                            .autocapitalization(.none)
                    }

                    Button(action: {
                        viewModel.isPasswordVisible.toggle()
                    }) {
                        Image(systemName: viewModel.isPasswordVisible ? "eye.slash" : "eye")
                            .foregroundColor(.gray)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 16)
                .background(Color.white)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(AppColor.colorBorder, lineWidth: 1)
                )
                .padding(.horizontal, 16)

                // Optional Error Message
                if !viewModel.passwordErrorMessage.isEmpty {
                    Text(viewModel.passwordErrorMessage)
                        .font(.system(size: 12))
                        .foregroundColor(.red)
                        .padding(.horizontal, 16)
                }
            }
            .padding(.top, 16)
        }
        
        var RegisterButtonView: some View {
            VStack {
                VStack {
                    Button(action: {
                        viewModel.navigateToSignUpView = true
                    }, label: {
                        Text("Register User")
                    })
                }
                .cornerRadius(10) // Add corner radius
    //            .overlay(
    //                RoundedRectangle(cornerRadius: 10) // Rounded border
    //                    .stroke(AppColor.colorBorder, lineWidth: 1)
    //            )
                .padding(.horizontal, 16)
            }
            .padding(.top, 16)
        }
        
        var ForgotPasswordButtonView: some View {
            VStack {
                VStack {
                    Button(action: {
                        viewModel.navigateToForgotPasswordView = true
                    }, label: {
                        Text("Forgot Password")
                    })
                }
                .cornerRadius(10) // Add corner radius
    //            .overlay(
    //                RoundedRectangle(cornerRadius: 10) // Rounded border
    //                    .stroke(AppColor.colorBorder, lineWidth: 1)
    //            )
                .padding(.horizontal, 16)
            }
            .padding(.top, 16)
        }
        
        var ButtonConfirmView: some View {
            VStack {
                DashLineWithShadowView
                Button(action: {
                    viewModel.login()
                }) {
                    VStack {
                        Text("Login")
                            .font(.system(size: 16, weight: .bold))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity) // Ensure the button takes full width
                    .padding() // Add padding inside the button
                    .background(AppColor.colorBlack)
                    .cornerRadius(10) // Add corner radius
                    .overlay(
                        RoundedRectangle(cornerRadius: 10) // Rounded border
                            .stroke(AppColor.colorBorder, lineWidth: 1)
                    )
                }
                .buttonStyle(PlainButtonStyle())
                .frame(height: 45)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .padding(.bottom, 20)
            }
            .background(.white)
            .disabled(!viewModel.isFormValid)
        }
    }
    #Preview {
        LoginView()
    }
    // Helper extension to get the current navigation controller
    extension UINavigationController {
        static func getCurrentNavigationController() -> UINavigationController? {
            guard let rootVC = UIApplication.shared.windows.first?.rootViewController else {
                return nil
            }
            
            if let navController = rootVC as? UINavigationController {
                return navController
            }
            
            if let navController = rootVC.navigationController {
                return navController
            }
            
            return nil
        }
    }

func hideKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
}
