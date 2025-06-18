//
//  PrayerSettings.swift
//  MasjidConnect
//
//  Created by Nedim Delic on 6/18/25.
//

import Foundation

enum CalculationMethod: Int, CaseIterable, Identifiable {
    case jafari = 0
    case uiskarachi = 1
    case isna = 2
    case mwl = 3
    case mecca = 4
    case egas = 5
    case igut = 7
    case gulf = 8
    case kuwait = 9
    case qatar = 10
    case muis = 11
    case uoif = 12
    case dib = 13
    case samr = 14
    case jakim = 17
    case tunisia = 18
    case algeria = 19
    case kemenag = 20
    case morocco = 21
    case cil = 22
    case maiah = 23
    
    var id: Int { self.rawValue }
    
    var displayName: String {
        switch self {
        case .jafari: return "Jafari / Shia Ithna-Ashari"
        case .uiskarachi: return "University of Islamic Sciences, Karachi"
        case .isna: return "Islamic Society of North America"
        case .mwl: return "Muslim World League"
        case .mecca: return "Umm Al-Qura University, Makkah"
        case .egas: return "Egyptian General Authority of Survey"
        case .igut: return "Institute of Geophysics, University of Tehran"
        case .gulf: return "Gulf Region"
        case .kuwait: return "Kuwait"
        case .qatar: return "Qatar"
        case .muis: return "Majlis Ugama Islam Singapura, Singapore"
        case .uoif: return "Union Organization Islamic de France"
        case .dib: return "Diyanet İşleri Başkanlığı, Turkey"
        case .samr: return "Spiritual Administration of Muslims of Russia"
        case .jakim: return "Jabatan Kemajuan Islam Malaysia"
        case .tunisia: return "Tunisia"
        case .algeria: return "Algeria"
        case .kemenag: return "KEMENAG - Kementerian Agama Republik Indonesia"
        case .morocco: return "Morocco"
        case .cil: return "Comunidade Islamica de Lisboa"
        case .maiah: return "Ministry of Awqaf, Islamic Affairs and Holy Places, Jordan"
        }
    }
}

enum MadhabSchool: Int, CaseIterable, Identifiable {
    case shafi = 0
    case hanafi = 1
    
    var id: Int { self.rawValue }
    
    var displayName: String {
        switch self {
        case .shafi: return "Shafi'i"
        case .hanafi: return "Hanafi"
        }
    }
}
