//
//  HomeViewModel.swift
//  Movers
//
//  Created by Shakeel Ahmed on 23/01/2025.
//

import Foundation

class HomeViewModel: BaseViewModel {
    
    @Published var isPresentToServiceSelectionBottomSheetView: Bool = false
    @Published var navigateToMovingNPickingView: Bool = false
    var selectedService: HomeViewModel.ModelResponseServicesData!
    
    override init() {
        super.init()
        self.getServices()
    }
    
    var modelResponseServices: HomeViewModel.ModelResponseServices? {
        didSet {
            
        }
    }
    
    func getServices() {
        APIs.getAPI(apiName: .services) { responseData, success, errorMsg, statusCode  in
            if success { }
            
            do {
                let model: ApiResponse<ModelResponseServices>? = try APIs.decodeDataToObject(data: responseData)
                if model?.status == 200 {
                    self.modelResponseServices = model?.data
                }
                else {
                    print("getServices (\(type(of: self))): \(model?.message ?? "")")
//                    showPopup(title: "Error!", message: model?.message ?? "", imageIcon: .errorIcon) {
//                        
//                    }
                }
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
            }
        }
    }
}
