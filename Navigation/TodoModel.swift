//
//  TodoModel.swift
//  Navigation
//
//  Created by v.milchakova on 10.04.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

struct TodoModel: Decodable {
    var userId: Int
    var id: Int
    var title: String
    var completed: Bool
    
    private enum CodingKeys: CodingKey {
        case userId
        case id
        case title
        case completed
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        userId = try container.decode(Int.self, forKey: .userId)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        completed = try container.decode(Bool.self, forKey: .completed)
    }
}
