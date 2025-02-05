//
//  PaymentMethodBottomSheet.swift
//   Movers
//
//  Created by Shakeel Ahmed on 25/11/2024.
//

import SwiftUI

struct PaymentMethodBottomSheet: View {
    //For BottomSheet
    @State private var isViewFullyPresented = false // Track when the sheet is fully presented
    @Binding var isPresented: Bool
    @State var colorOpacityBackGround = 0.0
    //End For BottomSheet
    
    @Environment(\.dismissable) var myDismiss
    @State private var textFieldSearch: String = ""
    var didSelectRowHandler: (Int) -> Void?
    
    let listRowMinHeight: Double = 115 // This is a guess
    var listRowHeight: Double {
        max(listRowMinHeight, 0 )
    }
    
    var arrayBillPaymentType: [SourceAccountType] = [
        SourceAccountType(
            name: "Debit/Credit Card",
            description: "" ,
            icon: "card"),
        SourceAccountType(name: "Apple Pay",
                          description: "" ,
                          icon: "apple"),
        SourceAccountType(name: "Google Pay",
                          description: "" ,
                          icon: "google")
    ]
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.clear // Set a clear background for the ZStack
            VStack {
                VStack(alignment: .leading) {
                    VStack {
                        TitleTopBarView
                        TitleView
                            .padding(.bottom, 12)
                        DataListView
                    }
                    .padding(.horizontal, 25)
                    ButtonConfirmView
                }
                .padding(.bottom, 30)
                .background(.white)
                .cornerRadius(20, corners: [.topLeft, .topRight])
                .onAppear() {
                    print("view load")
                    isViewFullyPresented = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.colorOpacityBackGround = 0.1
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        //            .presentationBackground(.clear)
        .safeAreaInset(edge: .bottom, spacing: 0) {
            VStack {
                // Your footer content or CTA
                // It will respect the safe area
            }
            .frame(maxWidth: .infinity)
            .background(.white)
        }
        .background(
            isViewFullyPresented ?
            Color.black.opacity(colorOpacityBackGround) // Add dimmed background when the sheet is open
                .ignoresSafeArea()
                .onTapGesture {
                    self.colorOpacityBackGround = 0.0
                    withAnimation {
                        isPresented = false // Dismiss the sheet when tapping outside
                    }
                }
            : nil
        )
        .ignoresSafeArea(edges: .all) // Extend to edges of the screen
    }
    var TitleTopBarView: some View {
        HStack{
            Spacer()
            Rectangle()
                .fill(AppColor.colorDarkGray)
                .frame(width: 55, height: 8)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                .clipShape(Capsule())
            Spacer()
        }
        .padding(.top, 20)
    }
    var TitleView: some View {
        HStack {
            Text("Select Payment Method")
                .font(.system(size: 22, weight: .bold))
                .multilineTextAlignment(.leading)
            Spacer()
        }
        .padding(.top, 16)
        .padding(.bottom, 1)
    }
    
    var DataListView: some View {
        VStack(spacing: 0) {
            ScrollView {
                ForEach(Array(arrayBillPaymentType.enumerated()), id: \.element) { index, model in
                    VStack(spacing: 0) {
                        ChooseSourceAccountBottomSheetViewCell(name: model.name, description: model.description, icon: model.icon)
                            .onTapGesture {
                                print("Tapped cell")  // This triggers when you tap anywhere in the cell
                                self.colorOpacityBackGround = 0.0
                                withAnimation {
                                    isPresented = false
                                }
                                didSelectRowHandler(index)
                            }
                    }
                }
            }
            .frame(height: CGFloat(arrayBillPaymentType.count) * CGFloat(self.listRowHeight))
            .listStyle(PlainListStyle()) // Use plain list style
            .background(Color.white) // Add custom background
            //            }
        }
        .layoutPriority(1)
    }
    
    var ButtonConfirmView: some View {
        VStack {
            DashLineWithShadowView
            VStack {
                Button(action: {
                    // Add your action here
                }) {
                    VStack {
                        Text("Confirm")
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
                .padding(.vertical, 12)
                .padding(.horizontal, 16)
            }
        }
        .background(.white)
    }
}

#Preview {
    PaymentMethodBottomSheet(isPresented: .constant(true), didSelectRowHandler: {_ in })
}


extension PaymentMethodBottomSheet {
    public struct SourceAccountType: Identifiable, Hashable {
        public let id = UUID() // <-- here
        
        var name: String
        var description: String
        var icon: String
        
        init(name: String, description: String, icon: String) {
            self.name = name
            self.description = description
            self.icon = icon
        }
    }
    
    struct ChooseSourceAccountBottomSheetViewCell: View {
        
        var name: String!
        var description: String!
        var icon: String!
        
        var body: some View {
            VStack {
                Spacer()
                VStack {
                    HStack(spacing: 20) {
                        VStack {
                            HStack(spacing: 0) {
                                Image(icon)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20, height: 20)
                                    .padding(.horizontal, icon == "card" ? 12 : 0)
                                if icon != "card".lowercased() {
                                    Text("Pay")
                                }
                            }
                            .padding()
                        }
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10) // Use `Rectangle()` for sharp corners
                                .stroke(AppColor.colorBorder, lineWidth: 1)
                        )
                        .frame(width: 100)
                        VStack(alignment: .leading) {
                            Text(name)
                                .foregroundColor(AppColor.colorBlack)
                                .font(.system(size: 14, weight: .regular))
                                .multilineTextAlignment(.leading)
                        }
                        Spacer()
                        VStack {
                            Image(.uncheckCircle)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 18, height: 18)
                        }
                    }
                    .frame(height: 60)
                    .padding()
                }
                .background(.white)
                .cornerRadius(10) // Add corner radius
                // Add some padding inside the border
                .overlay(
                    RoundedRectangle(cornerRadius: 10) // Use `Rectangle()` for sharp corners
                        .stroke(AppColor.colorBorder, lineWidth: 1)
                )
                Spacer()
            }
            .listRowSeparator(.hidden)
            .padding(0)
        }
    }
}
