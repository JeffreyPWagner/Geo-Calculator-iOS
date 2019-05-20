//
//  settingsViewController.swift
//  Geo Calculator
//
//  Created by Grant N. Postma on 5/16/19.
//  Copyright © 2019 Grant Postma & Jeff Wagner. All rights reserved.
//

import UIKit

protocol settingsViewControllerDelegate: class {
    func updateUnits( distanceUnits: String?, bearingUnits: String?)
}

class settingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    weak var settingsDelegate: settingsViewControllerDelegate?

    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    

    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func saveButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "segueToSettings", sender: self)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == distancePicker {
            
            return distancePickerData.count
        }
        else if pickerView == bearingPicker {
            return bearingPickerData.count
        }
        else {
            return 0;
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        settingsDelegate?.updateUnits(distanceUnits: "Meters1", bearingUnits: "BearingUUU")

        if pickerView == distancePicker {
            return distancePickerData[row]
        }
        else if pickerView == bearingPicker {
            return bearingPickerData[row]
        }
        else {
            return "";
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component:Int){
        if pickerView == distancePicker {
            distanceUnitsValue.text = distancePickerData[row];
        }
        else if pickerView == bearingPicker {
            bearingUnitsValue.text = bearingPickerData[row]
        }
    }

    @IBOutlet weak var distanceUnitsValue: UILabel!
    @IBOutlet weak var bearingUnitsValue: UILabel!
    
    @IBOutlet weak var distancePicker: UIPickerView!
    @IBOutlet weak var bearingPicker: UIPickerView!
    
    var distancePickerData: [String] = [String]();
    var bearingPickerData: [String] = [String]();

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        distancePickerData = ["Miles","Kilometers", "Meters"];
        bearingPickerData = ["Degrees","Mils"];
        distanceUnitsValue.textColor = UIColor.lightGray;
        bearingUnitsValue.textColor = UIColor.lightGray;
        
        self.distancePicker.delegate = self;
        self.distancePicker.dataSource = self;
        
        self.bearingPicker.delegate = self;
        self.bearingPicker.dataSource = self;
        
        distancePicker.isHidden = true;
        bearingPicker.isHidden = true;
        
        let tapDistance = UITapGestureRecognizer(target: self, action: #selector(settingsViewController.tapFunctionDistance));
        distanceUnitsValue.isUserInteractionEnabled = true;
        distanceUnitsValue.addGestureRecognizer(tapDistance);
        
        let tapBearing = UITapGestureRecognizer(target: self, action: #selector(settingsViewController.tapFunctionBearing));
        bearingUnitsValue.isUserInteractionEnabled = true;
        bearingUnitsValue.addGestureRecognizer(tapBearing);
        
        // Do any additional setup a        fter loading the view.
    }
    
    @objc
    func tapFunctionDistance(sender:UITapGestureRecognizer) {
        distancePicker.isHidden = false;
    }
    
    @objc
    func tapFunctionBearing(sender:UITapGestureRecognizer) {
        bearingPicker.isHidden = false;
    }


}
