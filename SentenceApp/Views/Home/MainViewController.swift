//
//  MainViewController.swift
//  SentenceApp
//
//  Created by Alesson Abao on 6/09/23.
//

import UIKit

class MainViewController: UIViewController, UITextFieldDelegate {

    // MARK: Form frontend outlets
    @IBOutlet weak var addOffence2Button: UIButton!
    @IBOutlet weak var addOffence3Button: UIButton!
    
    @IBOutlet weak var offence2View: UIView!
    @IBOutlet weak var addOffence3View: UIView!
    @IBOutlet weak var offence3View: UIView!
    
    // MARK: AI input outlets
    @IBOutlet weak var offence1TextField: UITextField!
    @IBOutlet weak var severity1TextField: UITextField!
    @IBOutlet weak var intent1TextField: UITextField!
    @IBOutlet weak var remand1TextField: UITextField!
    
    @IBOutlet weak var offence2TextField: UITextField!
    @IBOutlet weak var severity2TextField: UITextField!
    @IBOutlet weak var intent2TextField: UITextField!
    @IBOutlet weak var remand2TextField: UITextField!
    
    @IBOutlet weak var offence3TextField: UITextField!
    @IBOutlet weak var severity3TextField: UITextField!
    @IBOutlet weak var intent3TextField: UITextField!
    @IBOutlet weak var remand3TextField: UITextField!
    
    @IBOutlet weak var outputTextView: UITextView!
    
    // MARK: Variables
    var isOneOffence: Bool = true
    var isTwoOffences: Bool = false
    var isThreeOffences: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUp()
    }
    
    // MARK: Actions
    @IBAction func addOffence2(_ sender: UIButton) {
        
    }
    
    @IBAction func addOffence3(_ sender: UIButton) {
        
    }
    
    @IBAction func recommendOutput(_ sender: UIButton) {
        
    }
    
    // MARK: Frontend functions
    // ======================KEYBOARD======================
    // dismiss keyboard when user clicks outside textbox
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    // dismiss keyboard when user clicks return in keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    // ======================KEYBOARD======================
    // ========================FORM========================
    func validForm() -> Bool{
        let characterRegEx = "^[a-zA-Z]+$"
        let characterPredicate = NSPredicate(format: "SELF MATCHES %@", characterRegEx)
        
        let severityNumberRegEx = "^(?:[1-4]|[0-9]{2,})$"
        let severityNumberPredicate = NSPredicate(format: "SELF MATCHES %@", severityNumberRegEx)
        
        let remandNumberRegEx = "^[0-9]+$"
        let remandNumberPredicate = NSPredicate(format: "SELF MATCHES %@", remandNumberRegEx)
        
        if(isOneOffence == true && isTwoOffences == false && isThreeOffences == false){
            // make offence, severity, and intent required but not allowing empty fields
            guard let offence1 = offence1TextField.text, !offence1.isEmpty else{
                return false
            }
            guard let severity1 = severity1TextField.text, !severity1.isEmpty else{
                return false
            }
            guard let intent1 = intent1TextField.text, !intent1.isEmpty else{
                return false
            }
            // make sure offence and intent only accept character values only
            if(!characterPredicate.evaluate(with: offence1)){
                showMessage(message: "Offence input should not contain numbers.", buttonCaption: "Close", controller: self)
                return false
            }
            else if(!characterPredicate.evaluate(with: intent1)){
                showMessage(message: "Intent input should not conrain numbers.", buttonCaption: "Close", controller: self)
                return false
            }
            else if(intent1.lowercased() != "intentional" || intent1.lowercased() != "reckless" || intent1.lowercased() != "knowing" || intent1.lowercased() != "negligent"){
                showMessage(message: "Please choose among the following intent inputs: \n Intentional\n Reckless\n Knowing\n Negligent\n", buttonCaption: "Try again", controller: self)
                return false
            }
            // make sure severity and remand only accept number values only
            else if(!severityNumberPredicate.evaluate(with: severity1)){
                showMessage(message: "Severity input should not contain a letter. Please choose from 1 (least severe) to 4 (most severe).", buttonCaption: "Close", controller: self)
                return false
            }
            else if(!remandNumberPredicate.evaluate(with: remand1TextField.text)){
                showMessage(message: "Remand should not contain a letter. Please input the duration the offender is in custody before sentence in months.", buttonCaption: "Close", controller: self)
                return false
            }
        }
        else if(isOneOffence == false && isTwoOffences == true && isThreeOffences == false){
            // make offence, severity, and intent required but not allowing empty fields
            // ===========================offence 1===========================
            guard let offence1 = offence1TextField.text, !offence1.isEmpty else{
                return false
            }
            guard let severity1 = severity1TextField.text, !severity1.isEmpty else{
                return false
            }
            guard let intent1 = intent1TextField.text, !intent1.isEmpty else{
                return false
            }
            // ===========================offence 2===========================
            guard let offence2 = offence2TextField.text, !offence2.isEmpty else{
                return false
            }
            guard let severity2 = severity2TextField.text, !severity2.isEmpty else{
                return false
            }
            guard let intent2 = intent2TextField.text, !intent2.isEmpty else{
                return false
            }
            // ===========================offence 1===========================
            // make sure offence and intent only accept character values only
            if(!characterPredicate.evaluate(with: offence1)){
                showMessage(message: "Offence input should not contain numbers.", buttonCaption: "Close", controller: self)
                return false
            }
            else if(!characterPredicate.evaluate(with: intent1)){
                showMessage(message: "Intent input should not conrain numbers.", buttonCaption: "Close", controller: self)
                return false
            }
            else if(intent1.lowercased() != "intentional" || intent1.lowercased() != "reckless" || intent1.lowercased() != "knowing" || intent1.lowercased() != "negligent"){
                showMessage(message: "Please choose among the following intent inputs: \n Intentional\n Reckless\n Knowing\n Negligent\n", buttonCaption: "Try again", controller: self)
                return false
            }
            // make sure severity and remand only accept number values only
            else if(!severityNumberPredicate.evaluate(with: severity1)){
                showMessage(message: "Severity input should not contain a letter. Please choose from 1 (least severe) to 4 (most severe).", buttonCaption: "Close", controller: self)
                return false
            }
            else if(!remandNumberPredicate.evaluate(with: remand1TextField.text)){
                showMessage(message: "Remand should not contain a letter. Please input the duration the offender is in custody before sentence in months.", buttonCaption: "Close", controller: self)
                return false
            }
            // ===========================offence 2===========================
            else if(!characterPredicate.evaluate(with: offence2)){
                showMessage(message: "Offence input should not contain numbers.", buttonCaption: "Close", controller: self)
                return false
            }
            else if(!characterPredicate.evaluate(with: intent2)){
                showMessage(message: "Intent input should not conrain numbers.", buttonCaption: "Close", controller: self)
                return false
            }
            else if(intent2.lowercased() != "intentional" || intent2.lowercased() != "reckless" || intent2.lowercased() != "knowing" || intent2.lowercased() != "negligent"){
                showMessage(message: "Please choose among the following intent inputs: \n Intentional\n Reckless\n Knowing\n Negligent\n", buttonCaption: "Try again", controller: self)
                return false
            }
            // make sure severity and remand only accept number values only
            else if(!severityNumberPredicate.evaluate(with: severity2)){
                showMessage(message: "Severity input should not contain a letter. Please choose from 1 (least severe) to 4 (most severe).", buttonCaption: "Close", controller: self)
                return false
            }
            else if(!remandNumberPredicate.evaluate(with: remand2TextField.text)){
                showMessage(message: "Remand should not contain a letter. Please input the duration the offender is in custody before sentence in months.", buttonCaption: "Close", controller: self)
                return false
            }
        }
        else if(isOneOffence == false && isTwoOffences == false && isThreeOffences == true){
            // make offence, severity, and intent required but not allowing empty fields
            // ===========================offence 1===========================
            guard let offence1 = offence1TextField.text, !offence1.isEmpty else{
                return false
            }
            guard let severity1 = severity1TextField.text, !severity1.isEmpty else{
                return false
            }
            guard let intent1 = intent1TextField.text, !intent1.isEmpty else{
                return false
            }
            // ===========================offence 2===========================
            guard let offence2 = offence2TextField.text, !offence2.isEmpty else{
                return false
            }
            guard let severity2 = severity2TextField.text, !severity2.isEmpty else{
                return false
            }
            guard let intent2 = intent2TextField.text, !intent2.isEmpty else{
                return false
            }
            // ===========================offence 3===========================
            guard let offence3 = offence3TextField.text, !offence3.isEmpty else{
                return false
            }
            guard let severity3 = severity3TextField.text, !severity3.isEmpty else{
                return false
            }
            guard let intent3 = intent3TextField.text, !intent3.isEmpty else{
                return false
            }
            // ===========================offence 1===========================
            // make sure offence and intent only accept character values only
            if(!characterPredicate.evaluate(with: offence1)){
                showMessage(message: "Offence input should not contain numbers.", buttonCaption: "Close", controller: self)
                return false
            }
            else if(!characterPredicate.evaluate(with: intent1)){
                showMessage(message: "Intent input should not conrain numbers.", buttonCaption: "Close", controller: self)
                return false
            }
            else if(intent1.lowercased() != "intentional" || intent1.lowercased() != "reckless" || intent1.lowercased() != "knowing" || intent1.lowercased() != "negligent"){
                showMessage(message: "Please choose among the following intent inputs: \n Intentional\n Reckless\n Knowing\n Negligent\n", buttonCaption: "Try again", controller: self)
                return false
            }
            // make sure severity and remand only accept number values only
            else if(!severityNumberPredicate.evaluate(with: severity1)){
                showMessage(message: "Severity input should not contain a letter. Please choose from 1 (least severe) to 4 (most severe).", buttonCaption: "Close", controller: self)
                return false
            }
            else if(!remandNumberPredicate.evaluate(with: remand1TextField.text)){
                showMessage(message: "Remand should not contain a letter. Please input the duration the offender is in custody before sentence in months.", buttonCaption: "Close", controller: self)
                return false
            }
            // ===========================offence 2===========================
            else if(!characterPredicate.evaluate(with: offence2)){
                showMessage(message: "Offence input should not contain numbers.", buttonCaption: "Close", controller: self)
                return false
            }
            else if(!characterPredicate.evaluate(with: intent2)){
                showMessage(message: "Intent input should not conrain numbers.", buttonCaption: "Close", controller: self)
                return false
            }
            else if(intent2.lowercased() != "intentional" || intent2.lowercased() != "reckless" || intent2.lowercased() != "knowing" || intent2.lowercased() != "negligent"){
                showMessage(message: "Please choose among the following intent inputs: \n Intentional\n Reckless\n Knowing\n Negligent\n", buttonCaption: "Try again", controller: self)
                return false
            }
            // make sure severity and remand only accept number values only
            else if(!severityNumberPredicate.evaluate(with: severity2)){
                showMessage(message: "Severity input should not contain a letter. Please choose from 1 (least severe) to 4 (most severe).", buttonCaption: "Close", controller: self)
                return false
            }
            else if(!remandNumberPredicate.evaluate(with: remand2TextField.text)){
                showMessage(message: "Remand should not contain a letter. Please input the duration the offender is in custody before sentence in months.", buttonCaption: "Close", controller: self)
                return false
            }
            // ===========================offence 3===========================
            else if(!characterPredicate.evaluate(with: offence3)){
                showMessage(message: "Offence input should not contain numbers.", buttonCaption: "Close", controller: self)
                return false
            }
            else if(!characterPredicate.evaluate(with: intent3)){
                showMessage(message: "Intent input should not conrain numbers.", buttonCaption: "Close", controller: self)
                return false
            }
            else if(intent3.lowercased() != "intentional" || intent3.lowercased() != "reckless" || intent3.lowercased() != "knowing" || intent3.lowercased() != "negligent"){
                showMessage(message: "Please choose among the following intent inputs: \n Intentional\n Reckless\n Knowing\n Negligent\n", buttonCaption: "Try again", controller: self)
                return false
            }
            // make sure severity and remand only accept number values only
            else if(!severityNumberPredicate.evaluate(with: severity3)){
                showMessage(message: "Severity input should not contain a letter. Please choose from 1 (least severe) to 4 (most severe).", buttonCaption: "Close", controller: self)
                return false
            }
            else if(!remandNumberPredicate.evaluate(with: remand3TextField.text)){
                showMessage(message: "Remand should not contain a letter. Please input the duration the offender is in custody before sentence in months.", buttonCaption: "Close", controller: self)
                return false
            }
        }
        else{
            showMessage(message: "Something went wrong with validForm function", buttonCaption: "Close", controller: self)
        }
        
        return true
    }
    // ========================FORM========================
    
    // MARK: setUp
    func setUp(){
        // hide views
        offence2View.isHidden = true
        addOffence3View.isHidden = true
        offence3View.isHidden = true
        
        // set view tags to 1 to avoid double clicking action issue
        offence2View.tag = 1
        offence3View.tag = 1
        
        // keyboard setup
        offence1TextField.delegate = self
        offence2TextField.delegate = self
        offence3TextField.delegate = self
        
        severity1TextField.delegate = self
        severity2TextField.delegate = self
        severity3TextField.delegate = self
        
        intent1TextField.delegate = self
        intent2TextField.delegate = self
        intent3TextField.delegate = self
        
        remand1TextField.delegate = self
        remand2TextField.delegate = self
        remand3TextField.delegate = self
    }
}
