//
//  CredentialsValidationMicroservice.swift
//  fortests
//
//  Created by Alexey on 14.08.24.
//

import Foundation

public protocol CredentialsMicroserviceProtocol {
    func checkCredentialsValidity(email: String, password: String) async -> Void
}

extension MainNetworkingService: CredentialsMicroserviceProtocol {

    public func checkCredentialsValidity(email: String, password: String) async -> Void {
            var queryComponenets = [URLQueryItem]()
            var requestValues = [HTTPRequestHeader]()
            queryComponenets.append(URLQueryItem(name: "firstName", value: "Saphon"))
            queryComponenets.append(URLQueryItem(name: "lastName", value: "Saphonov"))

            let bodyString = "{\n\"email\": \"\(email)\",\n\"password\": \"\(password)\"\n}"
            requestValues.append(HTTPRequestHeader(key: "Content-Type", value: "application/json" ))
            requestValues.append(HTTPRequestHeader(key: "accept", value: "*/*" ))

            let requestParams = NetworkingParams(httpMethod: .post,
                                                 url: URL(string: "https://api-dev.mibank2.andersenlab.dev/uas/api/user/signup"),
                                                 query: queryComponenets, values: requestValues, request: nil, body: bodyString)
    
        do {
        let _: CredentialsValidityResponseStruct = try await execute(params: requestParams)
            // call method in presenter to manipulate data
        } catch CredentialsValidationError.noData {
            print("No data came")
        } catch {
            print("Some other error")
        }
    }
}

