//
//  CredentialsValidity+Errors.swift
//  fortests
//
//  Created by Alexey on 14.08.24.
//

import Foundation

enum CredentialsValidationError: Error {
    case noData
    case status200
    case status401
    case status423
    case status500
}
