//
//  CryptoInteractor.swift
//  MyCryptoApp
//  Created by Apple on 31/07/21.
//

import Foundation

class CryptoInteractor: PresenterToInteractorCryptoProtocol {
    
    func retrieveQuote(at index: Int) {
        
    }
    
    
    // MARK: Properties
    weak var presenter: InteractorToPresenterCryptoProtocol?
    var Crypto: [CryptoModel]?
    
    func loadCrypto() {
        
        serviceCall()
        let context = ["user": ""]
        let timer = Timer(timeInterval: 10.0, target: self, selector: #selector(serviceCall), userInfo: context, repeats: true)
        RunLoop.current.add(timer, forMode: .common)
        
      
        }
        
    @objc func serviceCall()  {
         
        let queryLimit = URLQueryItem(name: "limit", value: "20")
        let queryItemOffset = URLQueryItem(name: "offset", value: "0")

        let request = RequestModel(url: .topHeadlines,querryItems: [queryLimit , queryItemOffset])
            NetworkRequestMain.postAction(request, ResponseModel.self) {[weak self] result in
                switch result {
                case .success(let model):
                    self?.presenter?.fetchCryptoSuccess(Crypto: model.data!)
                case .failure( _): break
                   // self?.presenter?.errorDispay(articles: error)
                }
            }
    }
    


}
