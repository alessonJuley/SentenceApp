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
    
    // ==================FOR TESTING==================
    var offence2ViewTag: Int = 1
    var offence3ViewTag: Int = 1
    // ==================FOR TESTING==================
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUp()
    }
    
    // MARK: Actions
    @IBAction func addOffence2(_ sender: UIButton) {
        isOneOffence = false
        isTwoOffences = true
        isThreeOffences = false
        
        print("==================FOR TESTING==================")
        print("addOffence2 button is PRESSED")
        print("isOneOffence: \(isOneOffence)\n isTwoOffences: \(isTwoOffences)\n isThreeOffences: \(isThreeOffences)")
        print("offence2ViewTag: \(offence2ViewTag)")    // output: 1
        print("offence3ViewTag: \(offence3ViewTag)")    // output: 1
        print("==================FOR TESTING==================")
        
        if(offence2View.tag == 1){
            offence2View.tag = 0
            // ==================FOR TESTING==================
            offence2ViewTag = 0
            // ==================FOR TESTING==================
            
            print("==================Add offence 2 tag == 1==================")
            print("isOneOffence: \(isOneOffence)\n isTwoOffences: \(isTwoOffences)\n isThreeOffences: \(isThreeOffences)")
            print("offence2ViewTag: \(offence2ViewTag)")    // output: 0
            print("offence3ViewTag: \(offence3ViewTag)")    // output: 1
            print("offence2View.isHidden = false")
            print("What happened: show input for offence 2, change addOffence2Button button to remove offence, and show addOffence3Button button")
            print("==================Add offence 2 tag == 1==================")
            
            offence2View.isHidden = false
            addOffence2Button.tintColor = UIColor.systemRed
            addOffence2Button.setTitle("Remove second offence", for: .normal)
            addOffence2Button.setImage(UIImage(systemName: "minus"), for: .normal)
            
            addOffence3View.isHidden = false
        }
        else if(offence2View.tag == 0){
            offence2View.tag = 1
            // ==================FOR TESTING==================
            offence2ViewTag = 1
            // ==================FOR TESTING==================
            
            print("==================FOR TESTING==================")
            print("addOffence2 button is PRESSED")
            print("isOneOffence: \(isOneOffence)\n isTwoOffences: \(isTwoOffences)\n isThreeOffences: \(isThreeOffences)")
            print("offence2ViewTag: \(offence2ViewTag)")    // output: 1
            print("offence3ViewTag: \(offence3ViewTag)")    // output: 1
            print("What happened: hide input for offence 2, change addOffence2Button button to add offence, and hide addOffence3Button button")
            print("==================FOR TESTING==================")
            
            offence2View.isHidden = true
            addOffence2Button.tintColor = UIColor.systemBlue
            addOffence2Button.setTitle("Add second offence", for: .normal)
            addOffence2Button.setImage(UIImage(systemName: "plus"), for: .normal)
            
            addOffence3View.isHidden = true
        }
        else{
            showMessage(message: "Something went wrong with addOffence2 action.", buttonCaption: "Close", controller: self)
        }
    }
    
    @IBAction func addOffence3(_ sender: UIButton) {
        isOneOffence = false
        isTwoOffences = false
        isThreeOffences = true
        
        print("==================FOR TESTING==================")
        print("addOffence3 button is PRESSED")
        print("isOneOffence: \(isOneOffence)\n isTwoOffences: \(isTwoOffences)\n isThreeOffences: \(isThreeOffences)")
        print("offence2ViewTag: \(offence2ViewTag)")    // output: 1
        print("offence3ViewTag: \(offence3ViewTag)")    // output: 1
        print("==================FOR TESTING==================")
        
        // add frontend stuff
    }
    
    @IBAction func recommendOutput(_ sender: UIButton) {
        if(isOneOffence == true && isTwoOffences == false && isThreeOffences == false){
            if(validForm()){
                // input
                let offence1 = offence1TextField.text!
                let severity1 = Int(severity1TextField.text!) ?? 0
                let intent1 = intent1TextField.text!
                let remand1 = Int(remand1TextField.text!) ?? 0
                
                // recommend sentence
                let sentenceRecommend1 = sentenceModel(offence: offence1, severity: severity1, intent: intent1)!.sentence
                
                print("==================FOR TESTING==================")
                let sentenceProbabilityRecommend1 = sentenceModel(offence: offence1, severity: severity1, intent: intent1)!.sentenceProbability
                let sentenceFeatureNamesRecommend1 = sentenceModel(offence: offence1, severity: severity1, intent: intent1)!.featureNames
                print("recommendOutput button is PRESSED")
                print("inside sentence recommend 1")
                print("isOneOffence: \(isOneOffence)\n isTwoOffences: \(isTwoOffences)\n isThreeOffences: \(isThreeOffences)")
                print("offence2ViewTag: \(offence2ViewTag)")
                print("offence3ViewTag: \(offence3ViewTag) \n")
                print("sentenceRecommend1: \(sentenceRecommend1) \n")
                print("sentenceProbabilityRecommend1: \(sentenceProbabilityRecommend1) \n")
                print("sentenceFeatureNamesRecommend1: \(sentenceFeatureNamesRecommend1) \n")
                print("==================FOR TESTING==================")
                
                // check if sentence is fined or not so you select different targets and use different models
                if(sentenceRecommend1 != "Fined"){
                    let durationRecommend1 = durationModel(severity: severity1, remandDuration: remand1, sentence: sentenceRecommend1, sentenceType: "Single")!.totalDuration
                    
                    print("==================FOR TESTING==================")
                    let durationFeatureNamesRecommend1 = durationModel(severity: severity1, remandDuration: remand1, sentence: sentenceRecommend1, sentenceType: "Single")!.featureNames
                    print("inside sentence recommend 1 != fined")
                    print("durationRecommend1: \(durationRecommend1)")
                    print("durationFeatureNamesRecommend1: \(durationFeatureNamesRecommend1)")
                    print("==================FOR TESTING==================")
                    
                    outputTextView.text = "Sentence: " + sentenceRecommend1 + "\t\t" + String(format: "%.2f", durationRecommend1) + " months"
                }
                else{
                    let fineRecommend1 = fineModel(offence: offence1, severity: severity1, intent: intent1, sentence: sentenceRecommend1, sentenceType: "Single")!.fineAmount
                    
                    print("==================FOR TESTING==================")
                    let fineFeatureNamesRecommend1 = fineModel(offence: offence1, severity: severity1, intent: intent1, sentence: sentenceRecommend1, sentenceType: "Single")!.featureNames
                    print("inside sentence recommend 1 == fined")
                    print("fineRecommend1: \(fineRecommend1)")
                    print("fineFeatureNamesRecommend1: \(fineFeatureNamesRecommend1)")
                    print("==================FOR TESTING==================")
                    
                    outputTextView.text = "Sentence: " + sentenceRecommend1 + "\t\t" + "Amount: $" + String(format: "%.2f", fineRecommend1)
                }
                
                resetForm()
            }
            else{
                showMessage(message: "Invalid isOneOffence form", buttonCaption: "Try again", controller: self)
            }
        }
        else if(isOneOffence == false && isTwoOffences == true && isThreeOffences == false){
            if(validForm()){
                
            }
            else{
                showMessage(message: "Invalid isTwoOffences form", buttonCaption: "Try again", controller: self)
            }
        }
        else if(isOneOffence == false && isTwoOffences == false && isThreeOffences == true){
            if(validForm()){
                
            }
            else{
                showMessage(message: "Invalid isThreeOffences form", buttonCaption: "Try again", controller: self)
            }
        }
        else{
            showMessage(message: "Uh-oh! It seems there's an issue with your submission. \n\nPlease review the form and ensure the information in the text box is accurate and complete.", buttonCaption: "Try again", controller: self)
        }
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
    // MARK: Form validations
    // ========================FORM========================
    func validForm() -> Bool{
        let characterRegEx = "^[a-zA-Z ]*$"
        let characterPredicate = NSPredicate(format: "SELF MATCHES %@", characterRegEx)
        
        let severityNumberRegEx = "[1-4]"
        let severityNumberPredicate = NSPredicate(format: "SELF MATCHES %@", severityNumberRegEx)
        
        let numberRegEx = #"^[0-9]*(\.[0-9]+)?$"#
        let numberPredicate = NSPredicate(format: "SELF MATCHES %@", numberRegEx)
        
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
            
            if(!characterPredicate.evaluate(with: offence1)){
                showMessage(message: "[isOneOffence] Offence1 input should only contain letters.", buttonCaption: "Close", controller: self)
                
                return false
            }
            else if(!severityNumberPredicate.evaluate(with: severity1)){
                showMessage(message: "[isOneOffence] Severity1 input should not contain a letter. Please choose from 1 (least severe) to 4 (most severe).", buttonCaption: "Close", controller: self)
                
                return false
            }
            else if(intent1.lowercased() != "intentional" && intent1.lowercased() != "reckless" && intent1.lowercased() != "knowing" && intent1.lowercased() != "negligent"){
                showMessage(message: "[isOneOffence] Please choose among the following intent1 inputs: \n Intentional\n Reckless\n Knowing\n Negligent\n", buttonCaption: "Try again", controller: self)
                
                return false
            }
            else if(!numberPredicate.evaluate(with: remand1TextField.text)){
                showMessage(message: "[isOneOffence] Remand1 should not contain a letter. Please input the duration the offender is in custody before sentence in months.", buttonCaption: "Close", controller: self)
                
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
            if(!characterPredicate.evaluate(with: offence1)){
                showMessage(message: "[isTwoOffences] Offence1 input should only contain letters.", buttonCaption: "Close", controller: self)
                
                return false
            }
            else if(!severityNumberPredicate.evaluate(with: severity1)){
                showMessage(message: "[isTwoOffences] Severity1 input should not contain a letter. Please choose from 1 (least severe) to 4 (most severe).", buttonCaption: "Close", controller: self)
                
                return false
            }
            else if(intent1.lowercased() != "intentional" && intent1.lowercased() != "reckless" && intent1.lowercased() != "knowing" && intent1.lowercased() != "negligent"){
                showMessage(message: "[isTwoOffences] Please choose among the following intent1 inputs: \n Intentional\n Reckless\n Knowing\n Negligent\n", buttonCaption: "Try again", controller: self)
                
                return false
            }
            else if(!numberPredicate.evaluate(with: remand1TextField.text)){
                showMessage(message: "[isTwoOffences] Remand1 should not contain a letter. Please input the duration the offender is in custody before sentence in months.", buttonCaption: "Close", controller: self)
                
                return false
            }
            // ===========================offence 2===========================
            else if(!characterPredicate.evaluate(with: offence2)){
                showMessage(message: "[isTwoOffences] Offence2 input should only contain letters.", buttonCaption: "Close", controller: self)
                
                return false
            }
            else if(!severityNumberPredicate.evaluate(with: severity2)){
                showMessage(message: "[isTwoOffences] Severity2 input should not contain a letter. Please choose from 1 (least severe) to 4 (most severe).", buttonCaption: "Close", controller: self)
                
                return false
            }
            else if(intent2.lowercased() != "intentional" && intent2.lowercased() != "reckless" && intent2.lowercased() != "knowing" && intent2.lowercased() != "negligent"){
                showMessage(message: "[isTwoOffences] Please choose among the following intent2 inputs: \n Intentional\n Reckless\n Knowing\n Negligent\n", buttonCaption: "Try again", controller: self)
                
                return false
            }
            else if(!numberPredicate.evaluate(with: remand2TextField.text)){
                showMessage(message: "[isTwoOffences] Remand2 should not contain a letter. Please input the duration the offender is in custody before sentence in months.", buttonCaption: "Close", controller: self)
                
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
            if(!characterPredicate.evaluate(with: offence1)){
                showMessage(message: "[isThreeOffences] Offence1 input should only contain letters.", buttonCaption: "Close", controller: self)
                
                return false
            }
            else if(!severityNumberPredicate.evaluate(with: severity1)){
                showMessage(message: "[isThreeOffences] Severity1 input should not contain a letter. Please choose from 1 (least severe) to 4 (most severe).", buttonCaption: "Close", controller: self)
                
                return false
            }
            else if(intent1.lowercased() != "intentional" && intent1.lowercased() != "reckless" && intent1.lowercased() != "knowing" && intent1.lowercased() != "negligent"){
                showMessage(message: "[isThreeOffences] Please choose among the following intent1 inputs: \n Intentional\n Reckless\n Knowing\n Negligent\n", buttonCaption: "Try again", controller: self)
                
                return false
            }
            else if(!numberPredicate.evaluate(with: remand1TextField.text)){
                showMessage(message: "[isThreeOffences] Remand1 should not contain a letter. Please input the duration the offender is in custody before sentence in months.", buttonCaption: "Close", controller: self)
                
                return false
            }
            // ===========================offence 2===========================
            else if(!characterPredicate.evaluate(with: offence2)){
                showMessage(message: "[isThreeOffences] Offence2 input should only contain letters.", buttonCaption: "Close", controller: self)
                
                return false
            }
            else if(!severityNumberPredicate.evaluate(with: severity2)){
                showMessage(message: "[isThreeOffences] Severity2 input should not contain a letter. Please choose from 1 (least severe) to 4 (most severe).", buttonCaption: "Close", controller: self)
                
                return false
            }
            else if(intent2.lowercased() != "intentional" && intent2.lowercased() != "reckless" && intent2.lowercased() != "knowing" && intent2.lowercased() != "negligent"){
                showMessage(message: "[isThreeOffences] Please choose among the following intent2 inputs: \n Intentional\n Reckless\n Knowing\n Negligent\n", buttonCaption: "Try again", controller: self)
                
                return false
            }
            else if(!numberPredicate.evaluate(with: remand2TextField.text)){
                showMessage(message: "[isThreeOffences] Remand2 should not contain a letter. Please input the duration the offender is in custody before sentence in months.", buttonCaption: "Close", controller: self)
                
                return false
            }
            // ===========================offence 3===========================
            else if(!characterPredicate.evaluate(with: offence3)){
                showMessage(message: "[isThreeOffences] Offence3 input should only contain letters.", buttonCaption: "Close", controller: self)
                
                return false
            }
            else if(!severityNumberPredicate.evaluate(with: severity3)){
                showMessage(message: "[isThreeOffences] Severity3 input should not contain a letter. Please choose from 1 (least severe) to 4 (most severe).", buttonCaption: "Close", controller: self)
                
                return false
            }
            else if(intent3.lowercased() != "intentional" && intent3.lowercased() != "reckless" && intent3.lowercased() != "knowing" && intent3.lowercased() != "negligent"){
                showMessage(message: "[isThreeOffences] Please choose among the following intent3 inputs: \n Intentional\n Reckless\n Knowing\n Negligent\n", buttonCaption: "Try again", controller: self)
                
                return false
            }
            else if(!numberPredicate.evaluate(with: remand3TextField.text)){
                showMessage(message: "[isThreeOffences] Remand3 should not contain a letter. Please input the duration the offender is in custody before sentence in months.", buttonCaption: "Close", controller: self)
                
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
        
        print("==================FOR TESTING==================")
        print("inside setUp function")
        print("offence2ViewTag: \(offence2ViewTag)")    // output: 1
        print("offence3ViewTag: \(offence3ViewTag)")    // output: 1
        print("==================FOR TESTING==================")
        
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
    
    func resetForm(){
        offence1TextField.text = nil
        offence2TextField.text = nil
        offence3TextField.text = nil
        
        severity1TextField.text = nil
        severity2TextField.text = nil
        severity3TextField.text = nil
        
        intent1TextField.text = nil
        intent2TextField.text = nil
        intent3TextField.text = nil
        
        remand1TextField.text = nil
        remand2TextField.text = nil
        remand3TextField.text = nil
    }
}
