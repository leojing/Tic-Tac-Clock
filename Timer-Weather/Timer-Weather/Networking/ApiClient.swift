//
//  APIClient.swift
//  WeatherDemo
//
//  Created by JINGLUO on 3/3/18.
//  Copyright © 2018 JINGLUO. All rights reserved.
//


import Foundation
import RxSwift
import Alamofire
import ObjectMapper

class APIClient: APIService {
    
    typealias CompletionHandler = (_ jsonResponse: [String: Any]?, _ error: RequestError?) -> Void
    
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
    func fetchWeatherInfo(_ config: APIConfig) -> Observable<RequestStatus> {
        return Observable<RequestStatus>.create { observable -> Disposable in
            self.networkRequest(config, completionHandler: { (json, error) in
                guard let json = json else {
                    if let error = error {
                        observable.onNext(RequestStatus.fail(error))
                    } else {
                        observable.onNext(RequestStatus.fail(RequestError(ResponseStatusCode.parseInfoFailed.rawValue, AlertMessage.parseInfoFailed)))
                    }
                    observable.onCompleted()
                    return
                }
                if let weather = Mapper<Weather>().map(JSON: json) {
                    observable.onNext(RequestStatus.success(weather))
                    observable.onCompleted()
                } else {
                    observable.onNext(RequestStatus.fail(RequestError(ResponseStatusCode.parseInfoFailed.rawValue, AlertMessage.parseInfoFailed)))
                    observable.onCompleted()
                }
            })
            return Disposables.create()
            }.share()
    }
    
    // MARK: conform to APIService protocol. For new class inherit from APIClient class, you can overwrite this function and use any other HTTP networking libraries. Like in Unit test, I create MockAPIClient which request network by load local JSON file.
    func networkRequest(_ config: APIConfig, completionHandler: @escaping CompletionHandler) {
        URLCache.shared.removeAllCachedResponses()
        
        Alamofire.request(config.getFullURLStr())
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
    fileprivate func networkResponseSuccess(_ response: DataResponse<Any>?, _ completionHandler: CompletionHandler) {
        guard let response = response else {
            return completionHandler(nil, RequestError(ResponseStatusCode.emptyData.rawValue, AlertMessage.emptyData))
        }
        
        guard let json = response.result.value as? [String: Any] else {
            print("Error: \(String(describing: response.result.error))")
            completionHandler(nil, RequestError(ResponseStatusCode.parseInfoFailed.rawValue, (response.result.error?.localizedDescription)!))
            return
        }
        
        completionHandler(json, nil)
    }
    
    // MARK: Parse response when request failure
    fileprivate func networkResponseFailure(_ error: Error, _ completionHandler: CompletionHandler) {
        completionHandler(nil, RequestError(ResponseStatusCode.parseInfoFailed.rawValue, error.localizedDescription))
    }
}

