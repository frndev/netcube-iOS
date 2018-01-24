//
//  DeviceMusicViewController.swift
//  netcube
//
//  Created by fran on 18/6/17.
//  Copyright © 2017 Francisco Navarro Aguilar. All rights reserved.
//

import UIKit
import Moscapsule
import Charts
class DeviceMusicViewController: UIViewController {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var powerLabel: UILabel!
    @IBOutlet weak var lineChartView: LineChartView!
    let chartManager: ChartManager = ChartManager()
    let switchView = UISwitch()
    var chartDelegate: ConsumptionChartDelegate!
    var change = 1
    var mqttConfig: MQTTConfig!
    var mqttClient: MQTTClient!
    var device: [String: String]!
    
    init(device: [String:String]) {
        
        super.init(nibName: nil, bundle: nil)
        self.device = device
        mqttConfig = MQTTConfig(clientId: clientId, host: host, port: port, keepAlive: keepAlive)
        mqttConfig.mqttAuthOpts = MQTTAuthOpts(username: username, password: password)
        mqttConfig.onMessageCallback = { mqttMessage in
            DispatchQueue.main.async {
                if mqttMessage.topic == "APP/OnOffTopic" {
                    let value = mqttMessage.payloadString! == "1" ? true : false
                    self.switchView.setOn(value, animated: true)
                }else {
                    self.requestConsumption()
                }
                
            }
        }
        
        mqttClient = MQTT.newConnection(mqttConfig)
        mqttClient.subscribe(appConsumptionTopic, qos: 1)
        mqttClient.subscribe(appOnOffTopic, qos: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func sendAction(_ sender: UISegmentedControl) {
        
        mqttClient.publish(string: String(sender.selectedSegmentIndex == 0 ? 1 : 0), topic: "ESP/OnOffTopic/", qos: 1, retain: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if self.change == 0{
            self.change = 1
            // self.theSwitch.setOn(false, animated: true)
            
        }else{
            self.change = 0
            //self.theSwitch.setOn(true, animated: true)
        }
        self.requestConsumption()
        NotificationCenter.default.addObserver(self, selector: #selector(requestConsumption), name: .UIApplicationDidBecomeActive, object: nil)
        
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        mqttClient.disconnect()
        NotificationCenter.default.removeObserver(self)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = device["name"]
        requestConsumption()
        self.chartDelegate = ConsumptionChartDelegate(deviceMusicViewController: self)
        self.lineChartView.delegate = self.chartDelegate
        chartManager.consumptionChartView(self.lineChartView)
        
        
        let configButton = UIBarButtonItem(image: UIImage(named:"config"), style: .plain, target: self, action: #selector(openConfiguration(_:)))
        self.navigationItem.rightBarButtonItem = configButton
    }
    
    func requestConsumption() {
        if self.isViewLoaded {
            DispatchQueue.global(qos: .userInitiated).async {
                self.mqttClient.publish(string: "consumption", topic: serverConsumptionTopic, qos: 1, retain: true)
            }
        }
    }
    
    func openConfiguration(_ sender: UIBarButtonItem) {
        
        let confViewController = ConfigurationViewController(device:device,style:.plain)
        
        self.navigationController?.pushViewController(confViewController, animated: true)
        
    }

}
