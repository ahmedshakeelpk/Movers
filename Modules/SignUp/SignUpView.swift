//
//  SignUpView.swift
//  Movers
//
//  Created by Shakeel Ahmed on 28/11/2024.
//

import SwiftUI

struct SignUpView: View {
    @Environment(\.dismiss) var myDismiss
    @State var textFieldSearchAddress = ""
    @State var isForDropOff = false
    
    @StateObject var viewModel: SignUpViewModel
    
    init() {
        _viewModel = StateObject(
            wrappedValue:
                SignUpViewModel(
                    
                )
        )
    }
    
    var navigationBar: some View {
        NavigationBarView(titleName: "Signup", leftIconName: "backButton", isLeftButtonClick: {
            print("isLeftButtonClick Clicked")
            myDismiss()
        }, isRightButtonClick: {})
    }
    
    var body: some View {
        VStack(spacing: 0) {
            navigationBar
                .padding(.bottom, 0)
                .padding(.horizontal, 16)
            ScrollView {
                VStack {
                    NameView
                    EmailView
                    PhoneNumberView
                    PasswordView
                    ReEnterPasswordView
                    Spacer()
                }
                .padding(.bottom, viewModel.keyboardHeight) // Ensure content is not hidden by the keyboard
            }
            ButtonConfirmView
                .padding(.bottom, 16)
        }
        .background(AppColor.colorBackGroundGray)
        .edgesIgnoringSafeArea(.bottom) // Allows map to extend to edges if needed
        .navigationBarHidden(true) // Hide navigation bar here as well
        .onChange(of: viewModel.dissmissToBackScreen) { newValue in
            if newValue {
                myDismiss()
            }
        }
        .onTapGesture {
            hideKeyboard()
        }
        .onAppear {
            // Add keyboard observers
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
                if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                    withAnimation {
                        viewModel.keyboardHeight = keyboardFrame.height
                    }
                }
            }
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
                withAnimation {
                    viewModel.keyboardHeight = 0
                }
            }
        }
    }
    
    
    
    var NameView: some View {
        VStack {
            VStack {
                HStack {
                    Image(.userIcon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                    TextField("Name", text: $viewModel.textFieldName)
                        .font(.system(size: 14, weight: .regular))
                        .onChange(of: viewModel.textFieldName) { _ in
                            viewModel.updateFormValidity()
                        }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 16)
            }
            .background(.white)
            .cornerRadius(10) // Add corner radius
            .overlay(
                RoundedRectangle(cornerRadius: 10) // Rounded border
                    .stroke(AppColor.colorBorder, lineWidth: 1)
            )
            .padding(.horizontal, 16)
        }
        .padding(.top, 16)
    }
    var EmailView: some View {
        VStack {
            VStack {
                HStack {
                    Image(.emailIcon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                    TextField("Email", text: $viewModel.textFieldEmail)
                        .onChange(of: viewModel.textFieldEmail) { _ in
                            viewModel.validateEmail()
                            viewModel.updateFormValidity()
                        }
                        .font(.system(size: 14, weight: .regular))
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 16)
            }
            .background(.white)
            .cornerRadius(10) // Add corner radius
            .overlay(
                RoundedRectangle(cornerRadius: 10) // Rounded border
                    .stroke(AppColor.colorBorder, lineWidth: 1)
            )
            .padding(.horizontal, 16)
        }
        .padding(.top, 16)
    }
    
    var PhoneNumberView: some View {
        VStack {
            VStack {
                HStack {
                    Image(.phoneNumberIcon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                    TextField("Phone Number", text: $viewModel.textFieldPhone)
                        .font(.system(size: 14, weight: .regular))
                        .keyboardType(.numberPad)
                        .onChange(of: viewModel.textFieldPhone) { _ in
                            viewModel.updateFormValidity()
                        }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 16)
            }
            .background(.white)
            .cornerRadius(10) // Add corner radius
            .overlay(
                RoundedRectangle(cornerRadius: 10) // Rounded border
                    .stroke(AppColor.colorBorder, lineWidth: 1)
            )
            .padding(.horizontal, 16)
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
                        .onChange(of: viewModel.textFieldPassword) { _ in
                            viewModel.updateFormValidity()
                            viewModel.validatePassword()
                        }
                } else {
                    SecureField("Password", text: $viewModel.textFieldPassword)
                        .font(.system(size: 14, weight: .regular))
                        .autocapitalization(.none)
                        .onChange(of: viewModel.textFieldPassword) { _ in
                            viewModel.updateFormValidity()
                            viewModel.validatePassword()
                        }
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
        }
        .padding(.top, 16)
    }
    
    var ReEnterPasswordView: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(.passwordIcon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                
                if viewModel.isReEnterPasswordVisible {
                    TextField("Re-Enter Password", text: $viewModel.textFieldReEnterPassword)
                        .font(.system(size: 14, weight: .regular))
                        .autocapitalization(.none)
                        .onChange(of: viewModel.textFieldReEnterPassword) { _ in
                            viewModel.updateFormValidity()
                            viewModel.validatePassword()
                        }
                } else {
                    SecureField("Re-Enter Password", text: $viewModel.textFieldReEnterPassword)
                        .font(.system(size: 14, weight: .regular))
                        .autocapitalization(.none)
                        .onChange(of: viewModel.textFieldReEnterPassword) { _ in
                            viewModel.updateFormValidity()
                            viewModel.validatePassword()
                        }
                }
                
                Button(action: {
                    viewModel.isReEnterPasswordVisible.toggle()
                }) {
                    Image(systemName: viewModel.isReEnterPasswordVisible ? "eye.slash" : "eye")
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
            if !viewModel.passwordErrorMessage.isEmpty && !viewModel.isPasswordValid {
                Text(viewModel.passwordErrorMessage)
                    .font(.system(size: 12))
                    .foregroundColor(.red)
                    .padding(.horizontal, 16)
            }
        }
        .padding(.top, 16)
    }
    
    var ButtonConfirmView: some View {
        VStack {
            DashLineWithShadowView
            
            Button(action: {
                // Add your action here
                viewModel.register()
            }) {
                VStack {
                    Text("Register")
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
            .disabled(!viewModel.isFormValid)
        }
        .background(.white)
    }
}

#Preview {
    SignUpView()
}
