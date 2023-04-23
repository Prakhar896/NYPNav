//
//  Content.swift
//  NYPNav
//
//  Created by Prakhar Trivedi on 23/4/23.
//

import Foundation

struct DefaultModules {
    static let cmath = Module(
        moduleCode: "IT1151",
        name: "Computing Mathematics",
        tutorName: "Mr Tan Keng Chuah",
        tutorNumber: "NIL",
        addData: [:]
    )
    
    static let webDev = Module(
        moduleCode: "IT1152",
        name: "Web Development",
        tutorName: "NIL",
        tutorNumber: "NIL",
        addData: [:]
    )
    
    static let infSec = Module(
        moduleCode: "IT1153",
        name: "Infocomm Security",
        tutorName: "NIL",
        tutorNumber: "NIL",
        addData: [
            "NYP Email": "adrian_see@nyp.edu.sg"
        ]
    )
    
    static let prgEssentials = Module(
        moduleCode: "IT1154",
        name: "Programming Essentials",
        tutorName: "Mr Bobby Liu",
        tutorNumber: "+65 9826 8857",
        addData: [
            "NYP Email": "liu_jianrong@nyp.edu.sg"
        ]
    )
    
    static let lawEthics = Module(
        moduleCode: "IT1155",
        name: "Law and Ethics of IT",
        tutorName: "Mr Adrian See",
        tutorNumber: "+65 6550 1805",
        addData: [
            "NYP Email": "adrian_see@nyp.edu.sg"
        ]
    )
    
    static func load() -> [Module] {
        return [
            DefaultModules.cmath,
            DefaultModules.webDev,
            DefaultModules.infSec,
            DefaultModules.prgEssentials,
            DefaultModules.lawEthics
        ]
    }
}
