//
//  DetailsViewControllerTest.swift
//  mapTestTests
//
//  Created by Tomate Albertini on 05/04/20.
//  Copyright © 2020 Ronaldo Albertini. All rights reserved.
//

import FBSnapshotTestCase
import GooglePlaces

@testable import mapTest

class DetailsViewControllerTest: FBSnapshotTestCase {
    
    override func setUp() {
        super.setUp()
        
        self.recordMode = false
        self.fileNameOptions = [.screenSize,.screenScale]
    }
    
    func testDetailScreen() {
        
        let vc = DetailsViewController()
        vc.lbTitle.text = "TESTE Itaú"
        vc.lbAddress.text = "Endereço teste"
        
        
        FBSnapshotVerifyView(vc.view)
    }
    
}
