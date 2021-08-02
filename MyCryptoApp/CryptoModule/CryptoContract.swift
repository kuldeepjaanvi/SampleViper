//
//  CryptoContract.swift
//  Created by Apple on 31/07/21.
//
//

import UIKit


// MARK: View Output (Presenter -> View)
protocol PresenterToViewCryptoProtocol:class {
   
    func onFetchCryptoSuccess()
    func onFetchCryptoFailure(error: String)
    
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterCryptoProtocol: class {
    
    var view: PresenterToViewCryptoProtocol? { get set }
    var interactor: PresenterToInteractorCryptoProtocol? { get set }
    var router: PresenterToRouterCryptoProtocol? { get set }
    
    var cryptoStrings: [CryptoModel]? { get set }
    
    func viewDidLoad()
    
    func refresh()
    
    
    func numberOfRowsInSection() -> Int
    
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorCryptoProtocol {
    
    var presenter: InteractorToPresenterCryptoProtocol? { get set }
    
    func loadCrypto()
    func retrieveQuote(at index: Int)
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterCryptoProtocol: class {
    
    func fetchCryptoSuccess(Crypto: [CryptoModel])
    func fetchCryptoFailure(errorCode: Int)
    
    func getQuoteFailure()
    
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterCryptoProtocol: class {
    
    static func createModule() -> UINavigationController
    
    //func pushToQuoteDetail(on view: PresenterToViewCryptoProtocol, with quote: Quote)
}
