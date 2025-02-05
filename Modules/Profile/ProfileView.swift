//
//  ProfileView.swift
//  Movers
//
//  Created by Shakeel Ahmed on 11/01/2025.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.dismiss) var myDismiss
    @StateObject private var viewModel: ForgotPasswordViewModel
    @State private var showLogoutAlert = false // State to control the alert visibility
    
    init() {
        _viewModel = StateObject(wrappedValue: ForgotPasswordViewModel())
    }
    
    var navigationBar: some View {
        NavigationBarView(titleName: "Profile", isLeftButtonClick: {}, isRightButtonClick: {})
    }
    
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                navigationBar
                    .padding(.bottom, 0)
                    .padding(.horizontal, 16)
                VStack {
                    UserDataView
                    Spacer()
                    ButtonConfirmView
                        .padding(.bottom, 16)
                }
            }
            .background(AppColor.colorBackGroundGray)
        }
        .padding(.bottom, 60)
        .alert("Confirm Logout", isPresented: $showLogoutAlert) {
            Button("Cancel", role: .cancel) {}
            Button("Logout", role: .destructive) {
                // Perform logout action
                setRootViewController(LoginView())
            }
        } message: {
            Text("Are you sure you want to log out?")
        }
    }
    
    
    var UserDataView: some View {
        VStack(spacing: 16) {
            // Profile Image
            Image(.userIcon) // Replace with your image asset name
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 120, height: 120)
                .clipShape(Circle())
                .shadow(radius: 5)
            
            // Name
            Text(kUserData?.name ?? "")
                .font(.title)
                .fontWeight(.bold)
            
            // Details
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Image(systemName: "envelope")
                        .foregroundColor(.blue)
                    Text(kUserData?.email ?? "")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                HStack {
                    Image(systemName: "phone")
                        .foregroundColor(.green)
                    Text(kUserData?.phone ?? "")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                //                HStack(alignment: .top) {
                //                    Image(systemName: "person.text.rectangle")
                //                        .foregroundColor(.orange)
                //                        .padding(.top, 2)
                //                    Text("A software engineer passionate about building intuitive user experiences and scalable applications.")
                //                        .font(.subheadline)
                //                        .foregroundColor(.gray)
                //                }
            }
            .padding(.horizontal, 26)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
        }
        .padding(.top, 40)
        .navigationBarTitle("Profile", displayMode: .inline) // Add navigation title if needed
        .background(Color(UIColor.systemGroupedBackground))
    }
    
    
    var ButtonConfirmView: some View {
        VStack {
            DashLineWithShadowView
            Button(action: {
                showLogoutAlert = true // Show the alert
                //                setRootViewController(LoginView())
            }) {
                VStack {
                    Text("Logout")
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
    }
}

#Preview {
    ProfileView()
}
