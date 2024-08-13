//
//  Requests.swift
//  fortests
//
//  Created by Alexey on 13.08.24.
//

import Foundation

public enum HTTPMethod {
    case get
    case post

    var string: String {
        switch self {
            case .get: return "GET"
            case .post: return "POST"
        }
    }
}

public struct HTTPRequestHeader {
    public var key: String
    public var value: String

    public init(key: String, value: String) {
        self.key = key
        self.value = value
    }
}

public struct NetworkingParams {
    var httpMethod: HTTPMethod
    var url: URL?
    var query: [URLQueryItem]
    var headers: [HTTPRequestHeader]
    var request: Codable?
    var body: String?

    public init(
        httpMethod: HTTPMethod,
        url: URL?,
        query: [URLQueryItem] = [],
        values: [HTTPRequestHeader] = [],
        request: Codable? = nil,
        body: String? = nil
    ) {
        self.httpMethod = httpMethod
        self.url = url
        self.query = query
        self.headers = values
        self.request = request
        self.body = body
    }
}

public protocol NetworkingProtocol: AnyObject {

    func execute<Response: Decodable>(
        params: NetworkingParams
    ) async throws -> Response
}

public final class MainNetworkingService: NSObject, NetworkingProtocol {

    public enum NetworkingError: LocalizedError {
        case networkingAgentNil
        case badURL

        public var errorDescription: String? {
            switch self {
                case .badURL:
                    return String(localized: "NetworkingError.badURL")

                case .networkingAgentNil:
                    return String(localized: "NetworkingError.networkingAgentNil")
            }
        }
    }

    public func execute<Response>(
        params: NetworkingParams
    ) async throws -> Response where Response: Decodable {

        //let url = params.url
        let query = params.query
        let httpMethod = params.httpMethod
        let values = params.headers
        let stringBody = params.body
        let encoder = JSONEncoder()
        let dataBody = try encoder.encode(stringBody)
        
        guard let url = params.url else {
            throw NetworkingError.badURL
        }

        var urlBuilder = URLComponents(string: url.absoluteString)

        query.forEach {
            urlBuilder?.queryItems?.append($0)
        }

        guard let updatedURL = urlBuilder?.url else {
            throw NetworkingError.badURL
        }

        var newURLRequest = URLRequest(url: updatedURL)
        newURLRequest.httpMethod = httpMethod.string
        values.forEach {
            newURLRequest.addValue($0.value, forHTTPHeaderField: $0.key)
        }

        newURLRequest.httpBody = dataBody

        let (data, response) = try await URLSession.shared.data(for: newURLRequest)

        return try JSONDecoder().decode(Response.self, from: data)
    }

    public override init () {}
}
