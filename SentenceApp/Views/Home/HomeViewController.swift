//
//  HomeViewController.swift
//  SentenceApp
//
//  Created by Alesson Abao on 14/08/23.
//

import UIKit

class HomeViewController: UIViewController, UITextFieldDelegate{
    
    // MARK: Outlets
    @IBOutlet weak var offenseTextField: UITextField!
    @IBOutlet weak var severityTextField: UITextField!
    @IBOutlet weak var intentTextField: UITextField!
    
    
    @IBOutlet weak var offense2View: UIView!
    
    @IBOutlet weak var offense2Label: UILabel!
    @IBOutlet weak var offense2TextField: UITextField!
    @IBOutlet weak var severity2Label: UILabel!
    @IBOutlet weak var severity2TextField: UITextField!
    @IBOutlet weak var intent2Label: UILabel!
    @IBOutlet weak var intent2TextField: UITextField!
    
    @IBOutlet weak var recommendTextView: UITextView!
    
    // variable
    var is2OffenseFlag: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // set offense 2 to hide
//        offense2Label.isHidden = true
//        offense2TextField.isHidden = true
//        severity2Label.isHidden = true
//        severity2TextField.isHidden = true
//        intent2Label.isHidden = true
//        intent2TextField.isHidden = true
        
        // =====================TESTING HIDE/UNHIDE=====================
        offense2View.isHidden = true
        
        // =====================TESTING HIDE/UNHIDE=====================
        
        // keyboard setup
        offenseTextField.delegate = self
        severityTextField.delegate = self
        intentTextField.delegate = self
        offense2TextField.delegate = self
        severity2TextField.delegate = self
        intent2TextField.delegate = self
    }
    
    
    
    // MARK: Actions
    @IBAction func offense2Button(_ sender: UIButton) {
        // set offense 2 to show up
//        offense2Label.isHidden = false
//        offense2TextField.isHidden = false
//        severity2Label.isHidden = false
//        severity2TextField.isHidden = false
//        intent2Label.isHidden = false
//        intent2TextField.isHidden = false
        
        // =====================TESTING HIDE/UNHIDE=====================
        if(offense2View.tag == 0){
            offense2View.tag = 1
            offense2View.isHidden = true
        }
        else{
            offense2View.tag = 0
            offense2View.isHidden = false
            // run different model
            is2OffenseFlag = true
        }
        // =====================TESTING HIDE/UNHIDE=====================
        
//        // run different model
//        is2OffenseFlag = true
    }

    
    @IBAction func recommendButton(_ sender: UIButton) {
        
        if is2OffenseFlag == true {
            if isValidForm2Offense(){
                showMessage(message: "valid 2 offense",  controller: self)
            }
            else{
                showMessage(message: "Whoops! It seems like there are some empty fields in the form. Double-check and make sure nothing's left blank.",  controller: self)
            }
            // resetForm()
        }
        else{
            
            if isValidForm1Offense(){
                let offenseInput = offenseTextField.text!
                let severiyInput = Int(severityTextField.text!)!
                let intentInput = intentTextField.text!
                
                // ===================TESTING MODEL===================
                let sentenceRecommend = noRepeatOffenderSentenceModel(offense: offenseInput, severity: severiyInput, intent: intentInput)!.Sentence
                let durationRecommend = noRepeatOffenderDurationModel(offense: offenseInput, severity: severiyInput, intent: intentInput, sentence: sentenceRecommend)!.Period_in_Months
                
                // automaticTrainingDuration model
//                let durationRecommend = noRepeatOffenderDurationModel(offense: offenseInput, severity: severiyInput, intent: intentInput, sentence: sentenceRecommend)!.duration
                // ===================TESTING MODEL===================
                
                // ==================FOR TESTING==================
                print("==================FOR TESTING==================")
                print("This is the recommended sentence: \(String(describing: sentenceRecommend))")
                // print("This is the recommended duration of sentence: \(durationRecommend)")
                print("This is typeof sentenceRecommend: \(type(of: sentenceRecommend))")
                // print("This is typeof durationRecommend: \(type(of: durationRecommend))")
                print("==================FOR TESTING==================")
                // ==================FOR TESTING==================
                
                if(durationRecommend < 0){
                    // show recommendation in TextView
                    recommendTextView.text = "Sentence\t\t\tPeriod in days\n" + sentenceRecommend + "\t\t\t" + "N/A"
                }
                else{
                    // show recommendation in TextView
                    recommendTextView.text = "Sentence\t\t\tPeriod in days\n" + sentenceRecommend + "\t\t\t" + String(format: "%.2f", durationRecommend)
                }
                
                resetForm()
            }
            else{
                showMessage(message: "Whoops! It seems like there are some empty fields in the form. Double-check and make sure nothing's left blank.",  controller: self)
            }
            resetForm()
        }
    }
    
    // MARK: Frontend functions
    // dismiss keyboard when user clicks outside textbox
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // dismiss keyboard when user clicks return in keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: Form Validations
    func isValidForm1Offense() -> Bool{
        guard let offense = offenseTextField.text, !offense.isEmpty else{
            return false
        }
        guard let severity = severityTextField.text, !severity.isEmpty else{
            return false
        }
        guard let intent = intentTextField.text, !intent.isEmpty else{
            return false
        }
        
        let characterRegEx = "^[a-zA-Z]+$"
        let characterPredicate = NSPredicate(format: "SELF MATCHES %@", characterRegEx)
        
        let numberRegEx = "^[0-9]*$"
        let numberPredicate = NSPredicate(format: "SELF MATCHES %@", numberRegEx)
        
        if !characterPredicate.evaluate(with: offense){
            showMessage(message: "Offense shouldn't contain a number.",  controller: self)
            return false
        }
        else if !numberPredicate.evaluate(with: severity){
            showMessage(message: "Severity shouldn't contain a character.",  controller: self)
            return false
        }
        else if !characterPredicate.evaluate(with: intent){
            showMessage(message: "Intent shouldn't contain a number.",  controller: self)
            return false
        }
        
        return true
    }
    
    func isValidForm2Offense() -> Bool{
        guard let offense1 = offenseTextField.text, !offense1.isEmpty else{
            return false
        }
        guard let severity1 = severityTextField.text, !severity1.isEmpty else{
            return false
        }
        guard let intent1 = intentTextField.text, !intent1.isEmpty else{
            return false
        }
        
        guard let offense2 = offense2TextField.text, !offense2.isEmpty else{
            return false
        }
        guard let severity2 = severity2TextField.text, !severity2.isEmpty else{
            return false
        }
        guard let intent2 = intent2TextField.text, !intent2.isEmpty else{
            return false
        }
        
        let characterRegEx = "^[a-zA-Z]+$"
        let characterPredicate = NSPredicate(format: "SELF MATCHES %@", characterRegEx)
        
        let numberRegEx = "^[0-9]*$"
        let numberPredicate = NSPredicate(format: "SELF MATCHES %@", numberRegEx)
        
        if !characterPredicate.evaluate(with: offense1){
            showMessage(message: "Offense shouldn't contain a number.",  controller: self)
            return false
        }
        else if !numberPredicate.evaluate(with: severity1){
            showMessage(message: "Severity shouldn't contain a character.",  controller: self)
            return false
        }
        else if !characterPredicate.evaluate(with: intent1){
            showMessage(message: "Intent shouldn't contain a number.",  controller: self)
            return false
        }
        else if !characterPredicate.evaluate(with: offense2){
            showMessage(message: "Offense shouldn't contain a number.",  controller: self)
            return false
        }
        else if !numberPredicate.evaluate(with: severity2){
            showMessage(message: "Severity shouldn't contain a character.",  controller: self)
            return false
        }
        else if !characterPredicate.evaluate(with: intent2){
            showMessage(message: "Intent shouldn't contain a number.",  controller: self)
            return false
        }
        
        return true
    }
    
    
    func resetForm(){
        offenseTextField.text = nil
        severityTextField.text = nil
        intentTextField.text = nil
        
        offense2TextField.text = nil
        severity2TextField.text = nil
        intent2TextField.text = nil
        
        // set offense 2 to hide
//        offense2Label.isHidden = true
//        offense2TextField.isHidden = true
//        severity2Label.isHidden = true
//        severity2TextField.isHidden = true
//        intent2Label.isHidden = true
//        intent2TextField.isHidden = true
        
        // =====================TESTING HIDE/UNHIDE=====================
        offense2View.isHidden = true
        // =====================TESTING HIDE/UNHIDE=====================
    }
}
