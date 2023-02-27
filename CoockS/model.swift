//
//  model.swift
//  CoockS
//
//  Created by BigSynt on 10.09.2022.
//  Copyright © 2022 BigSynt. All rights reserved.
//

import Foundation

// MARK: - MusicLove
struct MusicLove: Codable {
    let result: [Music]

    enum CodingKeys: String, CodingKey {
        case result = "result_1"
    }
}

// MARK: - Result1
struct Music: Codable {
    let id, createdAt: Int
    let nameTrack: String
    let urlTrack: String
    let uuid: String
    let nameArtists: [NameArtist]
    let trackLogo: TrackLogo

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case nameTrack, urlTrack
        case uuid = "UUID"
        case nameArtists, trackLogo
    }
}

// MARK: - NameArtist
struct NameArtist: Codable {
    var nameArtist: String
}

// MARK: - TrackLogo
struct TrackLogo: Codable {
    let path, name, type: String
    let size: Int
    let mime: String
    let meta: Meta
    let url: String
}

// MARK: - Meta
struct Meta: Codable {
    let width, height: Int
}

