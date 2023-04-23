//
//  Modles.swift
//  NYPNav
//
//  Created by Prakhar Trivedi on 23/4/23.
//

import Foundation

struct Module: Codable, Identifiable {
    var id = UUID()
    var moduleCode: String
    var name: String
    var tutorName: String
    var tutorNumber: String
    var addData: [String: String]
    
    var completeModName: String {
        moduleCode.uppercased() + " " + name.uppercased()
    }
}

class AppState: ObservableObject {
    @Published var modules: [Module] {
        didSet {
            print("Updates made to modules data; saving to plist...")
            AppState.saveModulesToFile(modules: modules)
        }
    }
    
    init() {
        // load modules either from plist or from default modules
        if let loadedModules = AppState.loadModulesFromFile() {
            modules = loadedModules
        } else {
            modules = DefaultModules.load()
        }
    }
    
    static func saveModulesToFile(modules: [Module]) {
        let plistName = "Data"
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentsDirectory.appendingPathComponent(plistName).appendingPathExtension("plist")
        
        let propertyListEncoder = PropertyListEncoder()
        let encodedModules = try? propertyListEncoder.encode(modules)
        
        try? encodedModules?.write(to: archiveURL, options: .noFileProtection)
    }
    
    static func loadModulesFromFile() -> [Module]? {
        let plistName = "Data"
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentsDirectory.appendingPathComponent(plistName).appendingPathExtension("plist")
        
        let propertyListDecoder = PropertyListDecoder()
        
        guard let retrievedModulesData = try? Data(contentsOf: archiveURL) else { return nil }
        guard let decodedModules = try? propertyListDecoder.decode(Array<Module>.self, from: retrievedModulesData) else { return nil }
        return decodedModules
    }
}
