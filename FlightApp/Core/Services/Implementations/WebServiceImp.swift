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
    private let _reportService: ReportService
    private let _networking = Networking()
    
    init(reportService: ReportService) {
        _reportService = reportService
    }
    
    func getRequest<T>(baseUrl: baseURL, requestUri: String, completion: @escaping (T?) -> Void) -> String where T : Decodable, T : Encodable {
        let requestId = _networking.get(baseUrl.url + requestUri) { result in
            self._handleResult(result, completion)
        }
        
        return requestId
    }
    
    func cancelRequest(_ id: String) {
        _networking.cancel(id)
    }
    
    private func _handleResult<T : Codable>(_ result: JSONResult, _ completion: (_ result: T?) -> Void ) {
        switch result {
            case .success(let response):
                do {
                    let obj = try JSONDecoder().decode(T.self, from: response.data)
                    completion(obj)
                } catch let error {
                    _sendError(error, String(describing: T.self))
                    completion(nil)
                }
            
            case .failure(let response):
                _sendError(response.error, "Fail to handle Json Result")
                completion(nil)
        }
    }
    
    private func _sendError(_ error : Error, _ obj : String) {
        _reportService.sendError(error: error, message: "Json serialization error on object: \(obj)")
    }
}



