//
//  WebServiceImp.swift
//  FlightApp
//
//  Created by João Palma on 01/08/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import Foundation
import Networking

class WebServiceImp : WebService {
    private let _networking = Networking()
    
    func getRequest<T>(baseUrl: baseURL, requestUri: String, completion: @escaping (T?) -> Void) -> String where T : Decodable, T : Encodable {
        let requestId = _networking.get(baseUrl.url + requestUri) { result in
            self._handleResult(result, completion)
        }
        
        return requestId
    }
    
    func cancelRequest(_ id: String) {
    }
    
    func _handleResult<T : Codable>(_ result: JSONResult, _ completion: (_ result: T?) -> Void ) {
        switch result {
            case .success(let response):
                do {
                    let obj = try JSONDecoder().decode(T.self, from: response.data)
                    completion(obj)
                } catch let error {
                    completion(nil)
                    //_reportService.sendError(error: error, message: "Json serialization didn't worked for \(T.self) object with data \(response.dictionaryBody["data"]!)")
                }
            
            case .failure(let response):
                let errorCode = response.error.code
                print(errorCode)
                completion(nil)
        }
    }
}



