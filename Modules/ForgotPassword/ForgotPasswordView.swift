//
//  ForgotPasswordView.swift
//  Movers
//
//  Created by Shakeel Ahmed on 11/01/2025.
//
import SwiftUI

struct ForgotPasswordView: View {
    @Environment(\.dismiss) var myDismiss
    @StateObject private var viewModel: ForgotPasswordViewModel

    init() {
        _viewModel = StateObject(wrappedValue: ForgotPasswordViewModel())
    }
    
    var navigationBar: some View {
        NavigationBarView(titleName: "Forgot Password", leftIconName: "backButton", isLeftButtonClick: {
            print("isLeftButtonClick Clicked")
            myDismiss()
        }, isRightButtonClick: {})
    }
    
    var body: some View {
        ZStack {
            VStack {
                VStack(spacing: 0) {
                    navigationBar
                        .padding(.bottom, 0)
                        .padding(.horizontal, 16)
                    VStack {
                        EmailView
                        Spacer()
                        ButtonConfirmView
                            .padding(.bottom, 16)
                    }
                }
                .background(AppColor.colorBackGroundGray)
                .edgesIgnoringSafeArea(.bottom) // Allows map to extend to edges if needed
                .navigationBarHidden(true)
            }
            .onTapGesture {
                hideKeyboard()
            }
        }
        .onChange(of: viewModel.dissmissToBackScreen) { newValue in
            if newValue {
                myDismiss()
            }
        }
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
    
    var ButtonConfirmView: some View {
        VStack {
            DashLineWithShadowView
            Button(action: {
                viewModel.forgotPassword()
            }) {
                VStack {
                    Text("Send")
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
        .disabled(!viewModel.isValidEmail(viewModel.textFieldEmail))
    }
}
#Preview {
    ForgotPasswordView()
}
