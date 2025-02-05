////
////  APIsName.swift
////  zabihah
////
////  Created by Shakeel Ahmed on 08/07/2024.
////
//
import Foundation

struct APIPath {
    public static let  baseUrl = "https://movers.saenainvest.com/api/v1/"
    
}
struct APIsName {
    enum name: String {
        //MARK:- API
        case register = "register"
        case login = "login"
        case forgotPassword = "forgot-password"
        
        case services = "services"
        case propertyTypes = "property-types"
        case pricing = "pricing"
        
        
        
        
        
        
        
        case photoDelete = "Restaurant/photo/{photoId}"
        case myReview = "Review/place/{placeId}/my"

        //MARK:- Config
        case userConfiguration = "Configuration"
        //MARK:- Favorite
//        case favourite = "Favorite/{placeId}"
        case favourite = "Favorite/{placeId}"
        case favouriteDelete = "Favorite/by/place/{placeId}"
        case getFavourite = "Favorite/my"
        
    }
}

