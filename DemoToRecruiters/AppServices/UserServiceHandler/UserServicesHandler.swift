//
//  ApiServicesHandler.swift
//  DemoToRecruiters
//
//  Created by KamsQue on 27/01/2023.
//

import Foundation
import KQTaskNetworkManager

protocol UserApiHandlerProtocol {
  func makeRequest(from parameters: [String: Any]) -> Request
  func parseResponse(data: Data) throws -> [User]?
}

struct UserApiHandler: APIHandler , UserApiHandlerProtocol {
  
  func makeRequest(from parameters: [String: Any]) -> Request {
      // prepare url
    let url = URL(string:Path.Users().getUsersList(""))
    var urlRequest = URLRequest(url: url!)
      // set http method type
    urlRequest.httpMethod = HTTPMethod.get.rawValue
    do {
      urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
    } catch let error {
      print(error.localizedDescription)
    }
      //HTTP Headers
      // set body params
    set(parameters, urlRequest: &urlRequest)
      // prepares request (sets header params, any additional configurations)
    let request = Request(urlRequest: urlRequest, requestBuilder: DefaultRequest())
    
    return request
  }
  
    func parseResponse(data: Data) throws -> [User]? {
        let jsonDecoder = JSONDecoder()
        
        do {
            return try jsonDecoder.decode([User].self, from: data)
        } catch {
            throw error
        }
    }

}

extension JSONDecoder.DateDecodingStrategy {
  static func custom(_ formatterForKey: @escaping (CodingKey) throws -> DateFormatter?) -> JSONDecoder.DateDecodingStrategy {
    return .custom({ (decoder) -> Date in
      guard let codingKey = decoder.codingPath.last else {
        throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "No Coding Path Found"))
      }
      
      guard let container = try? decoder.singleValueContainer(),
            let text = try? container.decode(String.self) else {
        throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Could not decode date text"))
      }
      
      guard let dateFormatter = try formatterForKey(codingKey) else {
        throw DecodingError.dataCorruptedError(in: container, debugDescription: "No date formatter for date text")
      }
      
      if let date = dateFormatter.date(from: text) {
        return date
      } else {
        throw DecodingError.dataCorruptedError(in: container, debugDescription: "Cannot decode date string \(text)")
      }
    })
  }
}
