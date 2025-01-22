import Foundation

protocol DecodeSerializerProtocol {
  associatedtype ResponseModel: Decodable
}

extension DecodeSerializerProtocol {
  static func transform(data: Data) throws -> ResponseModel {
    let decoder = JSONDecoder()
    return try decoder.decode(ResponseModel.self, from: data)
  }

  static func transform(json: [String: Any]) throws -> ResponseModel {
    let data = try JSONSerialization.data(withJSONObject: json)
    let decoder = JSONDecoder()
    return try decoder.decode(ResponseModel.self, from: data)
  }
}

