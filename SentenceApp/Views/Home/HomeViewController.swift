//
//  HomeViewController.swift
//  SentenceApp
//
//  Created by Alesson Abao on 14/08/23.
//

import UIKit

class HomeViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: Outlets
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var offenseTextField: UITextField!
    @IBOutlet weak var severityTextField: UITextField!
    @IBOutlet weak var intentTextField: UITextField!
    @IBOutlet weak var recommendTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // set offender name to hide
        firstNameLabel.isHidden = true
        firstNameTextField.isHidden = true
        lastNameLabel.isHidden = true
        lastNameTextField.isHidden = true
        
        // keyboard setup
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        offenseTextField.delegate = self
        severityTextField.delegate = self
        intentTextField.delegate = self
    }
    
    // MARK: Actions
    @IBAction func repeatOffenderButton(_ sender: UIButton) {
        // set offender name to show
        firstNameLabel.isHidden = false
        firstNameTextField.isHidden = false
        lastNameLabel.isHidden = false
        lastNameTextField.isHidden = false
        // ===============FOR TESTING===============
//        if isValidOffender(){
//            // run different model here with offender
//        }
//        else{
//            showMessage(message: "Invalid name", buttonCaption: "Try again", controller: self)
//        }
        // ===============FOR TESTING===============
    }
    
    @IBAction func recommendButton(_ sender: UIButton) {
        
        if isRepeatOffender(){
            print("==================FOR TESTING==================")
            print("isRepeatOffender")
            print("==================FOR TESTING==================")
            
            if isValidOffender(){
                if isValidForm(){
                    // run different models
                }
                else{
                    showMessage(message: "inside repeat offender, isValidOffender, and isValidForm", buttonCaption: "Close", controller: self)
                }
            }
            else{
                showMessage(message: "inside isRepeatOffender and else of isValidOffender", buttonCaption: "Close", controller: self)
            }
            
            resetForm()
        }
        else{
            
            if isValidForm(){
                let offenseInput = offenseTextField.text!
                let severiyInput = Int(severityTextField.text!)!
                let intentInput = intentTextField.text!
                
                // ===================TESTING MODEL===================
                let sentenceRecommend = noRepeatOffenderSentenceModel(offense: offenseInput, severity: severiyInput, intent: intentInput)!.Sentence
                let durationRecommend = noRepeatOffenderDurationModel(offense: offenseInput, severity: severiyInput, intent: intentInput, sentence: sentenceRecommend)!.Period_in_Months
                // ===================TESTING MODEL===================
                
                // ==================FOR TESTING==================
                print("==================FOR TESTING==================")
                print("This is the recommended sentence: \(String(describing: sentenceRecommend))")
                // print("This is the recommended duration of sentence: \(durationRecommend)")
                print("This is typeof sentenceRecommend: \(type(of: sentenceRecommend))")
                // print("This is typeof durationRecommend: \(type(of: durationRecommend))")
                print("==================FOR TESTING==================")
                // ==================FOR TESTING==================
                
                // show recommendation in TextView
                recommendTextView.text = "Sentence\t\t\tPeriod in Months\n" + sentenceRecommend + "\t\t\t" + String(format: "%.2f", durationRecommend)
                
                resetForm()
            }
            else{
                showMessage(message: "Whoops! It seems like there are some empty fields in the form. Double-check and make sure nothing's left blank.", buttonCaption: "Close", controller: self)
            }
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
    func isValidForm() -> Bool{
        guard let offense = offenseTextField.text, !offense.isEmpty else{
            return false
        }
        guard let severity = severityTextField.text, !severity.isEmpty else{
            return false
        }
        guard let intent = intentTextField.text, !intent.isEmpty else{
            return false
        }
        return true
    }
    
    func isValidOffender() -> Bool{
        guard let firstName = firstNameTextField.text, !firstName.isEmpty else{
            return false
        }
        guard let lastName = lastNameTextField.text, !lastName.isEmpty else{
            return false
        }
        
        // add more validations
        return true
    }
    
    func isRepeatOffender() -> Bool{
        if(firstNameLabel.isHidden == false && firstNameTextField.isHidden == false && lastNameLabel.isHidden == false && lastNameTextField.isHidden == false){
            return true
        }
        else{
            return false
        }
    }
    
    func resetForm(){
        firstNameTextField.text = nil
        lastNameTextField.text = nil
//        offenseTextField.text = nil
//        severityTextField.text = nil
//        intentTextField.text = nil
        
        // set offender name to hide
        firstNameLabel.isHidden = true
        firstNameTextField.isHidden = true
        lastNameLabel.isHidden = true
        lastNameTextField.isHidden = true
    }
}
