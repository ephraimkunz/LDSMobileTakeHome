//
//  NetworkManager.swift
//  LDSMobileTakeHome
//
//  Created by Ephraim Kunz on 7/5/23.
//

import Foundation
import os


// There's a bug where @Models can't also be codable: https://developer.apple.com/forums/thread/732598
// So for now, deserialize into a separate struct.
struct NetworkIndividual: Decodable {
    enum NetworkAffiliation: String, Codable {
        case jedi = "JEDI"
        case resistance = "RESISTANCE"
        case firstOrder = "FIRST_ORDER"
        case sith = "SITH"
    }

    let id: Int
    let firstName: String
    let lastName: String
    let birthdate: Date
    let profilePicture: URL
    let forceSensitive: Bool
    let affiliation: NetworkAffiliation
}

struct NetworkIndividuals: Decodable {
    let individuals: [NetworkIndividual]
}

struct NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    private let log = Logger(subsystem: "com.ephraimkunz.LDSMobileTakeHome", category: "NetworkManager")
    
    func fetchIndividuals() async -> [Individual]? {
        guard let url = URL(string: "https://edge.ldscdn.org/mobile/interview/directory") else {
            log.error("Unable to parse URL")
            return nil
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            let networkIndividuals = try decoder.decode(NetworkIndividuals.self, from: data)
            
            return networkIndividuals.individuals.compactMap({ Individual($0) })
        } catch {
            log.error("Unable to fetch or deserialize network data: \(error)")
        }
        
        return nil
    }
}
