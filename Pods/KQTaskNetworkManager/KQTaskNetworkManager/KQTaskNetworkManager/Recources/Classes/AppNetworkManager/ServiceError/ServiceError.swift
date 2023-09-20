//
//  ErrorType.swift
//  KQTaskProject
//
//  Created by KamsQue on 22/12/2022.
//

import Foundation

// MARK: - Errors

public struct ServiceError: Error, Codable {
    let httpStatus: Int
    let message: String
    let description: String?
}

public struct NetworkError: Error {
    let message: String
}

public struct UnknownParseError: Error { }



