//
//  ConfigurationViewController.swift
//  netcube
//
//  Created by fran on 26/2/17.
//  Copyright © 2017 Francisco Navarro Aguilar. All rights reserved.
//

import UIKit

class ConfigurationViewController: UITableViewController, CustomCellDelegate {
    
    var device: [String:String]
    
    var cellDescriptors: [[[String:AnyObject]]]!
    
    var visibleRowsPerSection = [[Int]]()
    
    init(device:[String:String],style: UITableViewStyle) {
        self.device = device
        super.init(style: style)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let startColor = UIColor(red: 24/255, green: 40/255, blue: 72/255, alpha: 1)
        let endColor = UIColor(red: 75/255, green: 108/255, blue: 183/255, alpha: 1)
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [startColor.cgColor, endColor.cgColor]
        
        gradient.startPoint = CGPoint.zero
        gradient.endPoint = CGPoint(x: 0, y: 1)
        self.tableView?.backgroundColor = UIColor.clear
        self.tableView?.backgroundView = GradientView()
      
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureTableView()
        
        loadCellDescriptors()
        print(cellDescriptors)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: Custom Functions
    
    func configureTableView() {
  
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        self.tableView.register(UINib(nibName: "NormalCell", bundle: nil), forCellReuseIdentifier: "idCellNormal")
        self.tableView.register(UINib(nibName: "TextfieldCell", bundle: nil), forCellReuseIdentifier: "idCellTextfield")
        self.tableView.register(UINib(nibName: "DatePickerCell", bundle: nil), forCellReuseIdentifier: "idCellDatePicker")
        self.tableView.register(UINib(nibName: "SwitchCell", bundle: nil), forCellReuseIdentifier: "idCellSwitch")
        self.tableView.register(UINib(nibName: "ValuePickerCell", bundle: nil), forCellReuseIdentifier: "idCellValuePicker")
        self.tableView.register(UINib(nibName: "SliderCell", bundle: nil), forCellReuseIdentifier: "idCellSlider")
    }
    
    
    func loadCellDescriptors() {
        if let path = Bundle.main.path(forResource: "CellDescriptor", ofType: "plist") {
            cellDescriptors = NSArray(array:NSMutableArray(contentsOfFile: path)!) as! [[[String:AnyObject]]]
            
            getIndicesOfVisibleRows()
            self.tableView.reloadData()
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func getIndicesOfVisibleRows() {
        visibleRowsPerSection.removeAll()
        
        for currentSectionCells in cellDescriptors {
            var visibleRows = [Int]()
            
            for row in 0...((currentSectionCells ).count - 1) {
                if currentSectionCells[row]["isVisible"] as! Bool == true {
                    visibleRows.append(row)
                }
            }
            
            visibleRowsPerSection.append(visibleRows)
        }
    }
    
    func getCellDescriptorForIndexPath(indexPath: NSIndexPath) -> [String: AnyObject] {
        let indexOfVisibleRow = visibleRowsPerSection[indexPath.section][indexPath.row]
        let cellDescriptor = cellDescriptors[indexPath.section][indexOfVisibleRow] 
        return cellDescriptor
    }
    
    
    // MARK: UITableView Delegate and Datasource Functions
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        if cellDescriptors != nil {
            return cellDescriptors.count
        }
        else {
            return 0
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return visibleRowsPerSection[section].count
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "DISPOSITIVO"
            
        case 1:
            return "FUNCIONES ESPECIALES"
            
        default:
            return "ACERCA DEL DISPOSITIVO:"
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentCellDescriptor = getCellDescriptorForIndexPath(indexPath: indexPath as NSIndexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: currentCellDescriptor["cellIdentifier"] as! String, for: indexPath as IndexPath) as! CustomCell
        
        if currentCellDescriptor["cellIdentifier"] as! String == "idCellNormal" {
            if let primaryTitle = currentCellDescriptor["primaryTitle"] {
                cell.textLabel?.text = primaryTitle as? String
            }
            
            if let secondaryTitle = currentCellDescriptor["secondaryTitle"] {
                cell.detailTextLabel?.text = secondaryTitle as? String
            }
            if indexPath.section == 0 && indexPath.row == 0 {
                cell.textLabel?.text = "Nombre"
                cell.detailTextLabel?.text = device["name"]
            } else if indexPath.section == 2 && indexPath.row == 0 {
                cell.textLabel?.text = "MAC"
                cell.detailTextLabel?.text = device["MAC"]
                cell.accessoryType = .none
            } else if indexPath.section == 2 && indexPath.row == 1 {
                cell.textLabel?.text = "Dirección IP"
                cell.detailTextLabel?.text = device["IP_ADDRESS"]
                cell.accessoryType = .none
            }
        }
        else if currentCellDescriptor["cellIdentifier"] as! String == "idCellTextfield" {
            cell.textField.text = device["name"]
            
            
        }
        else if currentCellDescriptor["cellIdentifier"] as! String == "idCellSwitch" {
            cell.lblSwitchLabel.text = currentCellDescriptor["primaryTitle"] as? String
            
            let value = currentCellDescriptor["value"] as? String
            cell.swMaritalStatus.isOn = (value == "true") ? true : false
        }
        else if currentCellDescriptor["cellIdentifier"] as! String == "idCellValuePicker" {
            cell.textLabel?.text = currentCellDescriptor["primaryTitle"] as? String
        }
        else if currentCellDescriptor["cellIdentifier"] as! String == "idCellSlider" {
            let value = currentCellDescriptor["value"] as! String
            cell.slExperienceLevel.value = (value as NSString).floatValue
        }
        
        cell.delegate = self
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let currentCellDescriptor = getCellDescriptorForIndexPath(indexPath: indexPath as NSIndexPath)
        
        switch currentCellDescriptor["cellIdentifier"] as! String {
        case "idCellNormal":
            return 60.0
            
        case "idCellDatePicker":
            return 270.0
            
        default:
            return 44.0
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexOfTappedRow = visibleRowsPerSection[indexPath.section][indexPath.row]
        
        if cellDescriptors[indexPath.section][indexOfTappedRow]["isExpandable"] as! Bool == true {
            var shouldExpandAndShowSubRows = false
            if cellDescriptors[indexPath.section][indexOfTappedRow]["isExpanded"] as! Bool == false {
                // In this case the cell should expand.
                shouldExpandAndShowSubRows = true
            }
            
            cellDescriptors[indexPath.section][indexOfTappedRow]["isExpanded"] = shouldExpandAndShowSubRows as AnyObject?
            
            for i in (indexOfTappedRow + 1)...(indexOfTappedRow + (cellDescriptors[indexPath.section][indexOfTappedRow]["additionalRows"] as! Int)) {
                cellDescriptors[indexPath.section][i]["isVisible"] = shouldExpandAndShowSubRows as AnyObject?
            }
        }
        else {
            if cellDescriptors[indexPath.section][indexOfTappedRow]["cellIdentifier"] as! String == "idCellValuePicker" {
                var indexOfParentCell: Int!
                var i = indexOfTappedRow - 1
                
                while i >= 0 {
                    if cellDescriptors[indexPath.section][i]["isExpandable"] as! Bool == true {
                        indexOfParentCell = i
                        break
                    }
                    i = i - 1
                }
                
                
                cellDescriptors[indexPath.section][indexOfParentCell]["primaryTitle"] = (self.tableView.cellForRow(at: indexPath as IndexPath) as! CustomCell).textLabel?.text as AnyObject?
                cellDescriptors[indexPath.section][indexOfParentCell]["isExpanded"] = false as AnyObject?
                
                for i in (indexOfParentCell + 1)...(indexOfParentCell + (cellDescriptors[indexPath.section][indexOfParentCell]["additionalRows"] as! Int)) {
                    cellDescriptors[indexPath.section][i]["isVisible"] = false as AnyObject?
                }
            }
        }
        
        getIndicesOfVisibleRows()
        self.tableView.reloadSections(NSIndexSet(index: indexPath.section) as IndexSet, with: UITableViewRowAnimation.fade)
    }
    
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel(frame: CGRect(x: 16, y: 8, width: tableView.frame.size.width, height: 40))
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 12)
        label.textColor = UIColor.white
        label.text = self.tableView(tableView, titleForHeaderInSection: section)
        
        let view = UIView()
        view.addSubview(label)
        view.backgroundColor = UIColor.clear
        return view
    }
    
    // MARK: CustomCellDelegate Functions
    
    func dateWasSelected(selectedDateString: String) {
        let dateCellSection = 0
        let dateCellRow = 3
        
        cellDescriptors[dateCellSection][dateCellRow]["primaryTitle"] = selectedDateString as AnyObject?
        self.tableView.reloadData()
    }
    
    
    func maritalStatusSwitchChangedState(isOn: Bool) {
        let maritalSwitchCellSection = 0
        let maritalSwitchCellRow = 6
        
        let valueToStore = (isOn) ? "true" : "false"
        let valueToDisplay = (isOn) ? "Married" : "Single"
        
        cellDescriptors[maritalSwitchCellSection][maritalSwitchCellRow]["value"] = valueToStore as AnyObject?
        cellDescriptors[maritalSwitchCellSection][maritalSwitchCellRow - 1]["primaryTitle"] = valueToDisplay as AnyObject?
        self.tableView.reloadData()
    }
    
    
    func textfieldTextWasChanged(newText: String, parentCell: CustomCell) {
        let parentCellIndexPath = self.tableView.indexPath(for: parentCell)
        
        let currentFullname = cellDescriptors[0][0]["primaryTitle"] as! String
        let fullnameParts = currentFullname.components(separatedBy: " ")
        
        var newFullname = ""
        
        if parentCellIndexPath?.row == 1 {
            if fullnameParts.count == 2 {
                newFullname = "\(newText) \(fullnameParts[1])"
            }
            else {
                newFullname = newText
            }
        }
        else {
            newFullname = "\(fullnameParts[0]) \(newText)"
        }
        
        cellDescriptors[0][0]["primaryTitle"] = newFullname as AnyObject?
        self.tableView.reloadData()
    }
    
    
    func sliderDidChangeValue(newSliderValue: String) {
        cellDescriptors[2][0]["primaryTitle"] = newSliderValue as AnyObject?
        cellDescriptors[2][1]["value"] = newSliderValue as AnyObject?
        
        self.tableView.reloadSections(NSIndexSet(index: 2) as IndexSet, with: UITableViewRowAnimation.none)
    }
}
