//
//  User.swift
//  DemoToRecruiters
//
//  Created by KamsQue on 27/01/2023.
//

import Foundation

  // MARK: - User
//struct Items : Codable {
//  var partnerDisplayName: String?
//  var alias: Company?
//  var category: Int?
//  var UserDetail: Address?
//}

// MARK: - User
public struct User: Codable {
    var id: Int?
    var name, username, email: String?
    var address: Address?
    var phone, website: String?
    var company: Company?
}
