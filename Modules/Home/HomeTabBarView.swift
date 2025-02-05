//
//  HomeTabBarView.swift
//   Movers
//
//  Created by Shakeel Ahmed on 27/11/2024.
//

import SwiftUI

struct HomeTabBarView: View {
    @State private var selectedTab = 0

    var body: some View {
        ZStack {
            // Main Content
            switch selectedTab {
            case 0:
                HomeView()
            case 1:
                Text("Search Screen")
            case 2:
                Text("Profile Screen")
            case 3:
                ProfileView()
            default:
                Text("Home Screen")
            }

            // Custom TabBar
            VStack {
                Spacer()
                HStack {
                    TabBarButton(iconName: "homeTab", label: "Home", isSelected: selectedTab == 0) {
                        selectedTab = 0
                    }
                    TabBarButton(iconName: "serviceTab", label: "Service", isSelected: selectedTab == 1) {
                        selectedTab = 1
                    }
                    TabBarButton(iconName: "historyTab", label: "History", isSelected: selectedTab == 2) {
                        selectedTab = 2
                    }
                    TabBarButton(iconName: "accountTab", label: "Account", isSelected: selectedTab == 3) {
                        selectedTab = 3
                    }
                }
                .padding(.top, 16)
                .padding(.bottom, 8)
                .background(Color.white)
//                .shadow(radius: 10)
            }
        }
    }
    
    struct TabBarButton: View {
        let iconName: String
        let label: String
        let isSelected: Bool
        let action: () -> Void

        var body: some View {
            VStack {
                Button(action: action) {
                    VStack(spacing: 8) {
                        Image(iconName)
                            .renderingMode(.template)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                            .foregroundColor(isSelected ? AppColor.colorBlack : .gray)
                        
                        Text(label)
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(isSelected ? AppColor.colorBlack : .gray)
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}



#Preview {
    HomeTabBarView()
}

struct TabBarButton: View {
    let icon: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(isSelected ? .blue : .gray)
        }
        .frame(maxWidth: .infinity)
    }
}
