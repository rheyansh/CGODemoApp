//
//  ServiceHelper.swift
//  CGODemoApp
//
//  Created by rajkumar.sharma on 5/10/18.
//  Copyright © 2018 rajkumar.sharma. All rights reserved.
//

import UIKit

//@@@@@@@@@@@@@@@@@@@@@ Helper constants @@@@@@@@@@@@@@@@@@@@@@@@@@
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

//@@ Staging URL

let webApiBaseURL = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/"

let timeoutInterval:Double = 45

enum loadingIndicatorType: CGFloat {
    
    case iLoader  = 0 // interactive loader => showing indicator + user interaction on UI will be enable
    case withoutLoader  = 2 // Actually no loader will be loaded => hiding indicator + user interaction on UI will be disable
}

enum MethodType: CGFloat {
    case get  = 0
    case post  = 1
    case put  = 2
    case delete  = 3
    case patch  = 4
}

class ServiceHelper: NSObject {
    
    //MARK:- Public Functions >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    
    class func request(params: [String: Any],
                       method: MethodType,
                       apiName: String,
                       completionBlock: ((AnyObject?, Error?, Int)->())?) {
        
        //>>>>>>>>>>> create request
        let url = requestURL(method, apiName: apiName, parameterDict: params)
        
        var request = URLRequest(url: url)
        request.httpMethod = methodName(method)
        request.timeoutInterval = timeoutInterval
        
        let jsonData = body(method, parameterDict: params)
        request.httpBody = jsonData

        if method == .post  || method == .put || method == .patch {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        Debug.log("\n\n Request URL  >>>>>>\(url)")
        Debug.log("\n\n Request Header >>>>>> \n\(request.allHTTPHeaderFields.debugDescription)")
        Debug.log("Content-Length >>> \(String (jsonData.count))")
        Debug.log("\n\n Request Parameters >>>>>>\n\(params.toJsonString())")
        //Debug.log("\n\n Request Body  >>>>>>\(request.HTTPBody)")
        
        request.perform(hudType: .iLoader) { (responseObject: AnyObject?, error: Error?, httpResponse: HTTPURLResponse?) in
            
            guard let block = completionBlock else {
                return
            }
            
            DispatchQueue.main.async(execute: {
                guard let httpResponse = httpResponse else {
                    block(responseObject, error, 9999)
                    return
                }
                block(responseObject, error, httpResponse.statusCode)
            })
        }
    }
    
    //MARK:- Private Functions >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    
    class fileprivate func methodName(_ method: MethodType)-> String {
        
        switch method {
        case .get: return "GET"
        case .post: return "POST"
        case .delete: return "DELETE"
        case .put: return "PUT"
        case .patch: return "PATCH"

        }
    }
    
    class fileprivate func body(_ method: MethodType, parameterDict: [String: Any]) -> Data {
        
        // Create json with your parameters
        switch method {
        case .post: fallthrough
        case .patch: fallthrough
        case .put: return parameterDict.toData()
        case .get: fallthrough

        default: return Data()
        }
    }
    
    class fileprivate func requestURL(_ method: MethodType, apiName: String, parameterDict: [String: Any]) -> URL {
        let urlString = webApiBaseURL + apiName
        
        switch method {
        case .get:
            return getURL(apiName, parameterDict: parameterDict)
            
        case .post: fallthrough
        case .put: fallthrough
        case .patch: fallthrough

        default: return URL(string: urlString)!
        }
    }
    
    class fileprivate func getURL(_ apiName: String, parameterDict: [String: Any]) -> URL {
        
        var urlString = webApiBaseURL + apiName
        var isFirst = true
        
        for key in parameterDict.keys {
            
            let object = parameterDict[key]
            
            if object is NSArray {
                
                let array = object as! NSArray
                for eachObject in array {
                    var appendedStr = "&"
                    if (isFirst == true) {
                        appendedStr = "?"
                    }
                    urlString += appendedStr + (key) + "=" + (eachObject as! String)
                    isFirst = false
                }
                
            } else {
                var appendedStr = "&"
                if (isFirst == true) {
                    appendedStr = "?"
                }
                let parameterStr = parameterDict[key] as! String
                urlString += appendedStr + (key) + "=" + parameterStr
            }
            
            isFirst = false
        }
        
        let strUrl = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        return URL(string:strUrl!)!
    }
    
    class func hideAllHuds(_ status: Bool, type: loadingIndicatorType) {
        
        if (type == .withoutLoader) {
            return
        }
        
        DispatchQueue.main.async(execute: {
            var hud = MBProgressHUD(for: APPDELEGATE.window!)
            if hud == nil {
                hud = MBProgressHUD.showAdded(to: APPDELEGATE.window!, animated: true)
            }
            hud?.bezelView.layer.cornerRadius = 8.0
            hud?.bezelView.color = UIColor(red: 222/225.0, green: 222/225.0, blue: 222/225.0, alpha: 222/225.0)
            hud?.margin = 12
            
            if (status == false) {
                if (type  == .withoutLoader) {
                   // do nothing
                } else {
                    hud?.show(animated: true)
                }
            } else {
                hud?.hide(animated: true, afterDelay: 0.3)
            }
        })
    }
}

extension URLRequest  {
    
    func perform(hudType: loadingIndicatorType, completionBlock: @escaping (AnyObject?, Error?, HTTPURLResponse?) -> Void) -> Void {
        
        //hud_type = hudType
        if (APPDELEGATE.isReachable == false) {
            AlertController.alert(title: "Connection Error!", message: "Internet connection appears to be offline. Please check your internet connection.")
            return
        }
        
        ServiceHelper.hideAllHuds(false, type: hudType)
        
        let config = URLSessionConfiguration.default // Session Configuration
        let session = URLSession(configuration: config) // Load configuration into Session
        
        let task = session.dataTask(with: self, completionHandler: {
            (data, response, error) in
            
            ServiceHelper.hideAllHuds(true, type: hudType)

            if let error = error {
                Debug.log("\n\n error  >>>>>>\n\(error)")
                completionBlock(nil, error, nil)
            } else {
            
                let httpResponse = response as! HTTPURLResponse
                let responseCode = httpResponse.statusCode
                
                //let responseHeaderDict = httpResponse.allHeaderFields
                //Debug.log("\n\n Response Header >>>>>> \n\(responseHeaderDict.debugDescription)")
                Debug.log("Response Code : \(responseCode))")

                let responseStrInISOLatin = String(data: data!, encoding: String.Encoding.isoLatin1)
                guard let modifiedDataInUTF8Format = responseStrInISOLatin?.data(using: String.Encoding.utf8) else {
                    print("could not convert data to UTF-8 format")
                    return
                }
                
                //Debug.log("Response String : \n \(responseStrInISOLatin)")
                
                do {
                    let result = try JSONSerialization.jsonObject(with: modifiedDataInUTF8Format)
                      Debug.log("\n\n result  >>>>>>\n\(result)")
                    completionBlock(result as AnyObject?, nil, httpResponse)
                } catch {
                    
                    Debug.log("\n\n error in JSONSerialization")
                    Debug.log("\n\n error  >>>>>>\n\(error)")
                    completionBlock(nil, error, httpResponse)
                }
            }
        })
        
        task.resume()
    }
}

