//
//  TransactionsList.swift
//  DemoToRecruiters
//
//  Created by KamsQue on 27/01/2023.
//


import Foundation
typealias Users = [User]
  // MARK: - AppTransactionsList
struct AppTransactionsList: Codable {
  let User: [User]
}

import Foundation

// MARK: - User
struct User: Codable {
    var id: Int?
    var name, username, email: String?
    var address: Address?
    var phone, website: String?
    var company: Company?
}

// MARK: - Address
struct Address: Codable {
    var street, suite, city, zipcode: String?
    var geo: Geo?
}

// MARK: - Geo
struct Geo: Codable {
    var lat, lng: String?
}

// MARK: - Company
struct Company: Codable {
    var name, catchPhrase, bs: String?
}


