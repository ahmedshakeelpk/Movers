//
//  NavigationView.swift
//  TraningAssingmentOne
//
//  Created by Shakeel Ahmed on 08/01/2024.
//

import SwiftUI

struct NavigationBarView: View {
    
    @State var titleName = ""
    @State var titleIcon = ""
    @State var buttonLeftName = ""
    @State var buttonRightName = ""
    @State var leftIconName = ""
    @State var rightIconName = ""
    @State var backGroundColor = AppColor.colorBackGroundGray
    @State var titleColor = AppColor.colorTextBlack
    
    
    
    var isLeftButtonClick: () -> Void
    var isRightButtonClick: () -> Void

    var body: some View {
        VStack {
            HStack {
                Button() {
                    isLeftButtonClick()
                } label: {
                    if buttonLeftName != "" {
                        HStack {
                            Text(buttonLeftName)
                                .foregroundColor(backGroundColor == .white ? .black : .white)
                            Spacer()
                        }
                        
                    }
                    else {
                        HStack {
                            Image(leftIconName)
                                .renderingMode(.original)
                                .resizable()
                                .scaledToFit() // Ensures the image maintains its aspect ratio
                                .padding(0)
                                .frame(width: 16, height: 16)
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                            Spacer()
                        }
                        .frame(width: 38, height: 38)
                    }
                }
                Spacer()

                Button() {

                } label: {
                    if titleName != "" {
                        Text(titleName)
                            .foregroundColor(titleColor)
                            .font(.system(size: 18, weight: .medium))
                    }
                    else {
                        Image(titleIcon)
                            .renderingMode(.original)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(0)
                            .frame(width: 100, height: 28)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    }
                }
                Spacer()
                Button() {
                    isRightButtonClick()
                } label: {
                    if buttonRightName != "" {
                        HStack {
                            Spacer()
                            Text(buttonRightName)
                                .foregroundColor(backGroundColor == .white ? .black : .white)
                        }
                    }
                    else {
                        Image(rightIconName)
                            .renderingMode(.original)
                            .resizable()
                            .padding(0)
                            .frame(width: 38, height: 38)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    }
                }
            }
            .background(backGroundColor)
            .frame(height: 50)
        }
        .background(backGroundColor)
    }
}

#Preview {
    NavigationBarView(isLeftButtonClick: {}, isRightButtonClick: {})
}

extension EnvironmentValues {
    var dismissable: () -> Void {
        return dismissAction
    }
    
    private func dismissAction() {
        if #available(iOS 15, *) {
            dismiss()
        } else {
            presentationMode.wrappedValue.dismiss()
        }
    }
}
