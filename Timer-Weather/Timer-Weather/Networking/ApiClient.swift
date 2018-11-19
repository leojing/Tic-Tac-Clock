//
//  APIClient.swift
//  WeatherDemo
//
//  Created by JINGLUO on 3/3/18.
//  Copyright © 2018 JINGLUO. All rights reserved.
//


import Foundation
import Alamofire

class APIClient: APIService {
    
    typealias CompletionHandler = (_ jsonResponse: Data?, _ error: RequestError?) -> Void
    
    enum AlertMessage {
        static let parseInfoFailed = "Parse remote data failed. Please try again."
        static let emptyData = "Response data is empty. Please try again."
    }
    
    enum ResponseStatusCode: String {
        case parseInfoFailed = "0"
        case emptyData = "1"
        case noNetwork = "2"
    }
    
    
    // MARK: start a fetch data request and return RxSwift Observable object which can be observed in ViewModel
    func fetchWeatherInfo(_ config: APIConfig, _ completionHandler: @escaping ((_ status: RequestStatus) -> Void)) {
        networkRequest(config, completionHandler: { (data, error) in
            guard let data = data else {
                if let error = error {
                    return completionHandler(RequestStatus.fail(error))
                } else {
                    return completionHandler(RequestStatus.fail(RequestError(ResponseStatusCode.parseInfoFailed.rawValue, AlertMessage.parseInfoFailed)))
                }
            }
            do {
                let decoder = JSONDecoder()
                let weather = try decoder.decode([Weather].self, from: data)
                return completionHandler(RequestStatus.success(weather))
            } catch {
                return completionHandler(RequestStatus.fail(RequestError(ResponseStatusCode.parseInfoFailed.rawValue, AlertMessage.parseInfoFailed)))
            }
        })
    }
    
    // MARK: conform to APIService protocol. For new class inherit from APIClient class, you can overwrite this function and use any other HTTP networking libraries. Like in Unit test, I create MockAPIClient which request network by load local JSON file.
    func networkRequest(_ config: APIConfig, completionHandler: @escaping CompletionHandler) {
        URLCache.shared.removeAllCachedResponses()
        
        var mutableURLRequest = URLRequest(url: URL(string: config.getFullURLStr())!)
        mutableURLRequest.httpMethod = "GET"
        mutableURLRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        mutableURLRequest.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData

        Alamofire.request(mutableURLRequest)
            .responseJSON(queue: DispatchQueue.global(qos: .background), options: .allowFragments) { response in
                switch response.result {
                case .success(_):
                    self.networkResponseSuccess(response, completionHandler)
                    
                case .failure(let error):
                    self.networkResponseFailure(error, completionHandler)
                }
        }
    }
    
    // MARK: Parse response when request success
    private func networkResponseSuccess(_ response: DataResponse<Any>?, _ completionHandler: CompletionHandler) {
        guard let response = response else {
            return completionHandler(nil, RequestError(ResponseStatusCode.emptyData.rawValue, AlertMessage.emptyData))
        }
        
        guard let data = response.data as? Data else {
            print("Error: \(String(describing: response.result.error))")
            completionHandler(nil, RequestError(ResponseStatusCode.parseInfoFailed.rawValue, (response.result.error?.localizedDescription)!))
            return
        }
        
        completionHandler(data, nil)
    }
    
    // MARK: Parse response when request failure
    private func networkResponseFailure(_ error: Error, _ completionHandler: CompletionHandler) {
        completionHandler(nil, RequestError(ResponseStatusCode.parseInfoFailed.rawValue, error.localizedDescription))
    }
}



