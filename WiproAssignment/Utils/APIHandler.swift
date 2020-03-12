//
//  APIHandler.swift
//  WiproAssignment
//
//  Created by chiranjeevi macharla on 12/03/20.
//  Copyright © 2020 chiranjeevi macharla. All rights reserved.
//

import UIKit
import Reachability


public class APIHandler: NSObject {
  static public let networkmanager = APIHandler()
    public override init() {

       }
    public func callWebServiceGet (urlString: String, parameter: Dictionary<String, String>?,successBlock: @escaping ([String:Any]) ->Void,  failureBlock: @escaping (String) ->Void) {

                let reachability = try! Reachability()
                  if reachability.connection != .unavailable {
           #if DEBUG
           print("url String ---->",urlString)
               #endif
                    var request: URLRequest = URLRequest(url: URL(string: StaticString.baseUrl)!)
                    request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
                    request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
                    request.httpMethod = "GET"
                    // Request the data
                    let session: URLSession = URLSession.shared
                    let task = session.dataTask(with: request) { (data, response, error) in
                       // print(data!.count)
                        // Did we get an error?
                        guard error == nil else {
                            print(error!)
                            
                            DispatchQueue.main.async{
                                failureBlock(StaticString.somethingWentWrong)
                            }
                            
                            return
                        }
                        
                        guard let json = data else {
                            print("No data")
                            return
                        }
                        
                        guard json.count != 0 else {
                            print("Zero bytes of data")
                            return
                        }
                        print(String(decoding: json, as: UTF8.self))
                        if let dict = self.convertToDictionary(text: String(decoding: json, as: UTF8.self)){
                        
                            successBlock(dict)
                        }
                    }
                    task.resume()
              
                   
           }
                  else{
                    failureBlock(StaticString.noInternet)
        }
        
        do {
            try reachability.startNotifier()
            } catch {
        print("Unable to start notifier")
    }
   
       
    }
    
    private func convertToDictionary(text: String) -> [String: Any]? {
           if let data = text.data(using: .utf8) {
               do {
                   return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
               } catch {
                   print(error.localizedDescription)
               }
           }
           return nil
       }
}
