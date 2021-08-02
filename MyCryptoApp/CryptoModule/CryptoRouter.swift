//
//  CryptoRouter.swift
//  
// Created by Apple on 31/07/21.


import UIKit
import CryptoMarketSP

class CryptoRouter: PresenterToRouterCryptoProtocol {
    
    
    // MARK: Static methods
    static func createModule() -> UINavigationController {
        
        print("CryptoRouter creates the Crypto module.")
        let viewController =  CryptoViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.barTintColor = UIColor.black
        navigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        let presenter: ViewToPresenterCryptoProtocol & InteractorToPresenterCryptoProtocol = CryptoPresenter()
        viewController.presenter = presenter
        viewController.presenter?.router = CryptoRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = CryptoInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        return navigationController
    }
    
}
