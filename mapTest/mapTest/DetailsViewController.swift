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
    lazy var lbAddressDesc: UILabel = UILabel()
    
    lazy var lbOpeningHours: UILabel = UILabel()

    
    lazy var logoImageView: UIImageView = UIImageView()
    lazy var hoursStackView: UIStackView = UIStackView()
    
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
        
        guard let periods = place?.openingHours?.periods else { return }
        
        
        for hour in periods {
        
            let hourLabel: UILabel = UILabel()
            hourLabel.font = UIFont(name: "Avenir Next", size: 16.0)
            
            let openString: String = "\(hour.openEvent.day.dayOfWeek()) Abre: \(hour.openEvent.time) - Fecha: \(hour.closeEvent!.time)"
            
            hourLabel.text = openString
            
            self.hoursStackView.addArrangedSubview(hourLabel)
        }
    }
    
    private func setupViews() {
        
        self.view.backgroundColor = UIColor.white
        
        self.lbTitle.font = UIFont(name: "Avenir Next", size: 22.0)
        self.lbTitle.textAlignment = .center
        
        self.logoImageView.image = UIImage(named: "logo")
        
        self.view.addSubview(self.lbTitle)
        
        self.lbAddress.font = UIFont(name: "Avenir Next", size: 16.0)
        self.lbAddress.numberOfLines = 0
        self.view.addSubview(self.lbAddress)
        
        self.lbAddressDesc.font = UIFont(name: "Avenir Next", size: 18.0)
        self.lbAddressDesc.text = "Endereço: "
        self.view.addSubview(self.lbAddressDesc)
        
        self.hoursStackView.axis = .vertical
        
        self.view.addSubview(self.hoursStackView)
        
        self.lbOpeningHours.text = "Horário de funcionamento: "
        self.lbOpeningHours.font = UIFont(name: "Avenir Next", size: 18.0)
        
        
        self.view.addSubview(self.lbOpeningHours)
        self.view.addSubview(self.logoImageView)
    }
    
    private func setupConstraints() {
        
        self.lbTitle.snp.makeConstraints { (make) in

            make.top.equalTo(self.logoImageView.snp.bottom).offset(20.0)
            make.leading.equalToSuperview().offset(15.0)
            make.trailing.equalToSuperview().offset(-15.0)
        }
        
        self.lbAddressDesc.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(15.0)
            make.top.equalTo(self.lbTitle.snp.bottom).offset(25.0)
            make.trailing.equalToSuperview().offset(-15.0)
        }
        
        self.lbAddress.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(15.0)
            make.top.equalTo(self.lbAddressDesc.snp.bottom).offset(10.0)
            make.trailing.equalToSuperview().offset(-15.0)
        }
        
        self.lbOpeningHours.snp.makeConstraints { (make) in
            make.leadingMargin.equalToSuperview()
           make.top.equalTo(self.lbAddress.snp.bottom).offset(20.0)
        }
        
        self.logoImageView.snp.makeConstraints { (make) in
            make.height.width.equalTo(80.0)
            make.centerX.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
        }
        
        self.hoursStackView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(15.0)
            make.top.equalTo(self.lbOpeningHours.snp.bottom).offset(10.0)
            make.trailing.equalToSuperview().offset(-15.0)
        }
    }

}
