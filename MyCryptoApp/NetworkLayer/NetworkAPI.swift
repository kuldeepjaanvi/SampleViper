//
//  NetworkAPI.swift

import Foundation

enum RequestType: String {
    case GET
    case POST
}

enum NetworkError: Error {
    case domainError
    case decodingError
    case noDataError
}

enum StatusCode : String {
    case successful = "ok"
}

struct RequestModel  {
    let url : URLScheema
    let typeObj : RequestType = .GET
    var querryItems : [URLQueryItem]?
    let httpBody : [String:Any]? = nil
    let param : [String:Any]? = nil
    var httpHeaderField : [String : String]? = nil
}

enum URLScheema : String   {
    case topHeadlines = "https://api.coincap.io/v2/assets?limit=20&offset=0"
}

extension URLScheema : CustomStringConvertible {
    var description: String {
        return self.rawValue
    }
}


class NetworkRequestMain {
    
    static func postAction<T:Decodable>(_ requestModel:RequestModel,
                                        _ modelType: T.Type,
                                        completion: @escaping (Result<T,NetworkError>) -> Void) {
        let session = URLSession.shared
        var serviceUrl = URLComponents(string: requestModel.url.description)
        serviceUrl?.queryItems =  requestModel.querryItems
        guard let componentURL = serviceUrl?.url else { return }
        var request = URLRequest(url: componentURL)
        request.httpMethod = requestModel.typeObj.rawValue
        request.allHTTPHeaderFields =  requestModel.httpHeaderField
        
        if let parameterDictionary = requestModel.httpBody  {
            guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
                return
            }
            request.httpBody = httpBody
        }
        
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let jsonDecoder = JSONDecoder()
                    let responseModel = try jsonDecoder.decode(T.self, from: data)
                    completion(.success(responseModel))
                } catch {
                    //type of failure
                    completion(.failure(.decodingError))
                    print(error)
                }
            } else {
                completion(.failure(.noDataError))
            }
        }.resume()
    }
    
}
