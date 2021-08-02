//
//  CryptoViewController.swift
//  Created by Apple on 31/07/21.

import UIKit
import CryptoMarketSP
class CryptoViewController: UIViewController {
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        presenter?.viewDidLoad()
    }
    
     lazy var tableView: UITableView = {
         let tableView = UITableView()
        tableView.rowHeight = 70
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorColor = UIColor.gray
        return tableView
     }()
     
    // MARK: - Actions
    @objc func refresh() {
        presenter?.refresh()
    }

    // MARK: - Properties
    var presenter: ViewToPresenterCryptoProtocol?
    

   

    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()
    
}

extension CryptoViewController: PresenterToViewCryptoProtocol{
    
    func onFetchCryptoSuccess() {
        print("View receives the response from Presenter and updates itself.")
        DispatchQueue.main.async {
            
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()

        }
    }
    
    func onFetchCryptoFailure(error: String) {
        print("View receives the response from Presenter with error: \(error)")
        self.refreshControl.endRefreshing()
    }
    
}

// MARK: - UITableView Delegate & Data Source
extension CryptoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.`numberOfRowsInSection`() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CryptoCell", for: indexPath) as! CryptoCell
        //TODO : This logic can be moved to presentor class. 
        let cryptoObj = presenter?.cryptoStrings![indexPath.row]
        cell.numberLb.text = cryptoObj?.rank
        cell.cryptoNam.text = cryptoObj?.name
        
        let changePer = Double((cryptoObj?.changePercent24Hr)!)
        let withTruncatedPer = Decimal(changePer!).truncation(by: 2)
        cell.priceChangeLb.text = "\(withTruncatedPer)"+"%"
        
        if(withTruncatedPer < 0) {
            
            cell.priceChangeLb.textColor = UIColor.red
            cell.cryptoPriceLb.textColor = UIColor.red
        } else {
            
            cell.priceChangeLb.textColor = UIColor.green
            cell.cryptoPriceLb.textColor = UIColor.green
        }
        
        let morePCryptoPrice = Double((cryptoObj?.priceUsd)!)
        let cryptoWithTrunctedPrice = Decimal(morePCryptoPrice!).truncation(by: 2)
        
        cell.cryptoPriceLb.text = "$"+"\(cryptoWithTrunctedPrice)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = CryptoMarketViewController.storyboardVC
        self.present(vc, animated: true)
    }
}

// MARK: - UI Setup
extension CryptoViewController {
    func setupUI() {
        overrideUserInterfaceStyle = .light
        self.view.addSubview(tableView)
        tableView.addSubview(refreshControl)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        tableView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
        tableView.register(CryptoCell.self, forCellReuseIdentifier: "CryptoCell")
        tableView.register(UINib(nibName: "CryptoCell" , bundle:nil ), forCellReuseIdentifier: "CryptoCell")
        self.navigationItem.title = "Crypto"
    }
}

extension Decimal {
  func truncation(by digit: Int) -> Decimal {
    var initialDecimal = self
    var roundedDecimal = Decimal()
    NSDecimalRound(&roundedDecimal, &initialDecimal, digit, .plain)
    return roundedDecimal
  }
}
