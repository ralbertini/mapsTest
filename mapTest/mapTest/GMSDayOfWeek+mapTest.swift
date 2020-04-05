//
//  String+mapTest.swift
//  mapTest
//
//  Created by Tomate Albertini on 05/04/20.
//  Copyright © 2020 Ronaldo Albertini. All rights reserved.
//


import GooglePlaces

extension GMSDayOfWeek {
    
    func dayOfWeek() -> String {
        
        switch self {
        case .sunday:
            return "Domingo"
        case .monday:
            return "Segunda-feira"
        case .tuesday:
            return "Terça-feira"
        case .wednesday:
            return "Quarta-feira"
        case .thursday:
            return "Quinta-feira"
        case .friday:
            return "Sexta-feira"
        case .saturday:
            return "Sábado"
        }
    }
}
