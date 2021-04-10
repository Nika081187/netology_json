//
//  PlanetModel.swift
//  Navigation
//
//  Created by v.milchakova on 10.04.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

struct PlanetModel: Decodable {
    
        var name: String
        var rotation_period: String
        var orbital_period: String
        var diameter: String
        var climate: String
        var gravity: String
        var terrain: String
        var surface_water: String
        var population: String
        var residents: [String]
        var films: [String]
        var created: String
        var edited: String
        var url: String
    
    private enum CodingKeys: CodingKey {
        case name
        case rotation_period
        case orbital_period
        case diameter
        case climate
        case gravity
        case terrain
        case surface_water
        case population
        case residents
        case films
        case created
        case edited
        case url
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        rotation_period = try container.decode(String.self, forKey: .rotation_period)
        orbital_period = try container.decode(String.self, forKey: .orbital_period)
        diameter = try container.decode(String.self, forKey: .diameter)
        climate = try container.decode(String.self, forKey: .climate)
        gravity = try container.decode(String.self, forKey: .gravity)
        terrain = try container.decode(String.self, forKey: .terrain)
        surface_water = try container.decode(String.self, forKey: .surface_water)
        population = try container.decode(String.self, forKey: .population)
        residents = try container.decode([String].self, forKey: .residents)
        films = try container.decode([String].self, forKey: .films)
        created = try container.decode(String.self, forKey: .created)
        edited = try container.decode(String.self, forKey: .edited)
        url = try container.decode(String.self, forKey: .url)
    }
}
