//
//  ViewController.swift
//  nea
//
//  Created by Daniel Armstrong on 31/10/2022.
//

import UIKit
import CoreData

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var ageTF: UITextField!
    @IBOutlet weak var weightTF: UITextField!
    @IBOutlet weak var heightTF: UITextField!
    @IBOutlet weak var genderTF: UITextField!
    //    These are linking the text fields to the code
   
    
    
    
    let genders = ["Male", "Female"]
    var pickerView = UIPickerView() //Sets the objects that will be shown in the list
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Settings"
        pickerView.delegate = self
        pickerView.dataSource = self
        genderTF.inputView = pickerView
        
        ageTF.keyboardType = .numberPad
        weightTF.keyboardType = .numberPad
        heightTF.keyboardType = .numberPad // shows number pad
        
        nameTF.text = UserDefaults.standard.string(forKey: "name")
        genderTF.text = UserDefaults.standard.string(forKey: "gender")
        ageTF.text = UserDefaults.standard.string(forKey: "age")
        weightTF.text = UserDefaults.standard.string(forKey: "weight")
        heightTF.text = UserDefaults.standard.string(forKey: "height")  // this keeps the values in the text field
        
    }
    
    
    @IBAction func saveButton(_ sender: Any) {
        let name = nameTF.text! //This is setting the user variables to whats in the text fields
        let gender = genderTF.text!
        let ageString = ageTF.text!
        let age = Float(ageString)!
        let weightString = weightTF.text!
        let weight = Float(weightString)!
        let heightString = heightTF.text!
        let height = Float(heightString)!
    
        let defaults = UserDefaults.standard
        defaults.set(name, forKey: "name")
        defaults.set(gender, forKey: "gender")
        defaults.set(height, forKey: "height")
        defaults.set(weight, forKey: "weight")
        defaults.set(age, forKey: "age")   //this saves the user information to the app storage
        
        
        
        if gender == "Male"{
            let weightfactor = (13.397 * weight)
            let heightfactor = (4.799 * height)
            let agefactor = (5.677 * age)
            let bmr = 88.362 + weightfactor + heightfactor - agefactor  //This is the equation to get bmr for a Male
            
            defaults.set(bmr, forKey: "bmr")
            
        }
        else{
            let weightfactor = (9.247 * weight)
            let heightfactor = (3.098 * height)
            let agefactor = (4.330 * age)
            let bmr = 447.593 + weightfactor + heightfactor - agefactor  //This is the equation to get bmr for a Female
            defaults.set(bmr, forKey: "bmr")
        }
    }
}



extension SettingsViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genders.count //This counts how many objects there are in the array
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genders[row]  //this returns the object of the array
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genderTF.text = genders[row]
        genderTF.resignFirstResponder() // This function sets the text in the text field
    }
}

