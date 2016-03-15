//
//  ViewController.swift
//  BlueSniff
//
//  Created by Bruce Burgess on 3/16/16.
//  Copyright © 2016 Bruce Burgess. All rights reserved.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController, CBCentralManagerDelegate {
    
    var centralManager : CBCentralManager? //setting up the bluetooth central manager

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.centralManager = CBCentralManager(delegate: self, queue: nil) //Setting up the manage
    }
    
    func centralManagerDidUpdateState(central: CBCentralManager) {
        if central.state == CBCentralManagerState.PoweredOn{
            print("Everything is ok!")
        } else {
            print("Something wrong: \(central.state.rawValue)")
        }
    }

}

