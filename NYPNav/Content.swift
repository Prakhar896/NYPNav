//
//  Content.swift
//  NYPNav
//
//  Created by Prakhar Trivedi on 23/4/23.
//

import Foundation

struct DefaultModules {
    static let pem = Module(
        moduleCode: "PEM IT2301",
        name: "DIT Personal Mentor Contact Time",
        tutorName: "Mr Heng Yiak Por",
        tutorNumber: "+65 6550 1806",
        addData: [
            "NYP Email": "heng_yiak_por@nyp.edu.sg"
        ]
    )
    
    static let cmath = Module(
        moduleCode: "IT1151",
        name: "Computing Mathematics",
        tutorName: "Mr Tham Kok Kay",
        tutorNumber: "+65 6550 1724",
        addData: [
            "NYP Email": "tham_kok_kay@nyp.edu.sg"
        ]
    )
    
    static let webDev = Module(
        moduleCode: "IT1152",
        name: "Web Development",
        tutorName: "Mr Jason Chung",
        tutorNumber: "+65 6550 1712",
        addData: [
            "NYP Email": "jason_chung@nyp.edu.sg"
        ]
    )
    
    static let infSec = Module(
        moduleCode: "IT1153",
        name: "Infocomm Security",
        tutorName: "Mr Tan Choon Kok",
        tutorNumber: "+65 6550 1628",
        addData: [
            "NYP Email": "tan_choon_kok@nyp.edu.sg"
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
    
    static let iAndE = Module(
        moduleCode: "IT1156",
        name: "Fundamentals of Innovation and Enterprise",
        tutorName: "Mr Mark Lim",
        tutorNumber: "+65 6550 1817",
        addData: [
            "NYP Email": "mark_limkt@myaccount.nyp.edu.sg"
        ]
    )
    
    static let understandingSG = Module(
        moduleCode: "ITX106",
        name: "Understanding Singapore",
        tutorName: "Mr Winston Lum",
        tutorNumber: "+65 6550 1963",
        addData: [
            "NYP Email": "winston_lum@nyp.edu.sg"
        ]
    )
    
    static let effectiveComms = Module(
        moduleCode: "ITF111",
        name: "Effective Communication Skills",
        tutorName: "Mr Ricky Puru",
        tutorNumber: "NIL",
        addData: [
            "NYP Email": "purushotman_suppiah@myaccount.nyp.edu.sg"
        ]
    )
    
    
    static let blankModule = Module(
        moduleCode: "",
        name: "Select A Module",
        tutorName: "NIL",
        tutorNumber: "NIL",
        addData: [:]
    )
    
    static func load() -> [Module] {
        return [
            DefaultModules.blankModule,
            DefaultModules.pem,
            DefaultModules.cmath,
            DefaultModules.webDev,
            DefaultModules.infSec,
            DefaultModules.prgEssentials,
            DefaultModules.lawEthics,
            DefaultModules.iAndE,
            DefaultModules.understandingSG,
            DefaultModules.effectiveComms
        ]
    }
}
