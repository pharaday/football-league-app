//
//  RoundResponseModel.swift
//  QPLtest
//
//  Created by Bender on 30.07.2024.
//

struct RoundsModel: Codable {
    let response: [Round]
}

struct Round: Codable {
    let name: String
}


struct MatchDetails {
    let result: String
    let date: String
}
