//
//  ContentView.swift
//  Movers
//
//  Created by Shakeel Ahmed on 08/01/2025.
//

import SwiftUI

//struct ContentView: View {
//    @State private var isUrdu = Locale.current.languageCode == "ur" // Automatically detect current language
//
//    var body: some View {
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundStyle(.tint)
//
//            Text("hello_world".localized) // Localized text
//
//            Button(action: {
//                toggleLanguage()
//            }, label: {
//                Text("change_language".localized)
//            })
//            .padding()
//            .background(Color.blue)
//            .foregroundColor(.white)
//            .cornerRadius(8)
//        }
//        .padding()
//    }
//
//    func toggleLanguage() {
//        let newLang = isUrdu ? "en" : "ur"
//        UserDefaults.standard.set([newLang], forKey: "AppleLanguages")
//        UserDefaults.standard.synchronize()
//        exit(0) // Restart the app to apply language changes
//    }
//}
//
//extension String {
//    var localized: String {
//        return NSLocalizedString(self, comment: "")
//    }
//}
//
//#Preview {
//    ContentView()
////    ContentView2(
////        image: "success",
////        title: "Your Title",
////        description: "Your description goes here.",
////        buttonText: "OK",
////        buttonCancelText: "Cancel",
////        buttonAction: {},
////        cancelButtonAction: {}
////    )
//}
//
//
//struct ContentView2: View {
//    var image: String
//    var title: String
//    var description: String
//    var buttonText: String
//    var buttonCancelText: String? = ""
//    var buttonAction: () -> Void
//    var cancelButtonAction: (() -> Void)? = nil
//    
//    var body: some View {
//        VStack {
//            Spacer()
//            VStack(spacing: 20) {
//                Image(image)
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 80, height: 80)
//                    .padding(.top,10)
//                if title != "" {
//                    Text(LocalizedStringKey(title))
//                        .font(.custom("", size: 24))
//                        .foregroundColor(AppColor.colorBlack)
//                        .multilineTextAlignment(.center)
//                }
//                Text(LocalizedStringKey(description))
//                    .font(.custom("", size: 14))
//                    .foregroundColor(AppColor.colorGreen)
//                    .multilineTextAlignment(.center)
//                    .padding(.horizontal)
//                VStack {
//                    GeometryReader { geometry in
//                        Button(action: {
//                            buttonAction()
//                        }) {
//                            Text(LocalizedStringKey(buttonText))
//                                .font(.custom("", size: 10))
//                                .foregroundColor(.white)
//                                .padding()
//                                .frame(maxWidth: .infinity)
//                                .background(
//                                    RoundedRectangle(cornerRadius: geometry.size.height / 2)
//                                        .fill(AppColor.colorOrange)
//                                )
//                                .foregroundColor(.white)
//                                .cornerRadius(30)
//                        }
//                        .frame(height: geometry.size.height)
//                    }
//                    .frame(height: 40)
//                    .padding(.horizontal)
//                    
//                    if !buttonCancelText!.isEmpty {
//                        GeometryReader { geometry in
//                            Button(action: {
//                                cancelButtonAction?()
//                            }) {
//                                Text(LocalizedStringKey(buttonCancelText!))
//                                    .font(.custom("", size: 10))
//                                    .foregroundColor(AppColor.colorOrange) // Text color
//                                    .padding()
//                                    .frame(maxWidth: .infinity)
//                                    .background(
//                                        RoundedRectangle(cornerRadius: 30) // Make the capsule shape with a fixed corner radius
//                                            .stroke(AppColor.colorOrange, lineWidth: 1) // Border with specified color and line width
//                                            .background(
//                                                RoundedRectangle(cornerRadius: 30)
//                                                    .fill(.white) // Background color
//                                            )
//                                    )
//                                    .cornerRadius(30)
//                            }
//                            .frame(height: geometry.size.height)
//                        }
//                        .frame(height: 50)
//                        .padding(.horizontal)
//                    }
//                }
//                .padding(.bottom, 20)
//            }
//            .padding()
//            .background(Color.white)
//            .cornerRadius(20)
//            .shadow(radius: 10)
//            .padding(.horizontal, 40)
//            Spacer()
//        }
//        .background(Color.black.opacity(0.4).edgesIgnoringSafeArea(.all))
//    }
//}


import SwiftUI


struct ContentView: View {
    @EnvironmentObject var loadingState: LoadingState

    var body: some View {
        VStack {
            Button("Show Loading") {
                loadingState.isLoading = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    loadingState.isLoading = false
                }
            }
        }
    }
}





//
//  SplashView.swift
//  RTK_Spike
//
//  Created by Jason Cheladyn on 2022/04/04.
//

import SwiftUI

struct SplashView: View {
    
    @State var isActive: Bool = false
    
    var body: some View {
        ZStack {
            if self.isActive {
                LoginView()
            } else {
                Rectangle()
                    .background(Color.black)
                Image("LiyickyLogoWhite")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
        
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
