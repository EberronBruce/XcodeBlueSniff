//
//  ViewController.swift
//  BlueSniff
//
//  Created by Bruce Burgess on 3/16/16.
//  Copyright © 2016 Bruce Burgess. All rights reserved.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController, CBCentralManagerDelegate, UITableViewDataSource, UITableViewDelegate {
    
    var centralManager : CBCentralManager? //setting up the bluetooth central manager
    var peripherals = [CBPeripheral]()
    var RSSIs = [NSNumber]()

    @IBOutlet weak var tableView: UITableView! //Connect storyboard tableview to code
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //set the tableview first
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.centralManager = CBCentralManager(delegate: self, queue: nil) //Setting up the manage
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.peripherals.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("blueCell") as! BlueToothTableViewCell
        let peripheral = self.peripherals[indexPath.row]
        let RSSI = self.RSSIs[indexPath.row]
        if peripheral.name == nil {
            cell.nameLabel.text = peripheral.identifier.UUIDString
        } else {
            cell.nameLabel.text = peripheral.name
        }
        
        cell.rssiLabel.text = "RSSI: \(RSSI)"
        return cell
    }

    
    func startScan(){
        self.centralManager?.scanForPeripheralsWithServices(nil, options: nil)
    }
    
    func centralManager(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber) {
        print("***********************")
        print("Name: \(peripheral.name)")
        print("UUID: \(peripheral.identifier.UUIDString)")
        print("Ad Data: \(advertisementData)")
        print("RSSI: \(RSSI)")
        print("***********************")
        self.peripherals.append(peripheral)
        self.RSSIs.append(RSSI)
        self.tableView.reloadData()
    }
    
    //Delegate to turn and chekc for bluetooth
    func centralManagerDidUpdateState(central: CBCentralManager) {
        if central.state == CBCentralManagerState.PoweredOn{ //check if bluetooth is on
            startScan()
        } else { //do this if bluetooth is off
            //set up alert to notify user of error
            let alertVC = UIAlertController(title: "Bluetooth Not Working", message: "Make sure that your bluetooth is on and ready to rock and roll.", preferredStyle: UIAlertControllerStyle.Alert)
            let action = UIAlertAction(title: "ok", style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction) -> Void in
                self.dismissViewControllerAnimated(true, completion: nil)
            })
            alertVC.addAction(action)
            self.presentViewController(alertVC, animated: true, completion: nil) //show alert
        }
    }
    

}

