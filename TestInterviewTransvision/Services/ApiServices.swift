//
//  ApiServices.swift
//  TestInterviewTransvision
//
//  Created by CZ-User on 14/08/23.
//

import Foundation
import Alamofire

class ApiServices {
    private let baseUrl = UrlConstant().BASE_URL
    private let sessionManager: Session
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 120
        configuration.timeoutIntervalForResource = 120
        self.sessionManager = Session(configuration: configuration)
    }
    
    func makeRequestUrl(path: String) -> String {
        return baseUrl + path
    }
    
    func getHttp<T: Decodable>(url: String, headers: HTTPHeaders?, completion: @escaping (Result<T, Error>) -> Void) {
        sessionManager.request(url, method: .get, headers: headers)
            .validate(statusCode: 200..<505)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let data):
                    print("-----------------------RESULT BEGIN------------------------")
                    print("URL: \(url)")
                    print("Method: get")
                    print("Headers: \(headers)")
                    print("Response: \(data)")
                    print("-----------------------RESULT END--------------------------")
                    completion(.success(data))
                case .failure(let error):
                    print("-----------------------RESULT BEGIN------------------------")
                    print("URL: \(url)")
                    print("Method: get")
                    print("Headers: \(headers)")
                    print("Response: \(error)")
                    print("-----------------------RESULT END--------------------------")
                    completion(.failure(error))
                }
            }
    }
    
    func postHttp<T: Codable, P: Codable>(url: String, parameters: P?, headers: HTTPHeaders?, completion: @escaping (Result<T, Error>) -> Void) {
        
        sessionManager.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers)
            .validate(statusCode: 200..<505)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let data):
                    
                    print("-----------------------RESULT BEGIN------------------------")
                    print("URL: \(url)")
                    print("Method: post")
                    print("Headers: \(headers)")
                    print("RequestBody: \(parameters)")
                    print("Response: \(data)")
                    print("-----------------------RESULT END--------------------------")
                    completion(.success(data))
                case .failure(let error):
                    
                    print("-----------------------RESULT BEGIN------------------------")
                    print("URL: \(url)")
                    print("Method: post")
                    print("Headers: \(headers)")
                    print("RequestBody: \(parameters)")
                    print("Response: \(error)")
                    print("-----------------------RESULT END--------------------------")
                    completion(.failure(error))
                }
            }
    }
}
