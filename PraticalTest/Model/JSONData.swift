//
//  JSONData.swift
//  PraticalTest
//
//  Created by admin on 28/08/21.
//

import UIKit


// MARK: - Jsondata
struct Jsondata : Codable {
    var data: [PoolData]?
}

// MARK: - Datum
struct  PoolData : Codable {
    var poolName: String?
    var teams: [Team]?
}

// MARK: - Team
struct Team  : Codable {
    var rank: Int?
    var name: String?
    var matches: Matches?
    var total: Total?
}

// MARK: - Matches
struct Matches : Codable {
    var w, l: Int?
    var mr: Double?
}

// MARK: - Total
struct Total : Codable {
    var w: Int?
    var ps: Double?
    var pa :Int?
    var pr: Int?
}
