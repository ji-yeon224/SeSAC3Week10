//
//  Network.swift
//  SeSAC3Week10
//
//  Created by 김지연 on 2023/09/19.
//

import Foundation
import Alamofire

class Network {
    
    static let shared = Network()
    
    private init() { }
    
    func requestConvertible<T: Decodable>(type: T.Type, api: Router, completion: @escaping (Result<T, SeSACError>) -> Void) {
        
        
        AF.request(api).responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(_):
                    let statusCode = response.response?.statusCode ?? 500
                    guard let error = SeSACError(rawValue: statusCode) else { return }
                    completion(.failure(error))
                }
            }
        
    }
    
    func request<T: Decodable>(type: T.Type, api: UnsplashAPI, completion: @escaping (Result<T, SeSACError>) -> Void) {
        
        
        AF.request(api.endpoint, method: api.method, parameters: api.query, encoding: URLEncoding(destination: .queryString), headers: api.header)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(_):
                    let statusCode = response.response?.statusCode ?? 500
                    guard let error = SeSACError(rawValue: statusCode) else { return }
                    completion(.failure(error))
                }
            }
        
    }
    
    
}
