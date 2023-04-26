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
    @Published var eServiceLinks: [EServiceLink] {
        didSet {
            print("Updates made to e-service links; saving to UserDefaults")
            AppState.saveLinksToDefaults(links: eServiceLinks)
        }
    }
    
    init() {
        // load modules either from plist or from default modules
        if let loadedModules = AppState.loadModulesFromFile() {
            modules = loadedModules
        } else {
            modules = DefaultModules.load()
        }
        
        eServiceLinks = AppState.loadLinks()
    }
    
    static func saveLinksToDefaults(links: [EServiceLink]) {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(links) {
            UserDefaults.standard.set(data, forKey: "EServiceList")
        }
    }
    
    static func loadLinks() -> [EServiceLink] {
        let decoder = JSONDecoder()
        if let savedLinks = UserDefaults.standard.data(forKey: "EServiceList") {
            if let links = try? decoder.decode([EServiceLink].self, from: savedLinks) {
                return links
            }
        }
        
        return EServiceLink.loadDefaultLinks()
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

class AdditionalParameter: ObservableObject {
    var id = UUID()
    @Published var paramName: String
    @Published var paramValue: String
    
    init(paramName: String, paramValue: String) {
        self.paramName = paramName
        self.paramValue = paramValue
    }
}

class AddParams: ObservableObject {
    @Published var params: [AdditionalParameter]
    
    init(params: [AdditionalParameter]) {
        self.params = params
    }
}

enum ManageModuleMode {
    case new, edit
}

struct EServiceLink: Identifiable, Codable {
    var id = UUID().uuidString
    var name: String
    var url: String
    
    static func loadDefaultLinks() -> [EServiceLink] {
        return [
            EServiceLink(name: "NYP Website", url: "https://nyp.edu.sg"),
            EServiceLink(name: "MyNYP Portal", url: "https://mynypportal.nyp.edu.sg/en/dashboard.html"),
            EServiceLink(name: "NYP LMS", url: "http://nyplms.polite.edu.sg")
        ]
    }
}
