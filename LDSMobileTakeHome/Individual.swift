//
//  Individual.swift
//  LDSMobileTakeHome
//
//  Created by Ephraim Kunz on 7/5/23.
//

import Foundation
import SwiftData
import SwiftUI

@Model
final class Individual {
    // Make this backed by an Int to work around https://developer.apple.com/forums/thread/731538.
    enum Affiliation: Int, Codable {
        case jedi
        case resistance
        case firstOrder
        case sith
        
        init(_ networkAffiliation: NetworkIndividual.NetworkAffiliation) {
            switch networkAffiliation {
            case .jedi:
                self = .jedi
            case .resistance:
                self = .resistance
            case .firstOrder:
                self = .firstOrder
            case .sith:
                self = .sith
            }
        }
        
        var displayName: String {
            switch self {
            case .jedi:
                "Jedi"
            case .resistance:
                "Resistance"
            case .firstOrder:
                "First Order"
            case .sith:
                "Sith"
            }
        }
        
        var image: Image {
            switch self {
            case .jedi:
                Image(.jedi)
            case .resistance:
                Image(.resistance)
            case .firstOrder:
                Image(.firstOrder)
            case .sith:
                Image(.sith)
            }
        }
    }

    let id: Int
    let firstName: String
    let lastName: String
    let birthdate: Date
    let profilePicture: URL
    let forceSensitive: Bool
    let affiliation: Affiliation
    
    init(_ networkIndividual: NetworkIndividual) {
        self.id = networkIndividual.id
        self.firstName = networkIndividual.firstName
        self.lastName = networkIndividual.lastName
        self.birthdate = networkIndividual.birthdate
        self.profilePicture = networkIndividual.profilePicture
        self.forceSensitive = networkIndividual.forceSensitive
        self.affiliation = Affiliation(networkIndividual.affiliation)
    }
    
    var fullNameText: Text {
        Text("\(self.firstName) \(self.lastName)", comment: "Full name format. First %@ is first name, seconds %@ is last name")
    }
}
