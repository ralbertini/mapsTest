//
//  DetailsViewController.swift
//  mapTest
//
//  Created by Tomate Albertini on 05/04/20.
//  Copyright © 2020 Ronaldo Albertini. All rights reserved.
//

import UIKit
import GooglePlaces

class DetailsViewController: UIViewController {

    lazy var lbTitle: UILabel = UILabel()
    lazy var lbAddress: UILabel = UILabel()
    lazy var lbOpeningHours: UILabel = UILabel()
    
    var place: GMSPlace?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.setupViews()
        self.setupConstraints()
        self.loadData()
        
    }
 
    func loadData() {
        
        self.lbTitle.text = place?.name
        self.lbAddress.text = place?.formattedAddress
//        self.lbOpeningHours.text = place?.openingHours?.pe
    }
    
    private func setupViews() {
        
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(self.lbTitle)
        self.view.addSubview(self.lbAddress)
        self.view.addSubview(self.lbOpeningHours)
    }
    
    private func setupConstraints() {
        
        self.lbTitle.snp.makeConstraints { (make) in

            make.top.equalTo(self.topLayoutGuide.snp.bottom)
            make.leadingMargin.equalToSuperview()
        }
        
        self.lbAddress.snp.makeConstraints { (make) in
            make.leadingMargin.equalToSuperview()
            make.top.equalTo(self.lbTitle.snp.bottomMargin)
        }
        
        self.lbOpeningHours.snp.makeConstraints { (make) in
            make.leadingMargin.equalToSuperview()
            make.top.equalTo(self.lbAddress.snp.bottomMargin)
        }
    }

}
