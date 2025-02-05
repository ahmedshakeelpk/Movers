//
//  ConfirmOrderViewModel.swift
//  Movers
//
//  Created by Shakeel Ahmed on 01/02/2025.
//

import Foundation

class ConfirmOrderViewModel: BaseViewModel {
    
    @Published var numberOfAddresses: [String] = []
    @Published var presentToPaymentMethodBottomSheet: Bool = false
    @Published var navigateToPaymentGatewayView: Bool = false
    
    override init() {
        super.init()
        for address in kArrayLocationsPickUp {
            self.numberOfAddresses.append(address)
        }
        for address in kArrayLocationsDropOff {
            self.numberOfAddresses.append(address)
        }
        print(self.numberOfAddresses)
        print(self.numberOfAddresses)
    }
    
    func getRandomNumber() -> Int {
        let randomNumber = Int.random(in: 50...100)
        return randomNumber
    }
    
}
