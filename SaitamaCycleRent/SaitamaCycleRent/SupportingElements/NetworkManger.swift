//
//  NetworkManger.swift
//  SaitamaCycleRent
//
//  Created by Devanshu Saini on 12/02/17.
//  Copyright © 2017 Devanshu Saini devanshu2@gmail.com. All rights reserved.
//

import Foundation


public class NetworkManger: NSObject {
    
    public var networkSession: URLSession?
    public var networkDataTask: URLSessionDataTask?
    
    public func getSharedConfiguration(_ isEphemeral: Bool) -> URLSessionConfiguration {
        let sessionConfiguration = isEphemeral ? URLSessionConfiguration.ephemeral : URLSessionConfiguration.default
        return sessionConfiguration
    }
    
    public func cancelActiveTask() {
        self.networkDataTask?.cancel()
    }
    
    public func getDefaultHeaders() -> [String: String]? {
        var headerParams: Dictionary<String, String>?
        if let accessToken = AppFactory.shared.getCurrentUserToken() {
            headerParams = [Constants.kAuthorization: accessToken]
        }
        return headerParams
    }
    
    public func postData(withParameters params:Dictionary<String , Any>, apiEndpoint apiURL: URL, withHeaderParams headerParams:[String: String]?, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) {
        var request = URLRequest(url: apiURL)
        
        if headerParams != nil {
            for (key, value) in headerParams! {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        request.httpMethod = Constants.kPost
        
        do {
            let data = try JSONSerialization.data(withJSONObject: params, options: [])
            //let json = String(data: data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
            //let newJson = "payload="+json!
            //let postData = json?.data(using: .utf8)
            //            let postData = NSMutableData(data: ((("payload="+json!) as String).data(using: String.Encoding.utf8)!))
            request.httpBody = data
        } catch {
            debugPrint(error.localizedDescription)
            completionHandler(nil, nil, error)
            return
        }
        
        if self.networkSession == nil {
            self.networkSession = URLSession(configuration: getSharedConfiguration(false))
        }
        self.networkDataTask = self.networkSession?.dataTask(with: request as URLRequest) { (data, response, error) in
            if error != nil {
                debugPrint(error!.localizedDescription)
            }
            completionHandler(data, response, error)
        }
        self.networkDataTask?.resume()
    }
    
    public func postData(withParameters params:Dictionary<String , Any>, apiEndpoint apiURL: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) {
        var headerData:[String:String] = ["Content-Type":"application/json"]
        if let defaultHeaders = getDefaultHeaders() {
            for (key, value) in defaultHeaders {
                headerData[key] = value
            }
        }
        self.postData(withParameters: params, apiEndpoint: apiURL, withHeaderParams: headerData, completionHandler: completionHandler)
    }
    
    public func getData(apiEndpoint apiURL: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) {
        var request = URLRequest(url: apiURL)
        if let defaultHeaders = getDefaultHeaders() {
            for (key, value) in defaultHeaders {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        request.httpMethod = Constants.kGet
        
        if self.networkSession == nil {
            self.networkSession = URLSession(configuration: getSharedConfiguration(false))
        }
        self.networkDataTask = self.networkSession?.dataTask(with: request as URLRequest) { (data, response, error) in
            if error != nil {
                debugPrint(error!.localizedDescription)
            }
            completionHandler(data, response, error)
        }
        self.networkDataTask?.resume()
    }

}



