//
//  Mission.swift
//  Moonshot
//
//  Created by Prathamesh Kowarkar on 11/08/20.
//

import Foundation

struct Mission: Codable, Identifiable {

    struct CrewRole: Codable {

        let name: String
        let role: String

    }

    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String

    var displayName: String {
        "Apollo \(id)"
    }

    var imageName: String {
        "apollo\(id)"
    }

    var formattedLaunchDate: String {
        guard let launchDate = launchDate else { return "N/A" }

        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: launchDate)
    }

    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")

    var astronautNames: String {
        crew
            .map(\.name)
            .compactMap { name in
                Self.astronauts.first {
                    $0.id == name
                }
            }
            .map(\.name)
            .joined(separator: "\n")
    }

}
