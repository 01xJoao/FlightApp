//
//  WebService.swift
//  FlightApp
//
//  Created by João Palma on 01/08/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

protocol WebService {
    func getRequest<T : Codable>(baseUrl: baseURL, requestUri: String, completion: @escaping (_ result: T?) -> Void) -> String
    func cancelRequest(_ id: String)
}
