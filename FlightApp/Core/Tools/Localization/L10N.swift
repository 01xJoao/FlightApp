//
//  L10N.swift
//  FlightApp
//
//  Created by João Palma on 01/08/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import Foundation

struct L10N {
    static private var _currentLanguage: String?
    static private let _supportedLanguages: [String] = ["en", "pt"]
    static private let _defaultLanguage: String = "en"
    static private let _reportService: ReportService = DiContainer.resolve()
    
    static private var _resourceManager: [LiteralObject] = []
    static private var resourcesManager : [LiteralObject] {
        get {
            if(_resourceManager.isEmpty) {
                _setLanguage()
                _loadJsonString()
            }
            
            return _resourceManager
        }
    }
    
    static func getCurrentLanguage() -> String {
        if(_currentLanguage == nil) {
            _setLanguage()
        }
        
        return _currentLanguage!
    }
    
    static func localize(key: String) -> String {
        let value = resourcesManager.first(where: { $0.key == key })
        return value?.translated ?? ""
    }
    
    static private func _setLanguage() {
        let lang = String(Locale.preferredLanguages.first!)
        let split = lang.split(separator: "-")
        let language = String(split[0])
    
        _currentLanguage = _supportedLanguages.first(where: { $0 == language }) ?? _defaultLanguage
    }
    
    static private func _loadJsonString() {
        guard let path = Bundle.main.path(forResource: _currentLanguage, ofType: "json") else {
            _reportService.sendError(error: NSError(), message: "Can't find json file for language: \(_currentLanguage!)")
            return
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as! NSDictionary
            for (key, value) in jsonResult {
                _resourceManager.append(LiteralObject(key: key as! String, translated: value as! String))
            }
        } catch let error {
            _reportService.sendError(error: error, message: "Error loading \(_currentLanguage!).json file")
        }
    }
}
