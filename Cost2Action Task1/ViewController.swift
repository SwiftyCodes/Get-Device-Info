//
//  ViewController.swift
//  Cost2Action Task1
//
//  Created by Chaudhary Himanshu Raj on 21/01/18.
//  Copyright © 2018 Chaudhary Himanshu Raj. All rights reserved.
//

import UIKit
import DeviceKit
import CoreTelephony


class ViewController: UIViewController {
    let device = Device()
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var infoLabel: UILabel!
    
    var usedDisk = ""
    var freeDisk = ""
    var totalDisk = ""
    var deviceDetails1 : String!
    var deviceDetails2 : String!
    var DiskInfo : String!
    
    static var carrierName:String? {
        let networkInfo = CTTelephonyNetworkInfo()
        let carrier = networkInfo.subscriberCellularProvider
        return carrier?.carrierName
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     }
    
    @IBAction func AnalyzeButtonTapped(_ sender: Any) {
        //MARK: About Device, Screen Size, System, Battery.
        if device.isPod {
            // iPods (real or simulator)
        } else if device.isPhone {
            
        deviceDetails1 = " { DEVICE [Device : \(device), Device Description : \(device.description), Device Localized Model : \(device.localizedModel), Device Model : \(device.model), Device Name : \(device.name)], SYSTEM [System Name : \(device.systemName), System Version : \(device.systemVersion)], SCREEN [Screen Size : \(device.diagonal), Screen Ratio : \(device.screenRatio)], BATTERY [Batttery State : \(device.batteryState), BatteryLevel : \(device.batteryLevel)],"
        } else if device.isPad {
            // iPad (real or simulator)
        } else if device.isSimulator {
            print(device)
        }
        
        // MARK: About Memory/ RAM
        usedDisk = String(format:NSLocalizedString("Used %@", comment: ""), DiskStatus.usedDiskSpace)
        freeDisk = String(format:NSLocalizedString("Free %@", comment: ""), DiskStatus.freeDiskSpace)
        totalDisk = String(format:NSLocalizedString("Total %@", comment: ""), DiskStatus.totalDiskSpace)
        DiskInfo = " MEMORY [RAM : \(ProcessInfo.processInfo.physicalMemory/UInt64(1024.0 * 1024.0 * 1024.0)) GB, Used Disk : \(usedDisk), Free Disk : \(freeDisk), Total Disk : \(totalDisk)],"
        
        // MARK: Secret Agent, Career, Locale, Time-Zone, Country Code.
        let webView = UIWebView(frame: CGRect.zero)
        let secretAgent: String? = webView.stringByEvaluatingJavaScript(from: "navigator.userAgent")
        guard let countryCode = (Locale.current as NSLocale).object(forKey: .countryCode) as? String else { return }
        var timeZoneAbbreviations: [String:String] { return TimeZone.abbreviationDictionary }
        
        deviceDetails2 = " SECRET-AGENT [Secret Agent : \(secretAgent!), Career : \(String(describing: ViewController.carrierName))], LOCALE [Locale : \(String(describing: Bundle.main.preferredLocalizations.first!))], TIME ZONE [Country Code : \(countryCode), Time Zone : \(TimeZone.current.secondsFromGMT()), Time Zone Abbreviation : \(timeZoneAbbreviations["BST"]!)], DEVICE PID : \(UIDevice.current.identifierForVendor!.uuidString), CPU [CPU Name : \(UIDevice.current.getCPUName()), CPU Speed : \(UIDevice.current.getCPUSpeed()), Cores : \(ProcessInfo.processInfo.activeProcessorCount)], Screen : \(UIScreen.main.bounds), Version : \(String(describing: Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String)))}"
        
        button.isHidden = true
        infoLabel.isHidden = false
        infoLabel.text = "\(deviceDetails1!) \(DiskInfo!) \(deviceDetails2!)"
    }
}
