//
//  CryptoPresenter.swift
//  Created by Apple on 31/07/21.


import Foundation

class CryptoPresenter : ViewToPresenterCryptoProtocol {
  
    // MARK: Properties
    weak var view: PresenterToViewCryptoProtocol?
    var interactor: PresenterToInteractorCryptoProtocol?
    var router: PresenterToRouterCryptoProtocol?
    
    var cryptoStrings: [CryptoModel]?
    
    func refresh() {
        
    }
  
    // MARK: Inputs from view
    func viewDidLoad() {
        print("Presenter is being notified that the View was loaded.")
        interactor?.loadCrypto()
    }
    
    func numberOfRowsInSection() -> Int {
        guard let cryptoStrings = self.cryptoStrings else {
            return 0
        }
        
        return cryptoStrings.count
    }

}

// MARK: - Outputs to view
extension CryptoPresenter: InteractorToPresenterCryptoProtocol {
    
    func fetchCryptoSuccess(Crypto: [CryptoModel]) {
        print("Presenter receives the result from Interactor after it's done its job.")
        self.cryptoStrings = Crypto
        view?.onFetchCryptoSuccess()
    }
    
    func fetchCryptoFailure(errorCode: Int) {
        print("Presenter receives the result from Interactor after it's done its job.")
        view?.onFetchCryptoFailure(error: "Couldn't fetch Crypto: \(errorCode)")
    }
    
    
    func getQuoteFailure() {
        print("Couldn't retrieve quote by index")
    }
    
}
