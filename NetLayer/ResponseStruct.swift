//
//  ResponseStruct.swift
//  fortests
//
//  Created by Alexey on 13.08.24.
//

public struct ResponseStruct: Decodable {
    let acessToken: String?
}

public struct StatusResponseStruct: Decodable {
    let status: String?
}
