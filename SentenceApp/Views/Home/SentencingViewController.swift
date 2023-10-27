//
//  SentencingViewController.swift
//  SentenceApp
//
//  Created by Alesson Abao on 21/09/23.
//

import UIKit
import DropDown

class SentencingViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: Outlets
    @IBOutlet weak var offence1TextField: UITextField!
    @IBOutlet weak var severity1View: UIView!
    @IBOutlet weak var severity1Label: UILabel!
    @IBOutlet weak var intent1View: UIView!
    @IBOutlet weak var intent1Label: UILabel!
    @IBOutlet weak var remand1TextField: UITextField!
    
    @IBOutlet weak var actionOffenceButton: UIButton!
    
    @IBOutlet weak var offence2View: UIView!
    @IBOutlet weak var offence2TextField: UITextField!
    @IBOutlet weak var severity2View: UIView!
    @IBOutlet weak var severity2Label: UILabel!
    @IBOutlet weak var intent2View: UIView!
    @IBOutlet weak var intent2Label: UILabel!
    @IBOutlet weak var remand2TextField: UITextField!
    
    @IBOutlet weak var recommendTextView: UITextView!
    
    // MARK: variables
    var isOneOffence: Bool = true
    var isTwoOffences: Bool = false
    var showForm2: Bool = false
    
    // MARK: Dropdown variables
    let severity1Drop = DropDown()
    let intent1Drop = DropDown()
    let severity2Drop = DropDown()
    let intent2Drop = DropDown()
    
    let severity1Array = ["1", "2", "3", "4"]
    let intent1Array = ["Intentional", "Reckless", "Knowing", "Negligent"]
    let severity2Array = ["1", "2", "3", "4"]
    let intent2Array = ["Intentional", "Reckless", "Knowing", "Negligent"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUp()
    }
    
    // MARK: DropDown actions
    @IBAction func showSeverity1Options(_ sender: Any) {
        severity1Drop.show()
    }
    
    @IBAction func showIntent1Options(_ sender: Any) {
        intent1Drop.show()
    }
    
    @IBAction func showSeverity2Options(_ sender: Any) {
        severity2Drop.show()
    }
    
    @IBAction func showIntent2Options(_ sender: Any) {
        intent2Drop.show()
    }
    
    // MARK: actionOffence
    @IBAction func offence2Action(_ sender: UIButton) {
        if(offence2View.isHidden == true){
            actionOffenceButton.configuration?.baseForegroundColor = UIColor.systemRed
            actionOffenceButton.setTitle("Remove offence", for: .normal)
            actionOffenceButton.setImage(UIImage(systemName: "minus"), for: .normal)
            
            isOneOffence = false
            isTwoOffences = true
            offence2View.isHidden = false
        }
        else{
            actionOffenceButton.configuration?.baseForegroundColor = UIColor(hex: "#AB8E63")
            actionOffenceButton.setTitle("Add another offence", for: .normal)
            actionOffenceButton.setImage(UIImage(systemName: "plus"), for: .normal)
            
            isOneOffence = true
            isTwoOffences = false
            offence2View.isHidden = true
            
            resetForm()
        }
    }
    
    // MARK: Recommend
    @IBAction func recommendButton(_ sender: UIButton) {
        print("===============================================")
        print("❗️recommendButton PRESSED❗️")
        print("===============================================")
        
        // MARK: isOneOffence
        if(isOneOffence == true && isTwoOffences == false){
            if(checkForm() == true){
                let offenceInput = offence1TextField.text!
                let severityInput = Int(severity1Label.text!) ?? 1
                let intentInput = intent1Label.text!
                let remandInput = Int(remand1TextField.text!) ?? 0
                
                let sentenceRecommend = sentenceModel(offence: offenceInput, severity: severityInput, intent: intentInput)!.sentence
                
                // check if sentence is fined or not
                if(sentenceRecommend != "Fined"){
//                    let durationRecommend = durationModel(severity: severityInput, remandDuration: remandInput, sentence: sentenceRecommend, sentenceType: "Single")!.totalDuration
                    
                    let durationRecommend = durationModel(offence: offenceInput, severity: severityInput, intent: intentInput, remandDuration: remandInput, sentence: sentenceRecommend, sentenceType: "Single")!.sentenceDuration
                    
                    recommendTextView.text = "Sentence: " + sentenceRecommend + "\t\t" + String(format: "%.2f", durationRecommend) + " months"
                }
                else{
//                    let fineRecommend = fineModel(offence: offenceInput, severity: severityInput, intent: intentInput, sentence: sentenceRecommend, sentenceType: "Single")!.fineAmount
                    
                    let fineRecommend = fineModel(offence: offenceInput, severity: severityInput, intent: intentInput, sentence: sentenceRecommend, sentenceType: "Single")!.finesAmount
                    
                    recommendTextView.text = "Sentence: " + sentenceRecommend + "\t" + "Amount: $" + String(format: "%.2f", fineRecommend)
                }
                resetForm()
            }
            else{
                showMessage(message: "Uh-oh! It seems there's an issue with your submission. \n\nPlease review the form and ensure the information in the text box is accurate and complete.",  controller: self)
            }
        }
        // MARK: isTwoOffences
        else if(isOneOffence == false && isTwoOffences == true){
            if(checkForm() == true){
                let offenceInput1 = offence1TextField.text!
                let severityInput1 = Int(severity1Label.text!) ?? 1
                let intentInput1 = intent1Label.text!
                let remandInput1 = Int(remand1TextField.text!) ?? 0
                
                let offenceInput2 = offence2TextField.text!
                let severityInput2 = Int(severity2Label.text!) ?? 1
                let intentInput2 = intent2Label.text!
                let remandInput2 = Int(remand2TextField.text!) ?? 0
                
                let sentenceRecommend1 = sentenceModel(offence: offenceInput1, severity: severityInput1, intent: intentInput1)!.sentence
                let sentenceRecommend2 = sentenceModel2(offence: offenceInput2, severity: severityInput2, intent: intentInput2)!.sentence
                
                print("=========================================")
                print("offenceInput1: \(offenceInput1)")
                print("severityInput1: \(severityInput1)")
                print("intentInput1: \(intentInput1)")
                print("remandInput1: \(remandInput1)\n")
                print("offenceInput2: \(offenceInput2)")
                print("severityInput2: \(severityInput2)")
                print("intentInput2: \(intentInput2)")
                print("remandInput2: \(remandInput2)\n")
                print("sentenceRecommend1: \(sentenceRecommend1)")
                print("sentenceRecommend2: \(sentenceRecommend2)")
                print("=========================================")
                
                // check if both offences are in the same level of severity
                if(severityInput1 == severityInput2){
                    if(sentenceRecommend1 != "Fined" && sentenceRecommend2 != "Fined"){
//                        let durationRecommend1 = durationModel(severity: severityInput1, remandDuration: remandInput1, sentence: sentenceRecommend1, sentenceType: "Concurrent")!.totalDuration
//                        let durationRecommend2 = durationModel(severity: severityInput2, remandDuration: remandInput2, sentence: sentenceRecommend2, sentenceType: "Concurrent")!.totalDuration
//                        var totalDuration = abs(durationRecommend1)
                        
                        let durationRecommend1 = durationModel(offence: offenceInput1, severity: severityInput1, intent: intentInput1, remandDuration: remandInput1, sentence: sentenceRecommend1, sentenceType: "Concurrent")!.sentenceDuration
                        let durationRecommend2 = durationModel2(offence: offenceInput2, severity: severityInput2, intent: intentInput2, remandDuration: remandInput2, sentence: sentenceRecommend2, sentenceType: "Concurrent")!.sentenceDuration
                        var totalDuration = durationRecommend1
                        
                        if(durationRecommend1 < durationRecommend2){
                            totalDuration += durationRecommend2
                        }
                        
                        recommendTextView.text = "Sentence 1: " + sentenceRecommend1 + "\t" + String(format: "%.2f", durationRecommend1) + " months" + "\nSentence 2: "  + sentenceRecommend2 + "\t" + String(format: "%.2f", durationRecommend2) + " months\n" + "Total duration: " + String(format: "%.2f", totalDuration) + " months" + "\n\nSentence type: Concurrent"
                    }
                    else if(sentenceRecommend1 == "Fined" && sentenceRecommend2 != "Fined"){
//                        let fineRecommend1 = fineModel(offence: offenceInput1, severity: severityInput1, intent: intentInput1, sentence: sentenceRecommend1, sentenceType: "Concurrent")!.fineAmount
//                        let durationRecommend2 = durationModel(severity: severityInput2, remandDuration: remandInput2, sentence: sentenceRecommend2, sentenceType: "Concurrent")!.totalDuration
                        
                        let fineRecommend1 = fineModel(offence: offenceInput1, severity: severityInput1, intent: intentInput1, sentence: sentenceRecommend1, sentenceType: "Concurrent")!.finesAmount
                        let durationRecommend2 = durationModel(offence: offenceInput2, severity: severityInput2, intent: intentInput2, remandDuration: remandInput2, sentence: sentenceRecommend2, sentenceType: "Concurrent")!.sentenceDuration
                        
                        recommendTextView.text = "Sentence 1: " + sentenceRecommend1 + "\t" + "Amount: $" + String(format: "%.2f", fineRecommend1) + "\nSentence 2: " + sentenceRecommend2 + "\t" + String(format: "%.2f", durationRecommend2) + "\n\nSentence type: Concurrent"
                    }
                    else if(sentenceRecommend1 != "Fined" && sentenceRecommend2 == "Fined"){
//                        let durationRecommend1 = durationModel(severity: severityInput1, remandDuration: remandInput1, sentence: sentenceRecommend1, sentenceType: "Concurrent")!.totalDuration
//                        let fineRecommend2 = fineModel(offence: offenceInput2, severity: severityInput2, intent: intentInput2, sentence: sentenceRecommend2, sentenceType: "Concurrent")!.fineAmount
                        
                        let durationRecommend1 = durationModel(offence: offenceInput1, severity: severityInput1, intent: intentInput1, remandDuration: remandInput1, sentence: sentenceRecommend1, sentenceType: "Concurrent")!.sentenceDuration
                        let fineRecommend2 = fineModel(offence: offenceInput2, severity: severityInput2, intent: intentInput2, sentence: sentenceRecommend2, sentenceType: "Concurrent")!.finesAmount
                        
                        recommendTextView.text = "Sentence 1: " + sentenceRecommend1 + "\t" + String(format: "%.2f", durationRecommend1) + " months" + "\nSentence 2: " + sentenceRecommend2 + "\t" + "Amount: $" + String(format: "%.2f", fineRecommend2) + "\n\nSentence type: Concurrent"
                    }
                    else{
//                        let fineRecommend1 = fineModel(offence: offenceInput1, severity: severityInput1, intent: intentInput1, sentence: sentenceRecommend1, sentenceType: "Concurrent")!.fineAmount
//                        let fineRecommend2 = fineModel(offence: offenceInput2, severity: severityInput2, intent: intentInput2, sentence: sentenceRecommend2, sentenceType: "Concurrent")!.fineAmount
//                        let totalFines = fineRecommend1 + fineRecommend2
                        let fineRecommend1 = fineModel(offence: offenceInput1, severity: severityInput1, intent: intentInput1, sentence: sentenceRecommend1, sentenceType: "Concurrent")!.finesAmount
                        let fineRecommend2 = fineModel2(offence: offenceInput2, severity: severityInput2, intent: intentInput2, sentence: sentenceRecommend2, sentenceType: "Concurrent")!.finesAmount
                        let totalFines = fineRecommend1 + fineRecommend2
                        
                        recommendTextView.text = "Sentence 1: " + sentenceRecommend1 + "\t" + "Amount: $" + String(format: "%.2f", fineRecommend1) + "\nSentence 2: " + sentenceRecommend2 + "\t" + "Amount: $" + String(format: "%.2f", fineRecommend2) + "\n\nTotal fines: $" + String(format: "%.2f", totalFines) 
                    }
                }
                else{
                    if(sentenceRecommend1 != "Fined" && sentenceRecommend2 != "Fined"){
//                        let durationRecommend1 = durationModel(severity: severityInput1, remandDuration: remandInput1, sentence: sentenceRecommend1, sentenceType: "Cumulative")!.totalDuration
//                        let durationRecommend2 = durationModel(severity: severityInput2, remandDuration: remandInput2, sentence: sentenceRecommend2, sentenceType: "Cumulative")!.totalDuration
                        let durationRecommend1 = durationModel(offence: offenceInput1, severity: severityInput1, intent: intentInput1, remandDuration: remandInput1, sentence: sentenceRecommend1, sentenceType: "Cumulative")!.sentenceDuration
                        let durationRecommend2 = durationModel2(offence: offenceInput2, severity: severityInput2, intent: intentInput2, remandDuration: remandInput2, sentence: sentenceRecommend2, sentenceType: "Cumulative")!.sentenceDuration
                        
                        var totalDuration = durationRecommend1 + durationRecommend2
                        
                        
                        recommendTextView.text = "Sentence 1: " + sentenceRecommend1 + "\t" + String(format: "%.2f", durationRecommend1) + " months" + "\nSentence 2: "  + sentenceRecommend2 + "\t" + String(format: "%.2f", durationRecommend2) + " months\n" + "Total duration: " + String(format: "%.2f", totalDuration) + " months" + "\n\nSentence type: Cumulative"
                    }
                    else if(sentenceRecommend1 == "Fined" && sentenceRecommend2 != "Fined"){
//                        let fineRecommend1 = fineModel(offence: offenceInput1, severity: severityInput1, intent: intentInput1, sentence: sentenceRecommend1, sentenceType: "Cumulative")!.fineAmount
//                        let durationRecommend2 = durationModel(severity: severityInput2, remandDuration: remandInput2, sentence: sentenceRecommend2, sentenceType: "Cumulative")!.totalDuration
                        
                        let fineRecommend1 = fineModel(offence: offenceInput1, severity: severityInput1, intent: intentInput1, sentence: sentenceRecommend1, sentenceType: "Cumulative")!.finesAmount
                        let durationRecommend2 = durationModel(offence: offenceInput2, severity: severityInput2, intent: intentInput2, remandDuration: remandInput2, sentence: sentenceRecommend2, sentenceType: "Cumulative")!.sentenceDuration
                        
                        recommendTextView.text = "Sentence 1: " + sentenceRecommend1 + "\t" + "Amount: $" + String(format: "%.2f", fineRecommend1) + "\nSentence 2: " + sentenceRecommend2 + "\t" + String(format: "%.2f", durationRecommend2) + "\n\nSentence type: Cumulative"
                    }
                    else if(sentenceRecommend1 != "Fined" && sentenceRecommend2 == "Fined"){
//                        let durationRecommend1 = durationModel(severity: severityInput1, remandDuration: remandInput1, sentence: sentenceRecommend1, sentenceType: "Cumulative")!.totalDuration
//                        let fineRecommend2 = fineModel(offence: offenceInput2, severity: severityInput2, intent: intentInput2, sentence: sentenceRecommend2, sentenceType: "Cumulative")!.fineAmount
                        
                        let durationRecommend1 = durationModel(offence: offenceInput1, severity: severityInput1, intent: intentInput1, remandDuration: remandInput1, sentence: sentenceRecommend1, sentenceType: "Cumulative")!.sentenceDuration
                        let fineRecommend2 = fineModel(offence: offenceInput2, severity: severityInput2, intent: intentInput2, sentence: sentenceRecommend2, sentenceType: "Cumulative")!.finesAmount
                        
                        recommendTextView.text = "Sentence 1: " + sentenceRecommend1 + "\t" + String(format: "%.2f", durationRecommend1) + " months" + "\nSentence 2: " + sentenceRecommend2 + "\t" + "Amount: $" + String(format: "%.2f", fineRecommend2) + "\n\nSentence type: Cumulative"
                    }
                    else{
//                        let fineRecommend1 = fineModel(offence: offenceInput1, severity: severityInput1, intent: intentInput1, sentence: sentenceRecommend1, sentenceType: "Cumulative")!.fineAmount
//                        let fineRecommend2 = fineModel(offence: offenceInput2, severity: severityInput2, intent: intentInput2, sentence: sentenceRecommend2, sentenceType: "Cumulative")!.fineAmount
                        let fineRecommend1 = fineModel(offence: offenceInput1, severity: severityInput1, intent: intentInput1, sentence: sentenceRecommend1, sentenceType: "Cumulative")!.finesAmount
                        let fineRecommend2 = fineModel2(offence: offenceInput2, severity: severityInput2, intent: intentInput2, sentence: sentenceRecommend2, sentenceType: "Cumulative")!.finesAmount
                        
                        let totalFines = fineRecommend1 + fineRecommend2
                        
                        recommendTextView.text = "Sentence 1: " + sentenceRecommend1 + "\t" + "Amount: $" + String(format: "%.2f", fineRecommend1) + "\nSentence 2: " + sentenceRecommend2 + "\t" + "Amount: $" + String(format: "%.2f", fineRecommend2) + "\n\nTotal fines: $" + String(format: "%.2f", totalFines)
                    }
                }
                resetForm()
            }
            else{
                showMessage(message: "Uh-oh! It seems there's an issue with your submission. \n\nPlease review the form and ensure the information in the text box is accurate and complete.",  controller: self)
            }
        }
        else{
            showMessage(message: "Oops! Something went wrong with the form.", controller: self)
        }
    }
    
    // MARK: setUp
    func setUp(){
        offence2View.isHidden = true
        showForm2 = true
        
        // dropdowns
        DropDown.appearance().textFont = UIFont.systemFont(ofSize: 20)
        
        severity1Drop.anchorView = severity1View
        severity1Drop.dataSource = severity1Array
        severity1Drop.bottomOffset = CGPoint(x: 0, y: (severity1Drop.anchorView?.plainView.bounds.height)!)
        severity1Drop.topOffset = CGPoint(x: 0, y: -(severity1Drop.anchorView?.plainView.bounds.height)!)
        severity1Drop.direction = .bottom
        severity1Drop.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.severity1Label.text = severity1Array[index]
        }
        
        
        intent1Drop.anchorView = intent1View
        intent1Drop.dataSource = intent1Array
        intent1Drop.bottomOffset = CGPoint(x: 0, y: (intent1Drop.anchorView?.plainView.bounds.height)!)
        intent1Drop.topOffset = CGPoint(x: 0, y: -(intent1Drop.anchorView?.plainView.bounds.height)!)
        intent1Drop.direction = .bottom
        intent1Drop.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.intent1Label.text = intent1Array[index]
        }
        
        severity2Drop.anchorView = severity2View
        severity2Drop.dataSource = severity2Array
        severity2Drop.bottomOffset = CGPoint(x: 0, y: (severity2Drop.anchorView?.plainView.bounds.height)!)
        severity2Drop.topOffset = CGPoint(x: 0, y: -(severity2Drop.anchorView?.plainView.bounds.height)!)
        severity2Drop.direction = .bottom
        severity2Drop.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.severity2Label.text = severity2Array[index]
        }
        
        intent2Drop.anchorView = intent2View
        intent2Drop.dataSource = intent2Array
        intent2Drop.bottomOffset = CGPoint(x: 0, y: (intent2Drop.anchorView?.plainView.bounds.height)!)
        intent2Drop.topOffset = CGPoint(x: 0, y: -(intent2Drop.anchorView?.plainView.bounds.height)!)
        intent2Drop.direction = .bottom
        intent2Drop.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.intent2Label.text = intent2Array[index]
        }
        
        // keyboard
        offence1TextField.delegate = self
        remand1TextField.delegate = self
        offence2TextField.delegate = self
        remand2TextField.delegate = self
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
    
    // MARK: resetForm()
    func resetForm(){
        if(isOneOffence == true && offence2View.isHidden == true){
            offence2TextField.text = nil
            severity2Label.text = "Select severity"
            intent2Label.text = "Select intent"
            remand2TextField.text = nil
        }
//        else{
//            offence1TextField.text = nil
//            severity1Label.text = "Select severity"
//            intent1Label.text = "Select intent"
//            remand1TextField.text = nil
//
//            offence2TextField.text = nil
//            severity2Label.text = "Select severity"
//            intent2Label.text = "Select intent"
//            remand2TextField.text = nil
//        }
    }
    
    // MARK: checkForm()
    func checkForm() -> Bool{
        let characterRegEx = "^[a-zA-Z ]*$"
        let characterPredicate = NSPredicate(format: "SELF MATCHES %@", characterRegEx)
        
        let numberRegEx = #"^[0-9]*(\.[0-9]+)?$"#
        let numberPredicate = NSPredicate(format: "SELF MATCHES %@", numberRegEx)
        
        let randomInput = "asdfqwerzxcv"
        
        let randomRegEx1 = "^[asdfASDF]*$"
        let randomPredicate1 = NSPredicate(format: "SELF MATCHES %@", randomRegEx1)
        let randomRegEx2 = "^[zxcvZXCV]*$"
        let randomPredicate2 = NSPredicate(format: "SELF MATCHES %@", randomRegEx2)
        let randomRegEx3 = "^[qwerQWER]*$"
        let randomPredicate3 = NSPredicate(format: "SELF MATCHES %@", randomRegEx3)
        
        if(isOneOffence == true && isTwoOffences == false){
            guard let offenceOne = offence1TextField.text, !offenceOne.isEmpty else{
                return false
            }
            
            if(!characterPredicate.evaluate(with: offenceOne)){
                showMessage(message: "Offence input should only contain letters.", controller: self)
                return false
            }
            else if((offenceOne.range(of: randomInput)) != nil){
                showMessage(message: "It seems like you've entered a random string of characters in the offence, but it's not clear what you want to do with this input. \n\nPlease review the offence input and ensure the information in the text box is accurate and complete.", controller: self)
                
                return false
            }
            else if(randomPredicate1.evaluate(with: offenceOne)){
                showMessage(message: "It seems like you've entered a random string of characters in the offence, but it's not clear what you want to do with this input. \n\nPlease review the offence input and ensure the information in the text box is accurate and complete.", controller: self)
                
                return false
            }
            else if(randomPredicate2.evaluate(with: offenceOne)){
                showMessage(message: "It seems like you've entered a random string of characters in the offence, but it's not clear what you want to do with this input. \n\nPlease review the offence input and ensure the information in the text box is accurate and complete.", controller: self)
                
                return false
            }
            else if(randomPredicate3.evaluate(with: offenceOne)){
                showMessage(message: "It seems like you've entered a random string of characters in the offence, but it's not clear what you want to do with this input. \n\nPlease review the offence input and ensure the information in the text box is accurate and complete.", controller: self)
                
                return false
            }
            else if(severity1Label.text == "Select severity"){
                showMessage(message: "Please select severity.", controller: self)
                return false
            }
            else if(intent1Label.text == "Select intent"){
                showMessage(message: "Please select intent.", controller: self)
                return false
            }
            else if(!numberPredicate.evaluate(with: remand1TextField.text)){
                showMessage(message: "Remand should not contain a letter. Please input the duration the offender is in custody before sentence in months.", controller: self)
                return false
            }
        }
        else{
            guard let offenceOne = offence1TextField.text, !offenceOne.isEmpty else{
                return false
            }
            guard let offenceTwo = offence2TextField.text, !offenceTwo.isEmpty else{
                return false
            }
            
            let randomInput = "asdfqwerzxcv"
            
            let randomRegEx1 = "^[asdfASDF]*$"
            let randomPredicate1 = NSPredicate(format: "SELF MATCHES %@", randomRegEx1)
            let randomRegEx2 = "^[zxcvZXCV]*$"
            let randomPredicate2 = NSPredicate(format: "SELF MATCHES %@", randomRegEx2)
            let randomRegEx3 = "^[qwerQWER]*$"
            let randomPredicate3 = NSPredicate(format: "SELF MATCHES %@", randomRegEx3)
            
            if(!characterPredicate.evaluate(with: offenceOne)){
                showMessage(message: "Offence input should only contain letters.", controller: self)
                return false
            }
            else if(!characterPredicate.evaluate(with: offenceTwo)){
                showMessage(message: "Offence input should only contain letters.", controller: self)
                return false
            }
            else if((offenceOne.range(of: randomInput)) != nil || (offenceTwo.range(of: randomInput)) != nil){
                showMessage(message: "It seems like you've entered a random string of characters in the offence, but it's not clear what you want to do with this input. \n\nPlease review the offence input and ensure the information in the text box is accurate and complete.", controller: self)
                
                return false
            }
            else if(randomPredicate1.evaluate(with: offenceOne) || randomPredicate1.evaluate(with: offenceTwo)){
                showMessage(message: "It seems like you've entered a random string of characters in the offence, but it's not clear what you want to do with this input. \n\nPlease review the offence input and ensure the information in the text box is accurate and complete.", controller: self)
                
                return false
            }
            else if(randomPredicate2.evaluate(with: offenceOne) || randomPredicate1.evaluate(with: offenceTwo)){
                showMessage(message: "It seems like you've entered a random string of characters in the offence, but it's not clear what you want to do with this input. \n\nPlease review the offence input and ensure the information in the text box is accurate and complete.", controller: self)
                
                return false
            }
            else if(randomPredicate3.evaluate(with: offenceOne) || randomPredicate1.evaluate(with: offenceTwo)){
                showMessage(message: "It seems like you've entered a random string of characters in the offence, but it's not clear what you want to do with this input. \n\nPlease review the offence input and ensure the information in the text box is accurate and complete.", controller: self)
                
                return false
            }
            else if(severity1Label.text == "Select severity"){
                showMessage(message: "Please select severity.", controller: self)
                return false
            }
            else if(intent1Label.text == "Select intent"){
                showMessage(message: "Please select intent.", controller: self)
                return false
            }
            else if(severity2Label.text == "Select severity"){
                showMessage(message: "Please select severity.", controller: self)
                return false
            }
            else if(intent2Label.text == "Select intent"){
                showMessage(message: "Please select intent.", controller: self)
                return false
            }
            else if(!numberPredicate.evaluate(with: remand1TextField.text)){
                showMessage(message: "Remand should not contain a letter. Please input the duration the offender is in custody before sentence in months.", controller: self)
                return false
            }
            else if(!numberPredicate.evaluate(with: remand2TextField.text)){
                showMessage(message: "Remand should not contain a letter. Please input the duration the offender is in custody before sentence in months.", controller: self)
                return false
            }
        }
        
        return true
    }
}
