//
//  QuoteService.swift
//  VIPER-SimpsonQuotes
//
//  Created by Zafar on 1/2/20.
//  Copyright © 2020 Zafar. All rights reserved.
//


class QuoteService {
    
    static let shared = { QuoteService() }()
    
    func getQuotes(count: Int, success: @escaping (Int, [Quote]) -> (), failure: @escaping (Int) -> ()) {
        
        var quote = Quote()
        quote.quote = "hi"
        
        success(1, [quote])

        let urlString = self.configureApiCall(Endpoints.QUOTES, "count", "\(count)")
        
        APIClient.shared.getArray(urlString: urlString, success: { (code, arrayOfQuotes) in
            success(code, arrayOfQuotes)
            
        }) { (code) in
            failure(code)
        }
    }
    
    func configureApiCall(_ baseURL: String, _ parameter: String, _ value: String) -> String {
        return baseURL + "?" + parameter + "=" + value
    }
}
