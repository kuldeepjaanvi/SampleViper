//
//  ServiceManager.swift
//  GenericNetworkLayeriOS
//
//  Created by Yusuf Demirci on 13.04.2020.
//  Copyright © 2020 Yusuf Demirci. All rights reserved.
//

import Foundation

class ServiceManager {
    
    // MARK: - Properties
    static let shared: ServiceManager = ServiceManager()
    
    var baseURL: String = "​https://api.coincap.io/v2/"
}

// MARK: - Public Functions
extension ServiceManager {
    
    func sendRequest<T: Codable>(request: RequestModel, completion: @escaping(Swift.Result<T, ErrorModel>) -> Void) {
       
        
//        /// Comment for rest service 1
//        let data = try! Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "Response", ofType: "json")!), options: NSData.ReadingOptions.mappedIfSafe)
        /// Comment for rest service 1
        
        /// Uncomment for rest service 2
        URLSession.shared.dataTask(with: request.urlRequest()) { data, response, error in
            guard let data = data, let parsedResponse = try? JSONDecoder().decode(T.self, from: data) else {
        /// Uncomment for rest service 2
        /// Comment for rest service 3
//            guard var responseModel = try? JSONDecoder().decode(ResponseModel<T>.self, from: data) else {
//        /// Comment for rest service 3
                let error: ErrorModel = ErrorModel(ErrorKey.parsing.rawValue)

                completion(Result.failure(error))
                return
            }

            /// Uncomment for rest service 4
            var responseModel: ResponseModel<T> = .init()
            responseModel.isSuccess = true
            responseModel.data = parsedResponse as! T
            /// Uncomment for rest service 4

            responseModel.rawData = data
            responseModel.request = request

            if responseModel.isSuccess, let data = responseModel.data {
                completion(Result.success(data as! T))
            } else {
                completion(Result.failure(ErrorModel.generalError()))
            }

        /// Uncomment for rest service 5
         }.resume()
        /// Uncomment for rest service 5
    }
}
