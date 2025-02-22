////
////  APIs.swift
////  talkPHR
////
////  Created by Shakeel Ahmed on 3/20/21.
////
//
import Foundation
import Alamofire
import SwiftUI



var kAccessToken = ""
struct APIs {
    static var shared = APIs()
    
    func sessionManger(timeOut: Int) -> Session {
        
        //        let evaluators: [String: ServerTrustEvaluating] = [
        //            "https://bb.fmfb.pk": PublicKeysTrustEvaluator()
        //        ]
        let evaluators: [String: ServerTrustEvaluating] = [
            "https://bb.fmfb.pk": PublicKeysTrustEvaluator(
                performDefaultValidation: false,
                validateHost: false
            )
        ]
        let serverTrustManager = ServerTrustManager(
            allHostsMustBeEvaluated: false,
            evaluators: evaluators
        )
        let session = Session(serverTrustManager: serverTrustManager)
        
        return session
        
        //
        //        let serverTrustPolicies : [String: ServerTrustManager] = ["https://bb.fmfb.pk" : .pinCertificates(certificates: ServerTrustPolicy.certificates(), validateCertificateChain: true, validateHost: true), "insecure.expired-apis.com": .disableEvaluation]
        //        let networkSessionManager = Session( serverTrustPolicyManager: ServerTrustPolicyManager(policies:serverTrustPolicies))
        //        return networkSessionManager
    }
    static func load(URL: NSURL) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        let request = NSMutableURLRequest(url: URL as URL)
        request.httpMethod = "GET"
        let task = session.dataTask(with: request as URLRequest, completionHandler: { (data: Data!, response: URLResponse!, error: Error!) -> Void in
            if (error == nil) {
                // Success
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("Success: \(statusCode)")
                // This is your file-variable:
                // data
            }
            else {
                // Failure
                print("Failure: %@", error.localizedDescription);
            }
        })
        task.resume()
    }
    static func funDownloadFileViaUrl(_ urlString: String, viewController: UIViewController) {
    }
    //    static let ipAddress = UIDevice.current.ipAddress() ?? ""
    //    static let deviceInfo = UIDevice.modelName
    //    static let grantType = "password"
    //    static let deviceToken = General_Elements.shared.deviceToken
    //    //static let authToken = "bearer \(General_Elements.shared.userProfileData?.data?.accessTokenResponse?.accessToken ?? "")"
    //    static let authToken = "bearer \(Constant.kAccessToken)"
    //    static let header: HTTPHeaders = ["Content-Type": "application/json"
    //
    //    static let headerWithToken: HTTPHeaders = ["Content-Type": "application/json"
    //                               ,"device_info" : deviceInfo ,
    //                               "device_token" : deviceToken ,
    //                               "ip" : ipAddress ,
    //                               "grant_type" : grantType,
    //                               "Authorization" : authToken]
    
    
    static func json(from object:Any) -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
    }
    
    /*
     static func postAPIForFingerPrint(apiName: APIsName.name, parameters: [String: Any], apiAttribute3: [[String:Any]]?, headerWithToken: String? = nil , headers: HTTPHeaders? = nil, viewController: UIViewController? = nil, completion: @escaping(_ response: Data?, Bool, _ errorMsg: String) -> Void) {
     
     var params = [String : Any]()
     
     let stringParamters = APIs.json(from: params)
     //let postData = stringParamters!.data(using: .utf8)
     let completeUrl = APIPath.baseUrl + apiName.rawValue
     
     let url = URL(string: completeUrl)!
     let jsonData = stringParamters!.data(using: .utf8, allowLossyConversion: false)!
     
     var request = URLRequest(url: url)
     request.httpMethod = HTTPMethod.post.rawValue
     request.setValue("application/json", forHTTPHeaderField: "Accept")
     request.setValue("application/json", forHTTPHeaderField: "Content-Type")
     
     var token  = ""
     
     request.addValue(token, forHTTPHeaderField: "Authorization")
     //
     
     print("Url: \(completeUrl)")
     print("Parameters: \(parameters)")
     print("Headers: \(token)")
     
     request.httpBody = jsonData
     //print("\(APIs.json(from: parameters)))")
     if let vc = viewController {
     vc.showActivityIndicator2()
     }
     
     AF.request(request.url!, method: .post, parameters: params, encoding:JSONEncoding.default, headers: request.headers)
     .responseData { response in
     //           guard let data = response.data else { return }
     //           let json = try? JSON(data:data)
     //           if let acc = json?["Account"].string {
     //             print(acc)
     //           }
     //           if let pass = json?["Password"].string {
     //             print(pass)
     //           }
     //        }
     //
     //        AF.request(request).responseJSON { response in
     print("Response: \(response)")
     if let vc = viewController {
     vc.hideActivityIndicator2()
     }
     switch response.result {
     case .success(let json):
     let modelGetActiveLoan = try? JSONDecoder().decode(NanoLoanApplyViewController.ModelGetLoanCharges.self, from: response.data!)
     print(modelGetActiveLoan)
     
     let serverResponse = JSON(response.value!)
     
     print("Request Headers: \(String(describing: request.allHTTPHeaderFields))")
     print("Request Url: \(String(describing: request.url))")
     print("Request Parameters: \(parameters)")
     print("JSON: \(serverResponse)")
     print("JSON: \(json)")
     let str = String(decoding: response.data!, as: UTF8.self)
     print(str)
     switch response.response?.statusCode {
     case 200 :
     if serverResponse["responsecode"] == 1 {
     completion(response.data, true, "")
     }
     else {
     completion(response.data, false, serverResponse["message"].string ?? "")
     }
     break
     default :
     completion(response.data, false, serverResponse["message"].string ?? "")
     break
     }
     case .failure( _):
     var errorMessage = ""
     if let error = response.error?.localizedDescription {
     let errorArray = error.components(separatedBy: ":")
     errorMessage = errorArray.count > 1 ? errorArray[1] : error
     completion(nil, false, errorMessage)
     }
     else {
     errorMessage = response.error.debugDescription
     completion(nil, false, response.error.debugDescription)
     }
     break
     }
     }
     }
     
     */
    
    
    //    static func getAPI(apiName: APIsName.name, parameters: [String: Any]? = nil, headerWithToken: String? = nil , headers: HTTPHeaders? = nil, viewController: UIViewController? = nil, completion: @escaping(_ response: Data?, Bool, _ errorMsg: String) -> Void) {
    //
    //        let baseClass = BaseClassVC()
    //
    //        let completeUrl = APIPath.baseUrl + apiName.rawValue
    //
    //        let url = URL(string: completeUrl)!
    //
    //        var request = URLRequest(url: url)
    //        request.httpMethod = HTTPMethod.get.rawValue
    //        request.setValue("application/json", forHTTPHeaderField: "Accept")
    //        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    //
    //        var tempHeader = ""
    //        var token  = ""
    //                if apiName == .updateAccountStatus {
    //                    token = DataManager.instance.loginResponseToken ?? ""
    //                    token = DataManager.instance.accessToken ?? ""
    //                }
    //                else if headerWithToken != nil {
    //                    token = headerWithToken!
    //                }
    //                else {
    //                    token = "\(DataManager.instance.accessToken ?? "")"
    //                }
    //                request.addValue(token, forHTTPHeaderField: "Authorization")
    //
    //
    //        print("Url: \(completeUrl)")
    //        print("Parameters: \(parameters)")
    //        print("Headers: \(token)")
    //
    //        request.httpBody = jsonData
    //        print("\(APIs.json(from: parameters)))")
    //        if let vc = viewController {
    //            vc.showActivityIndicator2()
    //        }
    //
    //        AF.request(request).responseJSON { response in
    //            print("Response: \(response)")
    //            if let vc = viewController {
    //                vc.hideActivityIndicator2()
    //            }
    //            switch response.result {
    //            case .success(let json):
    //                let modelGetActiveLoan = try? JSONDecoder().decode(NanoLoanApplyViewController.ModelGetLoanCharges.self, from: response.data!)
    //                print(modelGetActiveLoan)
    //
    //                let serverResponse = JSON(response.value!)
    //
    //                print("Request Headers: \(String(describing: request.allHTTPHeaderFields))")
    //                print("Request Url: \(String(describing: request.url))")
    //                print("Request Parameters: \(parameters)")
    //                print("JSON: \(serverResponse)")
    //                print("JSON: \(json)")
    //                switch response.response?.statusCode {
    //                case 200 :
    //                    if serverResponse["responsecode"] == 1 {
    //                        completion(response.data, true, "")
    //                    }
    //                    else {
    //                        completion(response.data, false, serverResponse["message"].string ?? "")
    //                    }
    //                    break
    //                default :
    //                    completion(response.data, false, serverResponse["message"].string ?? "")
    //                    break
    //                }
    //            case .failure( _):
    //                var errorMessage = ""
    //                if let error = response.error?.localizedDescription {
    //                    let errorArray = error.components(separatedBy: ":")
    //                    errorMessage = errorArray.count > 1 ? errorArray[1] : error
    //                    completion(nil, false, errorMessage)
    //                }
    //                else {
    //                    errorMessage = response.error.debugDescription
    //                    completion(nil, false, response.error.debugDescription)
    //                }
    //                break
    //            }
    //        }
    //    }
    
    static func queryString2(_ value: String, params: [String: Any]) -> String? {
        var components = URLComponents(string: value)
        components?.queryItems = params.map { element in URLQueryItem(name: element.key, value: element.value as? String) }
        
        return components?.url?.absoluteString
    }
    static func getAPI(apiName: APIsName.name, parameters: [String: String]? = nil, isPathParameters: Bool? = false, isUrlComponent: Bool? = false, headerWithToken: String? = nil, methodType: HTTPMethod? = .get, encoding: ParameterEncoding? = JSONEncoding.default, headers: HTTPHeaders? = nil, viewController: UIViewController? = nil, completion: @escaping(_ response: Data?, Bool, _ errorMsg: String, _ statusCode: Int?) -> Void?) {
        
        let completeUrl = APIPath.baseUrl + apiName.rawValue
        let baseURL = completeUrl
        
        var queryParams = [String: String]()
        if let parameter = parameters {
            queryParams = parameter
        }
        
        // Create URL components
        var urlComponents = URLComponents(string: baseURL)!
        
        var path = baseURL
        if isPathParameters ?? false {
            for (key, value) in queryParams {
                path = path.replacingOccurrences(of: "{\(key)}", with: value)
            }
            // Append the modified path to the base URL
            //            urlComponents.path = path
            urlComponents = URLComponents(string: path)!
        }
        else if isUrlComponent ?? false {
            // Add the query items to the URL components
            urlComponents.queryItems = queryParams.map {
                URLQueryItem(name: $0.key, value: $0.value)
            }
        }
        
        // Get the final URL with the query string
        guard let url = urlComponents.url else {
            fatalError("Invalid URL")
        }
        
        // Create a URL request
        var request = URLRequest(url: url)
        if methodType == .delete {
            request.httpMethod = "DELETE"
        }
        else if methodType == .post {
            request.httpMethod = "POST"
        }
        else if methodType == .get {
            request.httpMethod = "GET"
        }
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.timeoutInterval = 30 // 50 secs

        if kAccessToken != "" {
            let authToken = "bearer \(kAccessToken)"
            request.addValue(authToken, forHTTPHeaderField: "Authorization")
        }
        
        if let vc = viewController {
            //            vc.showActivityIndicator2()
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            // Hide activity indicator (if applicable)
            if let vc = viewController {
                DispatchQueue.main.async {
                    //                    vc.hideActivityIndicator2()
                }
            }
            self.printResponseJson(data: data)
            // Print the response
            if let httpResponse = response as? HTTPURLResponse {
                print("Response: \(httpResponse)")
                
                // Handle HTTP status code
                switch httpResponse.statusCode {
                case 200:
                    // Successful response
                    do {
                        if let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                            print("Response JSON: \(jsonResponse)")
                            // Call the completion handler with the response data
                            completion(data, true, "", httpResponse.statusCode)
                        }
                    } catch let jsonError {
                        print("Failed to decode JSON: \(jsonError.localizedDescription)")
                        // Call the completion handler with failure
                        completion(nil, true, jsonError.localizedDescription, httpResponse.statusCode)
                    }
                    
                default:
                    // Handle other HTTP status codes
                    var errorMessage = "Unexpected error"
                    if let error = error?.localizedDescription {
                        let errorArray = error.components(separatedBy: ":")
                        errorMessage = errorArray.count > 1 ? errorArray[1] : error
                    }
                    print("Error: \(errorMessage)")
                    completion(nil, false, errorMessage, httpResponse.statusCode)
                }
            } else {
                // No HTTP response
                print("No valid HTTP response")
                completion(nil, false, "No valid HTTP response", nil)
            }
            
            // Handle network error
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(nil, false, error.localizedDescription, nil)
                return
            }
        }
        
        // Start the data task
        task.resume()
    }
    
    static func postAPI(apiName: APIsName.name, parameters: [String: Any]? = nil, headerWithToken: String? = nil, methodType: HTTPMethod? = .post, encoding: ParameterEncoding? = JSONEncoding.default, headers: HTTPHeaders? = nil, viewController: UIViewController? = nil, isLoading: Bool? = true, completion: @escaping(_ response: Data?, Bool, _ errorMsg: String, _ statusCode: Int?) -> Void?) {
        
        //        let stringParamters = APIs.json(from: params)
        //let postData = stringParamters!.data(using: .utf8)
        
        let completeUrl = APIPath.baseUrl + apiName.rawValue
        let url = URL(string: completeUrl)!
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        //        request.setValue("application/json", forHTTPHeaderField: "Accept")
//        request.setValue("*/*", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        //        request.setValue("charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 30 // 50 secs
        
        //        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        if kAccessToken != ""  {
            let authToken = "bearer \(kAccessToken)"
            request.addValue(authToken, forHTTPHeaderField: "Authorization")
        }
        
        
        print("Url: \(completeUrl)")
        print("Parameters: \(String(describing: parameters ?? nil))")
        print("Headers: \(kAccessToken)")
        
        let parameters = parameters
        
        //        request.httpBody = jsonData
        //print("\(APIs.json(from: parameters)))")
        if let vc = viewController {
            //            vc.showActivityIndicator2()
        }
        if isLoading! {
            kLoadingState.isLoading = true
        }
        
        AF.request(request.url!, method: methodType ?? .post, parameters: parameters, encoding:encoding ?? JSONEncoding.default, headers: request.headers)
            .responseData { response in
                //           guard let data = response.data else { return }
                //           let json = try? JSON(data:data)
                //           if let acc = json?["Account"].string {
                //             print(acc)
                //           }
                //           if let pass = json?["Password"].string {
                //             print(pass)
                //           }
                //        }
                if isLoading! {
                    // Hide the loading indicator
                    kLoadingState.isLoading = false
                }
                print("Response: \(response)")
                if let vc = viewController {
                    //                vc.hideActivityIndicator2()
                }
                
                var responseMessage = ""
                if let jsonObject = dataToJsonString(data: response.data ?? Data()) {
                    print("API Response jsonObject: \(jsonObject)")
                    print("jsonResponse: \(jsonObject)")
                    responseMessage = jsonObject["message"] as? String ?? ""
                }
                if let jsonString = response.data?.prettyPrintedJSONString {
                    print("API Response jsonObject PrettyPrintedJSONString: \(jsonString)")
                    print("jsonResponse: \(jsonString)")
                }
                
                switch response.response?.statusCode {
                case 200 :
                    switch response.result {
                    case .success(let json):
                        completion(response.data, true, "", response.response?.statusCode)
                    case .failure( _):
                        completion(response.data, true, "response code is 200", response.response?.statusCode)
                        break
                    }
                    break
                default :
                    var errorMessage = ""
                    if let error = response.error?.localizedDescription {
                        let errorArray = error.components(separatedBy: ":")
                        errorMessage = errorArray.count > 1 ? errorArray[1] : error
                        completion(response.data, false, errorMessage, response.response?.statusCode)
                    }
                    else {
                        errorMessage = response.error.debugDescription
                        completion(response.data, false, response.error.debugDescription, response.response?.statusCode)
                    }
                    break
                }
                return()
                
                
                switch response.result {
                case .success(let json):
                    print("Request Headers: \(String(describing: request.allHTTPHeaderFields))")
                    print("Request Url: \(String(describing: request.url))")
                    print("Request Parameters: \(parameters)")
                    //                print("JSON: \(serverResponse)")
                    print("JSON: \(json)")
                    switch response.response?.statusCode {
                    case 200 :
                        completion(response.data, true, "", response.response?.statusCode)
                        break
                    default :
                        completion(response.data, false, responseMessage, response.response?.statusCode)
                        break
                    }
                case .failure( _):
                    var errorMessage = ""
                    if let error = response.error?.localizedDescription {
                        let errorArray = error.components(separatedBy: ":")
                        errorMessage = errorArray.count > 1 ? errorArray[1] : error
                        completion(nil, false, errorMessage, response.response?.statusCode)
                    }
                    else {
                        errorMessage = response.error.debugDescription
                        completion(nil, false, response.error.debugDescription, response.response?.statusCode)
                    }
                    break
                }
            }
    }
    
    
    static func postAPIWithPathParameters(apiName: APIsName.name, parameters: [String: String], headerWithToken: String? = nil, methodType: HTTPMethod? = .post, encoding: ParameterEncoding? = JSONEncoding.default, headers: HTTPHeaders? = nil, viewController: UIViewController? = nil, completion: @escaping(_ response: Data?, Bool, _ errorMsg: String, _ statusCode: Int?) -> Void?) {
        
        var completeUrl = APIPath.baseUrl + apiName.rawValue
        
        for (key, value) in parameters {
            completeUrl = completeUrl.replacingOccurrences(of: "{\(key)}", with: value)
        }
        // Append the modified path to the base URL
        //            urlComponents.path = path
        
        let url = URL(string: completeUrl)!
        
        var request = URLRequest(url: url,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        request.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            // Hide activity indicator (if applicable)
            if let vc = viewController {
                DispatchQueue.main.async {
                    //                    vc.hideActivityIndicator2()
                }
            }
            
            // Print the response
            if let httpResponse = response as? HTTPURLResponse {
                print("Response: \(httpResponse)")
                
                // Handle HTTP status code
                switch httpResponse.statusCode {
                case 200:
                    // Successful response
                    do {
                        if let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                            print("Response JSON: \(jsonResponse)")
                            // Call the completion handler with the response data
                            completion(data, true, "", httpResponse.statusCode)
                        }
                    } catch let jsonError {
                        print("Failed to decode JSON: \(jsonError.localizedDescription)")
                        // Call the completion handler with failure
                        completion(nil, true, jsonError.localizedDescription, httpResponse.statusCode)
                    }
                    
                default:
                    // Handle other HTTP status codes
                    var errorMessage = "Unexpected error"
                    if let error = error?.localizedDescription {
                        let errorArray = error.components(separatedBy: ":")
                        errorMessage = errorArray.count > 1 ? errorArray[1] : error
                    }
                    print("Error: \(errorMessage)")
                    completion(nil, false, errorMessage, httpResponse.statusCode)
                }
            } else {
                // No HTTP response
                print("No valid HTTP response")
                completion(nil, false, "No valid HTTP response", nil)
            }
            
            // Handle network error
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(nil, false, error.localizedDescription, nil)
                return
            }
        }
        
        task.resume()
    }
    
    static func deleteAPI(apiName: String, parameters: [String: Any]? = nil, headerWithToken: String? = nil, methodType: HTTPMethod? = .post, encoding: ParameterEncoding? = JSONEncoding.default, headers: HTTPHeaders? = nil, viewController: UIViewController? = nil, completion: @escaping(_ response: Data?, Bool, _ errorMsg: String, _ statusCode: Int?) -> Void) {
        
        //        let stringParamters = APIs.json(from: params)
        //let postData = stringParamters!.data(using: .utf8)
        
        var completeUrl = APIPath.baseUrl + apiName
        
        let url = URL(string: completeUrl)!
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        //        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("*/*", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        if kAccessToken != "" {
            let authToken = "bearer \(kAccessToken)"
            request.addValue(authToken, forHTTPHeaderField: "Authorization")
        }
        
        
        print("Url: \(completeUrl)")
        print("Parameters: \(String(describing: parameters ?? nil))")
        print("Headers: \(kAccessToken)")
        
        //        request.httpBody = jsonData
        //print("\(APIs.json(from: parameters)))")
        if let vc = viewController {
            //            vc.showActivityIndicator2()
        }
        
        AF.request(request.url!, method: methodType ?? .post, parameters: parameters, encoding:encoding ?? JSONEncoding.default, headers: request.headers)
            .responseData { response in
                //           guard let data = response.data else { return }
                //           let json = try? JSON(data:data)
                //           if let acc = json?["Account"].string {
                //             print(acc)
                //           }
                //           if let pass = json?["Password"].string {
                //             print(pass)
                //           }
                //        }
                //
                print("Response: \(response)")
                if let vc = viewController {
                    DispatchQueue.main.async {
                        //                    vc.hideActivityIndicator2()
                    }
                }
                
                var responseMessage = ""
                if let jsonObject = dataToJsonString(data: response.data ?? Data()) {
                    print("API Response jsonObject: \(jsonObject)")
                    print("jsonResponse: \(jsonObject)")
                    responseMessage = jsonObject["message"] as? String ?? ""
                }
                if let jsonString = response.data?.prettyPrintedJSONString {
                    print("API Response jsonObject PrettyPrintedJSONString: \(jsonString)")
                    print("jsonResponse: \(jsonString)")
                }
                
                switch response.result {
                case .success(let json):
                    print("Request Headers: \(String(describing: request.allHTTPHeaderFields))")
                    print("Request Url: \(String(describing: request.url))")
                    print("Request Parameters: \(parameters)")
                    //                print("JSON: \(serverResponse)")
                    print("JSON: \(json)")
                    switch response.response?.statusCode {
                    case 200 :
                        completion(response.data, true, "", response.response?.statusCode)
                        break
                    default :
                        completion(response.data, false, responseMessage, response.response?.statusCode)
                        break
                    }
                case .failure( _):
                    var errorMessage = ""
                    if let error = response.error?.localizedDescription {
                        let errorArray = error.components(separatedBy: ":")
                        errorMessage = errorArray.count > 1 ? errorArray[1] : error
                        completion(nil, false, errorMessage, response.response?.statusCode)
                    }
                    else {
                        errorMessage = response.error.debugDescription
                        completion(nil, false, response.error.debugDescription, response.response?.statusCode)
                    }
                    break
                }
            }
    }
    
    static func postAPI2(apiName: APIsName.name, parameters: [String: Any], headerWithToken: String? = nil, methodType: HTTPMethod? = .post, headers: HTTPHeaders? = nil, viewController: UIViewController? = nil, completion: @escaping(_ response: Data?, Bool, _ errorMsg: String) -> Void) {
        
        //        let stringParamters = APIs.json(from: params)
        //let postData = stringParamters!.data(using: .utf8)
        
        let completeUrl = APIPath.baseUrl + apiName.rawValue
        
        let url = URL(string: completeUrl)!
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        //        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("*/*", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let authToken = "bearer \(kAccessToken)"
        
        
        //        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        var tempHeader = ""
        var token  = ""
        
        request.addValue(authToken, forHTTPHeaderField: "Authorization")
        //
        
        print("Url: \(completeUrl)")
        print("Parameters: \(parameters)")
        print("Headers: \(token)")
        
        //        request.httpBody = jsonData
        //print("\(APIs.json(from: parameters)))")
        if let vc = viewController {
            //            vc.showActivityIndicator2()
        }
        
        AF.request(request.url!, method: methodType!, parameters: parameters, encoding:URLEncoding.default, headers: request.headers)
            .responseData { response in
                //           guard let data = response.data else { return }
                //           let json = try? JSON(data:data)
                //           if let acc = json?["Account"].string {
                //             print(acc)
                //           }
                //           if let pass = json?["Password"].string {
                //             print(pass)
                //           }
                //        }
                //
                print("Response: \(response)")
                if let vc = viewController {
                    //                vc.hideActivityIndicator2()
                }
                
                var responseMessage = ""
                if let jsonObject = dataToJsonString(data: response.data ?? Data()) {
                    print("API Response jsonObject: \(jsonObject)")
                    print("jsonResponse: \(jsonObject)")
                    responseMessage = jsonObject["message"] as? String ?? ""
                }
                if let jsonString = response.data?.prettyPrintedJSONString {
                    print("API Response jsonObject PrettyPrintedJSONString: \(jsonString)")
                    print("jsonResponse: \(jsonString)")
                }
                
                switch response.result {
                case .success(let json):
                    print("Request Headers: \(String(describing: request.allHTTPHeaderFields))")
                    print("Request Url: \(String(describing: request.url))")
                    print("Request Parameters: \(parameters)")
                    //                print("JSON: \(serverResponse)")
                    print("JSON: \(json)")
                    switch response.response?.statusCode {
                    case 200 :
                        completion(response.data, true, "")
                        break
                    default :
                        completion(response.data, false, responseMessage)
                        break
                    }
                case .failure( _):
                    var errorMessage = ""
                    if let error = response.error?.localizedDescription {
                        let errorArray = error.components(separatedBy: ":")
                        errorMessage = errorArray.count > 1 ? errorArray[1] : error
                        completion(nil, false, errorMessage)
                    }
                    else {
                        errorMessage = response.error.debugDescription
                        completion(nil, false, response.error.debugDescription)
                    }
                    break
                }
            }
    }
    
    static func generateCurrentTimeStamp() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy_MM_dd_hh_mm_ss"
        return (formatter.string(from: Date()) as NSString) as String
    }
    
    static func uploadImage(apiName: APIsName.name, imagesArray: [UIImage], imageParameter: String, parameter: [String: Any], requestType: String? = "POST", viewController: UIViewController? = nil, completion: @escaping(_ response: Data?, Bool, _ errorMsg: String, _ statusCode: Int?) -> Void) {
        let completeUrl = APIPath.baseUrl + apiName.rawValue
        guard let url = URL(string: completeUrl) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = requestType
        
        let authToken = "bearer \(kAccessToken)"
        request.addValue(authToken, forHTTPHeaderField: "Authorization")
        
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        // Convert the image to Data
        //        guard let imageData = image.jpegData(compressionQuality: 1) else { return }
        
        // Create the multipart body
        var body = Data()
        
        // Add any additional fields (optional)
        let parameters = parameter
        // Append parameters
        for (key, value) in parameters {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(value)\r\n".data(using: .utf8)!)
        }
        
        for value in (parameters["DeleteImages"] as? [String] ?? []) {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\("DeleteImages")\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(value)\r\n".data(using: .utf8)!)
        }
        
        // Append images
        for (index, image) in imagesArray.enumerated() {
            let imageData = image.jpegData(compressionQuality: 0.7)!
            let filename = "\(APIs.generateCurrentTimeStamp())\(index)." + "jpg"
            let mimeType = "image/jpeg"
            
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(imageParameter)\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: \(mimeType)\r\n\r\n".data(using: .utf8)!)
            body.append(imageData)
            body.append("\r\n".data(using: .utf8)!)
        }
        
        // Close boundary
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        request.httpBody = body
        
        if let vc = viewController {
            //            vc.showActivityIndicator2()
        }
        // Send the request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let vc = viewController {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    //                    vc.hideActivityIndicator2()
                }
            }
            if let error = error {
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
                print("Error: \(error.localizedDescription)")
                completion(nil, false, error.localizedDescription, statusCode)
                return
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                print("Upload successful")
                if let jsonResponse = String(data: data!, encoding: String.Encoding.utf8) {
                    print("JSON String: \(jsonResponse)")
                }
                
                completion(data, false, "", 200)
                
            } else {
                print("Upload failed")
            }
        }
        
        task.resume()
    }
    //    static func uploadFile<T: Codable>(apiName: APIsName.name, fileData:Data, fileName:String, parameters: [String: AnyObject], viewController: UIViewController? = nil, modelType: T.Type, completion: @escaping(_ T: Codable?, Bool, _ errorMsg: String) -> Void) {
    //        //        params to send additional data, for eg. AccessToken or userUserId
    //        let completeUrl = APIPath.baseUrl + apiName.rawValue
    //        let parameterJsonString = parameters.toJSONString()
    //
    //
    //        let stringParamters = APIs.json(from: paramstemp)
    //
    //        let params = ["data": stringParamters]
    //        print(params)
    //
    //        let postData = stringParamters!.data(using: .utf8)
    //        let url = URL(string: completeUrl)!
    //        let jsonData = stringParamters!.data(using: .utf8, allowLossyConversion: false)!
    //
    //        var request = URLRequest(url: url)
    //        request.httpMethod = HTTPMethod.post.rawValue
    //        request.setValue("application/json", forHTTPHeaderField: "Accept")
    //        request.setValue("multipart/form-data", forHTTPHeaderField: "Content-Type")
    //
    //        var token = DataManager.instance.accessToken ?? ""
    //        request.addValue(token, forHTTPHeaderField: "Authorization")
    //
    //        let headers: HTTPHeaders = [
    //            "Authorization": "\(token)", // in case you need authorization header
    //            "Content-type": "multipart/form-data"
    //        ]
    //
    //        print("Url: \(completeUrl)")
    //        print("Parameters: \(parameters)")
    //        print("Headers: \(token)")
    //
    //        request.httpBody = jsonData
    //        print("\(APIs.json(from: parameters)))")
    //        if let vc = viewController {
    //            vc.showActivityIndicator2()
    //        }
    //
    //        AF.upload(multipartFormData: { multiPart in
    //            multiPart.append(fileData,
    //                             withName: "file",
    //                             fileName: "\(fileName)",
    //                             mimeType: "image/jpeg/jpg/png")
    //
    //            for (key,keyValue) in params{
    //                if let keyData = keyValue!.data(using: .utf8){
    //                    multiPart.append(keyData, withName: key)
    //                }
    //            }
    //        }, to: completeUrl, method: .post, headers: headers).responseDecodable(of: T.self) { apiResponse in
    //                .responseData { apiResponse in
    //                    if let vc = viewController {
    //                        vc.hideActivityIndicator2()
    //                    }
    //
    //                    switch apiResponse.result{
    //                    case .success(_):
    //                        let apiDictionary = apiResponse.value as? [String:Any]
    //                        print("apiResponse --- \(apiDictionary)")
    //                        print("apiResponse --- \(apiResponse)")
    //                        completion(apiResponse.value, true, "")
    //                    case .failure(_):
    //                        print("got an error")
    //                        completion(apiResponse.value, false, "error in model")
    //                    }
    //                }
    //        }
    //    }
    
    
    static func dataToJsonString(data: Data) -> [String : Any]? {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
            return json
        } catch {
            print("errorMsg")
        }
        return ["error" : "errorMsg"]
    }
    
    
    static func decodeDataToObject<T: Codable>(data : Data?) throws -> T? {
        let decoder = JSONDecoder()
        if let data = data {
            do {
                let decodedObject = try decoder.decode(T.self, from: data)
                return decodedObject
            }  catch let DecodingError.dataCorrupted(context) {
                print(context)
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print("Decoding error: \(error)")
                throw error
            }
        }
        
        return nil
    }
    
    
    
    /*
     
     //Working Code with URLSession Request
     static func downloadFileFromURLSessionRequest(URL: NSURL) {
     let sessionConfig = URLSessionConfiguration.default
     let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
     let request = NSMutableURLRequest(url: URL as URL)
     request.httpMethod = "GET"
     let task = session.dataTask(with: request as URLRequest, completionHandler: { (data: Data!, response: URLResponse!, error: Error!) -> Void in
     if (error == nil) {
     // Success
     let statusCode = (response as! HTTPURLResponse).statusCode
     print("Success: \(statusCode)")
     
     // This is your file-variable:
     // data
     }
     else {
     // Failure
     print("Failure: %@", error.localizedDescription);
     }
     })
     task.resume()
     }
     */
    
    
    
    func isValidEmail(testStr:String) -> Bool {
        
        //        print("validate emilId: \(testStr)")
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        let result = emailTest.evaluate(with: testStr)
        
        return result
        
    }
    static func printResponseJson(data: Data?) {
        if let data = data {
            do {
                // Attempt to deserialize the JSON response
                if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    // Print the JSON response in a human-readable format
                    if let jsonData = try? JSONSerialization.data(withJSONObject: jsonResponse, options: .prettyPrinted) {
                        if let jsonString = String(data: jsonData, encoding: .utf8) {
                            print("Response JSON: \(jsonString)")
                        } else {
                            print("Failed to convert JSON data to string")
                        }
                    } else {
                        print("Failed to convert JSON object to pretty-printed data")
                    }
                } else {
                    print("Invalid JSON structure")
                }
            } catch let jsonError {
                print("Failed to decode JSON: \(jsonError.localizedDescription)")
                // Call the completion handler with failure
            }
        } else {
            print("No data received.")
        }
    }
}
extension Dictionary {
    var jsonData: Data? {
        return try? JSONSerialization.data(withJSONObject: self, options: [.prettyPrinted])
    }
    
    func toJSONString() -> String? {
        if let jsonData = jsonData {
            let jsonString = String(data: jsonData, encoding: .utf8)
            return jsonString
        }
        
        return nil
    }
}

extension Data {
    var prettyPrintedJSONString: NSString? {
        guard let jsonObject = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: jsonObject,
                                                     options: [.prettyPrinted]),
              let prettyJSON = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else {
            return nil
        }
        
        return prettyJSON
    }
    func jsonToString(json: AnyObject){
        do {
            let data1 =  try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted) // first of all convert json to the data
            let convertedString = String(data: data1, encoding: .utf8) // the data will be converted to the string
            print(convertedString) // <-- here is ur string
            
        } catch let myJSONError {
            print(myJSONError)
        }
    }
}


func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}

func getLogFileURL() -> URL {
    return getDocumentsDirectory().appendingPathComponent("Zabihah/appForTesting_log.txt")
}

func writeLog(_ message: String) {
    let logFileURL = getLogFileURL()
    
    let logMessage = "\(Date()): \(message)\n"
    
    do {
        if FileManager.default.fileExists(atPath: logFileURL.path) {
            // Append to the existing file
            let fileHandle = try FileHandle(forWritingTo: logFileURL)
            fileHandle.seekToEndOfFile()
            if let data = logMessage.data(using: .utf8) {
                fileHandle.write(data)
            }
            fileHandle.closeFile()
        } else {
            // Create a new file and write to it
            try logMessage.write(to: logFileURL, atomically: true, encoding: .utf8)
        }
        print("File written successfully to: \(logFileURL.path)")
    } catch {
        print("Error writing to file: \(error.localizedDescription)")
    }
}
