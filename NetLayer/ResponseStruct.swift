//
//  ResponseStruct.swift
//  fortests
//
//  Created by Alexey on 13.08.24.
//

public struct CredentialsValidityResponseStruct: Decodable {
    let string: String?
}

public struct StatusResponseStruct: Decodable {
    let status: String?
    
}
