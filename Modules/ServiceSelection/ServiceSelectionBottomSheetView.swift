//
//  ServiceSelectionBottomSheetView.swift
//   Movers
//
//  Created by Shakeel Ahmed on 20/11/2024.
//

import SwiftUI



struct ServiceSelectionBottomSheetView: View {
    //For BottomSheet
    @State private var isViewFullyPresented = false // Track when the sheet is fully presented
    @Binding var isPresented: Bool
    @State var colorOpacityBackGround = 0.0
    //End For BottomSheet
    
    @State private var textFieldSearch: String = ""
    
    let listRowMinHeight: Double = 115 // This is a guess
    var listRowHeight: Double {
        max(listRowMinHeight, 0 )
    }
    
//    Data Area
    @State var modelResponseServices: HomeViewModel.ModelResponseServices?
    
    //    End Data Area

    var didSelectRowHandler: (Int) -> Void?
    @State private var selectedIndex: Int? = nil
    @State private var selectedValue: String? = nil
    var isFormValid: Bool {
        return selectedIndex != nil
    }
        
    var arrayBillPaymentType: [SourceAccountType] = [
        SourceAccountType(
            name: "Moving & Packing",
            description: "Perfect for moving sofa, some boxes, or few items        " ,
            icon: "firstPayCard"),
        SourceAccountType(name: "Moving Only",
                          description: "Perfect for moving sofa, some boxes, or few items         " ,
                          icon: "hblCard"),
        SourceAccountType(name: "Packing Only",
                          description: "Perfect for moving sofa, some boxes, or few items        " ,
                          icon: "hblCard")
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
            .padding(.bottom, 75)
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
            Text("Service Selection")
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
                    if let services = modelResponseServices?.services {
                        ForEach(Array(services.enumerated()), id: \.0) { index, service in
                            ChooseSourceAccountBottomSheetViewCell(
                                name: service.name ?? "",
                                description: service.desc ?? "",
                                isIconChecked: self.selectedIndex == index,
                                onCheckChanged: {
                                    // Update the selectedIndex when a cell is tapped
                                    if self.selectedIndex == index {
                                        self.selectedIndex = nil // Uncheck if the same item is tapped again
                                        self.selectedValue = nil // Uncheck if the same item is tapped again
                                    } else {
                                        self.selectedIndex = index // Check the tapped item
                                        self.selectedValue = service.name
                                    }
                                }
                            )
                        }
                    }
                }
                .frame(height: (modelResponseServices?.services?.count ?? 0 > 3 ? CGFloat(2.4) : CGFloat(modelResponseServices?.services?.count ?? 0)) * CGFloat(self.listRowHeight))
                .listStyle(PlainListStyle())
                .background(Color.white)
            }
            .layoutPriority(1)
        }
    
    var ButtonConfirmView: some View {
        VStack {
            DashLineWithShadowView
            VStack {
                Button(action: {
                    // Add your action here
                    print("Tapped cell")  // This triggers when you tap anywhere in the cell
                    self.colorOpacityBackGround = 0.0
                    withAnimation {
                        isPresented = false
                    }
                    if let index = selectedIndex {
                        didSelectRowHandler(index)
                    }
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
        .disabled(!isFormValid)
    }
}

#Preview {
    ServiceSelectionBottomSheetView(isPresented: .constant(true), didSelectRowHandler: {_ in })
}


extension ServiceSelectionBottomSheetView {
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
        var name: String
        var description: String
        var isIconChecked: Bool
        var onCheckChanged: () -> Void  // Closure to handle check/uncheck action
        
        var body: some View {
            VStack {
                Spacer()
                VStack {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(name)
                                .foregroundColor(AppColor.colorBlack)
                                .font(.system(size: 14, weight: .regular))
                                .multilineTextAlignment(.leading)
                            Spacer().frame(height: 6)
                            Text(description)
                                .foregroundColor(AppColor.colorBlack)
                                .font(.system(size: 14, weight: .thin))
                                .multilineTextAlignment(.leading)
                        }
                        Spacer()
                        VStack {
                            Image(isIconChecked ? .checkCircle : .uncheckCircle)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 18, height: 18)
                            Spacer()
                        }
                    }
//                    .frame(height: 60)
                    .padding()
                }
                .background(.white)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(AppColor.colorBorder, lineWidth: 1)
                )
                .onTapGesture {
                    onCheckChanged()  // Call the closure to update the selection
                }
                Spacer()
            }
            .listRowSeparator(.hidden)
            .padding(0)
            
        }
    }

}

extension String {
    func maskedAccount(visibleCount: Int? = 4, maskCharacter: Character? = "*") -> String {
        guard self.count > visibleCount! else {
            return self
        }
        let maskLength = self.count - visibleCount!
        let mask = String(repeating: maskCharacter!, count: maskLength)
        let visibleSuffix = self.suffix(visibleCount!)
        return mask + visibleSuffix
    }
}

struct DashLineFunction: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
}
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

var DashLineView: some View {
    VStack {
        DashLineFunction()
            .stroke(style: StrokeStyle(lineWidth: 1, dash: [1]))
            .foregroundColor(AppColor.colorDashLine)
            .frame(height: 1)
    }
}

var DashLineWithShadowView: some View {
    VStack {
        DashLineFunction()
            .stroke(style: StrokeStyle(lineWidth: 1, dash: [1]))
            .foregroundColor(AppColor.colorDashLine)
            .frame(height: 1)
            .shadow(color: Color.black.opacity(0.5), radius: 4, x: 0, y: -2) // Add shadow on top
    }
}
