//
//  AdditionalInformationView.swift
//   Movers
//
//  Created by Shakeel Ahmed on 24/11/2024.
//

import SwiftUI

struct AdditionalInformationView: View {
    @Environment(\.dismiss) var myDismiss
    @StateObject var viewModel = AdditionalInformationViewModel()

    
    @State private var isHeavyOn: Bool = false
    
    
    var navigationBar: some View {
        NavigationBarView(titleName: "Additional Information", leftIconName: "backButton", isLeftButtonClick: {
            print("isLeftButtonClick Clicked")
            myDismiss()
        }, isRightButtonClick: {})
    }
    var body: some View {
        ZStack {
            VStack {
                VStack {
                    navigationBar
                    ScrollView {
                        ScheduleServiceView
                        DateTimeView
                        HeavyItemsView
                        AddAnImageView
                        AdditionalCommentView
                        Spacer()
                    }
                }
                .padding(.horizontal, 16)
                ButtonConfirmView
            }
            .navigationBarHidden(true) // Hide navigation bar here as well
            .background(AppColor.colorBackGroundGray)
            .sheet(isPresented: $isImagePickerPresented) {
                // Image Picker
                ImagePicker(selectedImage: $currentImage, onImagePicked: { image in
                    selectedImages.append(image)
                })
            }
            if viewModel.isShowDateTimePickerView {
                DateTimePickerView
            }
            NavigationLink(
                destination: DropOffLocationView(),
                isActive: $viewModel.navigateToDropOffLocationView,
                label: { EmptyView()})
        }
    }
    
    var ScheduleServiceView: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text("Schedule Service")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(AppColor.colorTextBlack)
                Spacer()
            }
            Text("This will help us to manage things on time")
                .font(.system(size: 12, weight: .regular))
                .foregroundColor(AppColor.colorGrayTextColor)
                .multilineTextAlignment(.leading)
                .padding(.bottom, 0)
        }
    }
    
    var DateTimeView: some View {
        VStack {
            HStack {
                VStack (alignment: .leading, spacing: 0){
                    Text("Date")
                        .font(.system(size: 16, weight: .medium))
                        .padding(.bottom, 8)
                    
                    Button(action: {
                        withAnimation {
                            viewModel.isDatePicker = true
                            viewModel.isShowDateTimePickerView = true
                        }
                    }) {
                        VStack {
                            VStack {
                                HStack {
                                    Text(viewModel.selectedDateString)
                                        .frame(height: 30)
                                        .font(.system(size: 14, weight: .regular))
                                        .foregroundColor(viewModel.selectedDateString == "DD/MM/YYYY" ? AppColor.colorTextPlaceHolder : AppColor.colorTextBlack)
                                    Spacer()
                                    Image(.clock)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 16, height: 16)
                                        .foregroundColor(.gray)
                                }
                                .padding(.horizontal, 16)
                                .padding(.vertical, 9)
                            }
                        }
                        .background(Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(AppColor.colorBorder, lineWidth: 1)
                        )

                    }
                    .buttonStyle(PlainButtonStyle())
                }
                Spacer()
                VStack (alignment: .leading, spacing: 0){
                    Text("Time")
                        .font(.system(size: 16, weight: .medium))
                        .padding(.bottom, 8)
                    Button(action: {
                        withAnimation {
                            viewModel.isDatePicker = false
                            viewModel.isShowDateTimePickerView = true
                        }
                    }) {
                        VStack {
                            VStack {
                                HStack {
                                    Text(viewModel.selectedTimeString)
                                        .frame(height: 30)
                                        .font(.system(size: 14, weight: .regular))
                                        .foregroundColor(viewModel.selectedTimeString == "HH:MM" ? AppColor.colorTextPlaceHolder : AppColor.colorTextBlack)
                                    Spacer()
                                    Image(.clock)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 16, height: 16)
                                        .foregroundColor(.gray)
                                }
                                .padding(.horizontal, 16)
                                .padding(.vertical, 9)
                            }
                        }
                        .background(Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(AppColor.colorBorder, lineWidth: 1)
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            DashLineView
                .padding(.top, 20)
        }
        .padding(.top, 16)
    }
    
    var HeavyItemsView: some View {
        VStack {
            HStack {
                VStack (alignment: .leading, spacing: 0) {
                    Text("Heavy Items")
                        .font(.system(size: 16, weight: .medium))
                        .padding(.bottom, 8)
                    Text("This may help us to find the best option forr you       ")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(AppColor.colorGrayTextColor)
                        .multilineTextAlignment(.leading)
                        .padding(.bottom, 0)
                }
                VStack {
                    Toggle(isOn: $isHeavyOn) {
                        //                        if isHeavyOn {
                        //                            print("\(isHeavyOn ? "ON" : "OFF")")
                        //                        }
                    }
                    .toggleStyle(SwitchToggleStyle(tint: AppColor.colorTextBlack)) // Customizing the toggle color
                }
                .frame(width: 60)
            }
            .padding(.bottom, 16)
            
            if isHeavyOn {
                NoOfHeavyItemsView
            }
            DashLineView
        }
        .padding(.top, 8)
    }
    
    var NoOfHeavyItemsView: some View {
        VStack {
            HStack {
                VStack (alignment: .leading, spacing: 8){
                    Text("No. of Heavy Items \(viewModel.noOfHeavyItems)")
                        .font(.system(size: 16, weight: .bold))
                        .multilineTextAlignment(.leading)
                }
                Spacer()
                VStack {
                    HStack (spacing: 0) {
                        Button(action: {
                            if viewModel.noOfHeavyItems == 0 {
                                return()
                            }
                            viewModel.noOfHeavyItems -= 1
                        }, label: {
                            VStack {
                                Image(.minusButton)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 16, height: 16)
                                    .foregroundColor(.gray)
                                    .padding()
                            }
                            .frame(width: 45)
                            .background(AppColor.colorMediumGray)
                        })
                        
                        VStack {
                            Text("\(viewModel.noOfHeavyItems)")
                                .font(.system(size: 16, weight: .regular))
                                .multilineTextAlignment(.center)
                                .foregroundColor(AppColor.colorTextBlack)
                                .padding()
                        }
                        .frame(width: 45) // Set the desired width for the VStack
                        .background(.white)
                        
                        Button(action: {
                            viewModel.noOfHeavyItems += 1
                        }, label: {
                            VStack {
                                Image(.plustButton)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 16, height: 16)
                                    .foregroundColor(.gray)
                                    .padding()
                            }
                            .frame(width: 45)
                            .background(AppColor.colorTextBlack)
                        })
                    }
                    .frame(height: 40)
                    .cornerRadius(10) // Add corner radius
                    .overlay(
                        RoundedRectangle(cornerRadius: 10) // Rounded border
                            .stroke(AppColor.colorBorder, lineWidth: 1)
                    )
                    Spacer()
                }
                
            }
            .padding(.top, 8)
        }
    }
    @State private var isImagePickerPresented = false
    @State private var selectedImage: UIImage?
    
    var AddAnImageView: some View {
        VStack {
            HStack {
                VStack (alignment: .leading, spacing: 0) {
                    Text("Add an Image")
                        .font(.system(size: 16, weight: .medium))
                        .padding(.bottom, 8)
                        .multilineTextAlignment(.leading)
                        .onTapGesture {
                            isImagePickerPresented = true
                        }
                    Text("his will help us to manage the space")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(AppColor.colorGrayTextColor)
                        .multilineTextAlignment(.leading)
                        .padding(.bottom, 0)
                    ImageUploadView
                }
                Spacer()
            }
            .padding(.bottom, 16)
            DashLineView
        }
        .padding(.vertical, 16)
    }
    @State private var comment: String = ""
    
    var AdditionalCommentView: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Additional Comment")
                        .font(.system(size: 16, weight: .medium))
                        .padding(.bottom, 8)
                        .multilineTextAlignment(.leading)
                        .padding(.bottom, 4)
                    
                    // TextView (custom wrapper)
                    TextView(text: $comment)
                        .frame(height: 200)
                        .padding(8)
                        .background(Color(UIColor.white))
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.white.opacity(1), lineWidth: 1)
                        )
                }
                Spacer()
            }
            .padding(.bottom, 16)
            
            // Dashed Line
            DashLineView
                .frame(height: 1)
                .foregroundColor(.gray)
        }
    }
    
    struct TextView: UIViewRepresentable {
        @Binding var text: String
        
        func makeUIView(context: Context) -> UITextView {
            let textView = UITextView()
            textView.font = UIFont.systemFont(ofSize: 14)
            textView.isScrollEnabled = true
            textView.textColor = .black
            textView.delegate = context.coordinator
            return textView
        }
        
        func updateUIView(_ uiView: UITextView, context: Context) {
            uiView.text = text
        }
        
        func makeCoordinator() -> Coordinator {
            Coordinator(self)
        }
        
        class Coordinator: NSObject, UITextViewDelegate {
            var parent: TextView
            
            init(_ parent: TextView) {
                self.parent = parent
            }
            
            func textViewDidChange(_ textView: UITextView) {
                parent.text = textView.text
            }
        }
    }
    @State private var selectedImages: [UIImage] = []
    @State private var currentImage: UIImage?
    
    let maxDisplayImages = 2 // Maximum images to display before showing the "3+"
    
    
    var ImageUploadView: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header Text
            // Upload Section
            HStack(spacing: 16) {
                // Upload Image Button
                Button(action: {
                    isImagePickerPresented = true
                }) {
                    VStack {
                        Image(.upload)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                            .foregroundColor(.gray)
                        Text("Upload Image")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                    .frame(width: 100, height: 80)
                    .background(Color(.white))
                    .cornerRadius(12)
                }
                
                // Selected Images Preview
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(0..<selectedImages.prefix(maxDisplayImages).count, id: \.self) { index in
                            ZStack(alignment: .topTrailing) {
                                Image(uiImage: selectedImages[index])
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 80, height: 80)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                    .foregroundColor(.white)
                                
                                // Remove Button
                                Button(action: {
                                    selectedImages.remove(at: index)
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.black)
                                        .background(Color.white.opacity(1))
                                        .clipShape(Circle())
                                }
                                .offset(x: -3, y: 3)
                            }
                        }
                        
                        // If more images exist, show count badge
                        if selectedImages.count > maxDisplayImages {
                            ZStack {
                                Image(uiImage: selectedImages[maxDisplayImages])
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 80, height: 80)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                
                                // Overlay for "3+"
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.black.opacity(0.6))
                                
                                Text("\(selectedImages.count - maxDisplayImages)+")
                                    .font(.headline)
                                    .foregroundColor(.white)
                            }
                            .frame(width: 80, height: 80)
                        }
                    }
                }
            }
        }
        .padding(.top, 20)
    }
    
    var ButtonConfirmView: some View {
        VStack {
            DashLineWithShadowView
            
            Button(action: {
                // Add your action here
                viewModel.navigateToDropOffLocationView = true
            }) {
                VStack {
                    Text("Proceed to Drop-off")
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
            .disabled(!viewModel.isFormValid)
        }
        .background(.white)
    }
    
    
    
    var DateTimePickerView: some View {
        VStack {
            Spacer() // Push content to the bottom
            VStack {
                HStack {
                    Spacer() // Pushes the button to the right
                    Button {
                        viewModel.isShowDateTimePickerView = false
                        viewModel.isDateTimePickerViewPresented = false
                    } label: {
                        Text("Done")
                            .font(.headline)
                            .foregroundColor(.blue)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            .background(Color.white)
                            .cornerRadius(8)
                    }
                }
                .padding(.horizontal)
                
                DatePicker(
                    "Select Time",
                    selection: $viewModel.selectedDate,
                    displayedComponents: [viewModel.isDatePicker ? .date : .hourAndMinute]
                )
                .datePickerStyle(WheelDatePickerStyle())
                .labelsHidden()
                .frame(height: 200)
                .background(Color.white)
                .cornerRadius(10)
                .padding()
                .onChange(of: viewModel.selectedDate) { newDate in
                    let dateFormatter = DateFormatter()
                    if viewModel.isDatePicker {
                        dateFormatter.dateFormat = "dd/MM/YYYY"
                        viewModel.selectedDateString = dateFormatter.string(from: viewModel.selectedDate)
                    } else {
                        dateFormatter.dateFormat = "hh:mm a"
                        viewModel.selectedTimeString = dateFormatter.string(from: viewModel.selectedDate)
                    }
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .shadow(radius: 10)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(.white, lineWidth: 2)
            )
        }
        .background(
            Group {
                if viewModel.isDateTimePickerViewPresented {
                    Color.black.opacity(0.1).edgesIgnoringSafeArea(.all)
                } else {
                    Color.clear
                }
            }
        )
        .transition(.move(edge: .bottom))
        .animation(.easeInOut, value: viewModel.isShowDateTimePickerView)
        .onAppear() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                viewModel.isDateTimePickerViewPresented = true
            }
        }
    }
}


#Preview {
    AdditionalInformationView()
}
