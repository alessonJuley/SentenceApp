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
    
    // frontend variables
    var showForm2: Bool = false
    var showForm3: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUp()
    }
    
    // MARK: Add offence 2
    @IBAction func addOffence2(_ sender: UIButton) {
        if(showForm2 == true){
            
            // change button
            addOffence2Button.tintColor = UIColor.systemRed
            addOffence2Button.setTitle("Remove offence 2", for: .normal)
            addOffence2Button.setImage(UIImage(systemName: "minus"), for: .normal)
            
            // view
            offence2View.isHidden = false
            addOffence3View.isHidden = false
            
            // set
            showForm2 = false
            showForm3 = true
            
            if(offence3View.isHidden == false){
                isOneOffence = false
                isTwoOffences = false
                isThreeOffences = true
                
                showForm3 = false
            }
            else{
                isOneOffence = false
                isTwoOffences = true
                isThreeOffences = false
            }
        }
        else{
            // change button
            addOffence2Button.tintColor = UIColor.systemBlue
            addOffence2Button.setTitle("Add offence 2", for: .normal)
            addOffence2Button.setImage(UIImage(systemName: "plus"), for: .normal)
            
            // view
            offence2View.isHidden = true
            
            if(offence3View.isHidden == true){
                isOneOffence = true
                isTwoOffences = false
                isThreeOffences = false
                
                addOffence3View.isHidden = true
                resetForm()
            }
            else{
                isOneOffence = false
                isTwoOffences = true
                isThreeOffences = false
                
                resetForm()
            }

            // set
            showForm2 = true
            resetForm()
        }
    }
    // MARK: Add offence 3
    @IBAction func addOffence3(_ sender: UIButton) {
        if(showForm3 == true){
            // change button
            addOffence3Button.tintColor = UIColor.systemRed
            addOffence3Button.setTitle("Remove offence 3", for: .normal)
            addOffence3Button.setImage(UIImage(systemName: "minus"), for: .normal)
            
            // view
            offence3View.isHidden = false
            
            // set
            showForm3 = false
            
            isOneOffence = false
            isTwoOffences = false
            isThreeOffences = true
        }
        else{
            // change button
            addOffence3Button.tintColor = UIColor.systemBlue
            addOffence3Button.setTitle("Add offence 3", for: .normal)
            addOffence3Button.setImage(UIImage(systemName: "plus"), for: .normal)
            
            // view
            offence3View.isHidden = true
            
            if(offence2View.isHidden == true){
                isOneOffence = true
                isTwoOffences = false
                isThreeOffences = false
                
                addOffence3View.isHidden = true
                resetForm()
            }
            else{
                isOneOffence = false
                isTwoOffences = true
                isThreeOffences = false
                
                resetForm()
            }
            
            // set
            showForm3 = true
            
            // resetForm()
        }
    }
    
    // MARK: Recommend
    @IBAction func recommendOutput(_ sender: UIButton) {
        print("===============================================")
        print("❗️recommendOutput button PRESSED❗️")
        print("===============================================")
        
        // MARK: isOneOffence
        if(isOneOffence == true && isTwoOffences == false && isThreeOffences == false){
            if(validForm()){
                // input
                let offence1 = offence1TextField.text!
                let severity1 = Int(severity1TextField.text!) ?? 0
                let intent1 = intent1TextField.text!
                let remand1 = Int(remand1TextField.text!) ?? 0
                
                // recommend sentence
                let sentenceRecommend1 = sentenceModel(offence: offence1, severity: severity1, intent: intent1)!.sentence
                
                // check if sentence is fined or not so you select different targets and use different models
                if(sentenceRecommend1 != "Fined"){
                    let durationRecommend1 = durationModel(severity: severity1, remandDuration: remand1, sentence: sentenceRecommend1, sentenceType: "Single")!.totalDuration
                    
                    print("==================FOR TESTING==================")
                    print("inside [isOneOffence] recommend 1 != fined")
//                    let durationFeatureNamesRecommend1 = durationModel(severity: severity1, remandDuration: remand1, sentence: sentenceRecommend1, sentenceType: "Single")!.featureNames
//                    print("durationRecommend1: \(durationRecommend1)")
//                    print("durationFeatureNamesRecommend1: \(durationFeatureNamesRecommend1)")
                    print("==================FOR TESTING==================")
                    
                    outputTextView.text = "Sentence: " + sentenceRecommend1 + "\t" + String(format: "%.2f", durationRecommend1) + " months\n\n"
                }
                else{
                    let fineRecommend1 = fineModel(offence: offence1, severity: severity1, intent: intent1, sentence: sentenceRecommend1, sentenceType: "Single")!.fineAmount
                    
                    print("==================FOR TESTING==================")
//                    let fineFeatureNamesRecommend1 = fineModel(offence: offence1, severity: severity1, intent: intent1, sentence: sentenceRecommend1, sentenceType: "Single")!.featureNames
                    print("inside [isOneOffence] recommend 1 == fined")
//                    print("fineRecommend1: \(fineRecommend1)")
//                    print("fineFeatureNamesRecommend1: \(fineFeatureNamesRecommend1)")
                    print("==================FOR TESTING==================")
                    
                    outputTextView.text = "Sentence: " + sentenceRecommend1 + "\t" + "Amount: $" + String(format: "%.2f", fineRecommend1)
                }
                
                resetForm()
            }
            else{
                // showMessage(message: "Uh-oh! It seems there's an issue with your submission. \n\nPlease review the form and ensure the information in the text box is accurate and complete.",  controller: self)
                showMessage(message: "Invalid isOneOffence form",  controller: self)
            }
        }
        // MARK: isTwoOffences
        else if(isOneOffence == false && isTwoOffences == true && isThreeOffences == false){
            if(validForm()){
                // input for two offences
                let offence1 = offence1TextField.text!
                let severity1 = Int(severity1TextField.text!) ?? 0
                let intent1 = intent1TextField.text!
                let remand1 = Int(remand1TextField.text!) ?? 0
                
                let offence2 = offence2TextField.text!
                let severity2 = Int(severity2TextField.text!) ?? 0
                let intent2 = intent2TextField.text!
                let remand2 = Int(remand2TextField.text!) ?? 0
                
                // recommend sentences
                let sentenceRecommend1 = sentenceModel(offence: offence1, severity: severity1, intent: intent1)!.sentence
                let sentenceRecommend2 = sentenceModel(offence: offence2, severity: severity2, intent: intent2)!.sentence
                
                print("==================FOR TESTING==================")
                let sentenceProbabilityRecommend1 = sentenceModel(offence: offence1, severity: severity1, intent: intent1)!.sentenceProbability
                let sentenceProbabilityRecommend2 = sentenceModel(offence: offence2, severity: severity2, intent: intent2)!.sentenceProbability
                
                let sentenceFeatureNamesRecommend1 = sentenceModel(offence: offence1, severity: severity1, intent: intent1)!.featureNames
                let sentenceFeatureNamesRecommend2 = sentenceModel(offence: offence2, severity: severity2, intent: intent2)!.featureNames
                
                print("inside [isTwoOffences] valid form")
                print("isOneOffence: \(isOneOffence)\nisTwoOffences: \(isTwoOffences)\nisThreeOffences: \(isThreeOffences)\n")
                print("sentenceRecommend1: \(sentenceRecommend1)")
                print("sentenceRecommend2: \(sentenceRecommend2)")
                print("sentenceProbabilityRecommend1: \(sentenceProbabilityRecommend1)")
                print("sentenceProbabilityRecommend2: \(sentenceProbabilityRecommend2)")
                print("sentenceProbabilityRecommend1 type: \(type(of: sentenceProbabilityRecommend1))")
                print("sentenceProbabilityRecommend2 type: \(type(of: sentenceProbabilityRecommend2))")
                print("sentenceFeatureNamesRecommend1: \(sentenceFeatureNamesRecommend1)")
                print("sentenceFeatureNamesRecommend2: \(sentenceFeatureNamesRecommend2)")
                print("==================FOR TESTING==================\n")
                
                // check if both offences are in the same category
                if(severity1 == severity2){
                    // check if sentence is fined or not so you select different targets and use different models
                    if(sentenceRecommend1 != "Fined" && sentenceRecommend2 != "Fined"){
                        let durationRecommend1 = durationModel(severity: severity1, remandDuration: remand1, sentence: sentenceRecommend1, sentenceType: "Concurrent")!.totalDuration
                        let durationRecommend2 = durationModel(severity: severity2, remandDuration: remand2, sentence: sentenceRecommend2, sentenceType: "Concurrent")!.totalDuration
                        var totalDuration = durationRecommend1
                        
                        if(durationRecommend1 < durationRecommend2){
                            totalDuration += durationRecommend2
                        }
                        
                        outputTextView.text = "Sentence 1: " + sentenceRecommend1 + "\t" + String(format: "%.2f", durationRecommend1) + " months"
                        + "\nSentence 2: " + sentenceRecommend2 + "\t" + String(format: "%.2f", durationRecommend2) + " months" + "\n"
                        + "Total time served: " + String(format: "%.2f", totalDuration) + "\n\n"
                        + "Sentence Type: Concurrent (serve sentences at the same time)"
                    }
                    else if(sentenceRecommend1 == "Fined" && sentenceRecommend2 != "Fined"){
                        let fineRecommend1 = fineModel(offence: offence1, severity: severity1, intent: intent1, sentence: sentenceRecommend1, sentenceType: "Concurrent")!.fineAmount
                        let durationRecommend2 = durationModel(severity: severity2, remandDuration: remand2, sentence: sentenceRecommend2, sentenceType: "Concurrent")!.totalDuration
                        
                        outputTextView.text = "Sentence 1: " + sentenceRecommend1 + "\t" + "Amount: $" + String(format: "%.2f", fineRecommend1)
                        + "\nSentence 2: " + sentenceRecommend2 + "\t" + String(format: "%.2f", durationRecommend2) + " months" + "\n\n"
                        // + "Sentence Type: Concurrent (serve sentences at the same time)"
                    }
                    else if(sentenceRecommend1 != "Fined" && sentenceRecommend2 == "Fined"){
                        let durationRecommend1 = durationModel(severity: severity1, remandDuration: remand1, sentence: sentenceRecommend1, sentenceType: "Concurrent")!.totalDuration
                        let fineRecommend2 = fineModel(offence: offence2, severity: severity2, intent: intent2, sentence: sentenceRecommend2, sentenceType: "Concurrent")!.fineAmount
                        
                        outputTextView.text = "Sentence 1: " + sentenceRecommend1 + "\t" + String(format: "%.2f", durationRecommend1) + " months"
                        + "\nSentence 2: " + sentenceRecommend2 + "\t" + "Amount: $" + String(format: "%.2f", fineRecommend2) + "\n\n"
                        // + "Sentence Type: Concurrent (serve sentences at the same time)"
                    }
                    else{
                        let fineRecommend1 = fineModel(offence: offence1, severity: severity1, intent: intent1, sentence: sentenceRecommend1, sentenceType: "Concurrent")!.fineAmount
                        let fineRecommend2 = fineModel(offence: offence2, severity: severity2, intent: intent2, sentence: sentenceRecommend2, sentenceType: "Concurrent")!.fineAmount
                        let totalFine = fineRecommend1 + fineRecommend2
                        
                        outputTextView.text = "Sentence 1: " + sentenceRecommend1 + "\t" + "Amount: $" + String(format: "%.2f", fineRecommend1)
                        + "\nSentence 2: " + sentenceRecommend2 + "\t" + "Amount: $" + String(format: "%.2f", fineRecommend2) + "\n"
                        + "Total fine: $" + String(format: "%.2f", totalFine) + "\n\n"
                        // + "Sentence Type:" + "\n" + "Concurrent (serve sentences at the same time)"
                    }
                    
                    resetForm()
                }
                else{
                    // check if sentence is fined or not so you select different targets and use different models
                    if(sentenceRecommend1 != "Fined" && sentenceRecommend2 != "Fined"){
                        let durationRecommend1 = durationModel(severity: severity1, remandDuration: remand1, sentence: sentenceRecommend1, sentenceType: "Cumulative")!.totalDuration
                        let durationRecommend2 = durationModel(severity: severity2, remandDuration: remand2, sentence: sentenceRecommend2, sentenceType: "Cumulative")!.totalDuration
                        let totalDuration = durationRecommend1 + durationRecommend2
                        
                        outputTextView.text = "Sentence 1: " + sentenceRecommend1 + "\t" + String(format: "%.2f", durationRecommend1) + " months"
                        + "\nSentence 2: " + sentenceRecommend2 + "\t" + String(format: "%.2f", durationRecommend2) + " months" + "\n"
                        + "Total duration: " + String(format: "%.2f", totalDuration) + "\n\n"
                        + "Sentence Type: Cumulative (sentences are added together)"
                    }
                    else if(sentenceRecommend1 == "Fined" && sentenceRecommend2 != "Fined"){
                        let fineRecommend1 = fineModel(offence: offence1, severity: severity1, intent: intent1, sentence: sentenceRecommend1, sentenceType: "Cumulative")!.fineAmount
                        let durationRecommend2 = durationModel(severity: severity2, remandDuration: remand2, sentence: sentenceRecommend2, sentenceType: "Cumulative")!.totalDuration
                        
                        outputTextView.text = "Sentence 1: " + sentenceRecommend1 + "\t" + "Amount: $" + String(format: "%.2f", fineRecommend1)
                        + "\nSentence 2: " + sentenceRecommend2 + "\t" + String(format: "%.2f", durationRecommend2) + " months" + "\n\n"
                        // + "Sentence Type: Cumulative (sentences are added together)"
                    }
                    else if(sentenceRecommend1 != "Fined" && sentenceRecommend2 == "Fined"){
                        let durationRecommend1 = durationModel(severity: severity1, remandDuration: remand1, sentence: sentenceRecommend1, sentenceType: "Cumulative")!.totalDuration
                        let fineRecommend2 = fineModel(offence: offence2, severity: severity2, intent: intent2, sentence: sentenceRecommend2, sentenceType: "Cumulative")!.fineAmount
                        
                        outputTextView.text = "Sentence 1: " + sentenceRecommend1 + "\t" + String(format: "%.2f", durationRecommend1) + " months"
                        + "\nSentence 2: " + sentenceRecommend2 + "\t" + "Amount: $" + String(format: "%.2f", fineRecommend2) + "\n\n"
                        // + "Sentence Type: Cumulative (sentences are added together)"
                    }
                    else{
                        let fineRecommend1 = fineModel(offence: offence1, severity: severity1, intent: intent1, sentence: sentenceRecommend1, sentenceType: "Cumulative")!.fineAmount
                        let fineRecommend2 = fineModel(offence: offence2, severity: severity2, intent: intent2, sentence: sentenceRecommend2, sentenceType: "Cumulative")!.fineAmount
                        let totalFine = fineRecommend1 + fineRecommend2
                        
                        outputTextView.text = "Sentence 1: " + sentenceRecommend1 + "\t" + "Amount: $" + String(format: "%.2f", fineRecommend1)
                        + "\nSentence 2: " + sentenceRecommend2 + "\t" + "Amount: $" + String(format: "%.2f", fineRecommend2) + "\n"
                        + "Total fine: $" + String(format: "%.2f", totalFine) + "\n\n"
                        + "Sentence Type: Cumulative (sentences are added together)"
                    }
                    
                    resetForm()
                }
            }
            else{
                // showMessage(message: "Uh-oh! It seems there's an issue with your submission. \n\nPlease review the form and ensure the information in the text box is accurate and complete.",  controller: self)
                showMessage(message: "Invalid isTwoOffences form",  controller: self)
            }
        }
        // MARK: isThreeOffences
        else if(isOneOffence == false && isTwoOffences == false && isThreeOffences == true){
            if(validForm()){
                // input for three offences
                // input for two offences
                let offence1 = offence1TextField.text!
                let severity1 = Int(severity1TextField.text!) ?? 0
                let intent1 = intent1TextField.text!
                let remand1 = Int(remand1TextField.text!) ?? 0
                
                let offence2 = offence2TextField.text!
                let severity2 = Int(severity2TextField.text!) ?? 0
                let intent2 = intent2TextField.text!
                let remand2 = Int(remand2TextField.text!) ?? 0
                
                let offence3 = offence3TextField.text!
                let severity3 = Int(severity3TextField.text!) ?? 0
                let intent3 = intent3TextField.text!
                let remand3 = Int(remand3TextField.text!) ?? 0
                
                // recommend sentences
                let sentenceRecommend1 = sentenceModel(offence: offence1, severity: severity1, intent: intent1)!.sentence
                let sentenceRecommend2 = sentenceModel(offence: offence2, severity: severity2, intent: intent2)!.sentence
                let sentenceRecommend3 = sentenceModel(offence: offence3, severity: severity3, intent: intent3)!.sentence
                
                // check if all offences are in the same category
                if(severity1 == severity2 && severity1 == severity3){
                    // severity 1 && severity 2 = Concurrent
                    // severity 1 && severity 3 = Concurrent
                    // check if sentence is fined or not so you select different targets and use different models
                    if(sentenceRecommend1 != "Fined" && sentenceRecommend2 != "Fined" && sentenceRecommend3 != "Fined"){
                        let durationRecommend1 = durationModel(severity: severity1, remandDuration: remand1, sentence: sentenceRecommend1, sentenceType: "Concurrent")!.totalDuration
                        let durationRecommend2 = durationModel(severity: severity2, remandDuration: remand2, sentence: sentenceRecommend2, sentenceType: "Concurrent")!.totalDuration
                        let durationRecommend3 = durationModel(severity: severity3, remandDuration: remand3, sentence: sentenceRecommend3, sentenceType: "Concurrent")!.totalDuration
                        
                        var totalDuration = durationRecommend1
                        
                        if(durationRecommend2 > durationRecommend1 && durationRecommend2 > durationRecommend3){
                            totalDuration += durationRecommend2
                        }
                        else if(durationRecommend3 > durationRecommend2 && durationRecommend3 > durationRecommend2){
                            totalDuration += durationRecommend3
                        }
                        
                        outputTextView.text = "Sentence 1: " + sentenceRecommend1 + "\t" + String(format: "%.2f", durationRecommend1) + " months"
                        + "\nSentence 2: " + sentenceRecommend2 + "\t" + String(format: "%.2f", durationRecommend2) + " months"
                        + "\nSentence 3: " + sentenceRecommend3 + "\t" + String(format: "%.2f", durationRecommend3) + " months" + "\n"
                        + "Total duration: " + String(format: "%.2f", totalDuration) + "\n\n"
                        + "Sentence Type: Concurrent (serve sentences at the same time)"
                    }
                    else if(sentenceRecommend1 == "Fined" && sentenceRecommend2 != "Fined" && sentenceRecommend3 != "Fined"){
                        let fineRecommend1 = fineModel(offence: offence1, severity: severity1, intent: intent1, sentence: sentenceRecommend1, sentenceType: "Concurrent")!.fineAmount
                        let durationRecommend2 = durationModel(severity: severity2, remandDuration: remand2, sentence: sentenceRecommend2, sentenceType: "Concurrent")!.totalDuration
                        let durationRecommend3 = durationModel(severity: severity3, remandDuration: remand3, sentence: sentenceRecommend3, sentenceType: "Concurrent")!.totalDuration
                        var totalDuration = durationRecommend2
                        
                        if(durationRecommend3 > durationRecommend2){
                            totalDuration += durationRecommend3
                        }
                        
                        outputTextView.text = "Sentence 1: " + sentenceRecommend1 + "\t" + "Amount: $" + String(format: "%.2f", fineRecommend1)
                        + "\nSentence 2: " + sentenceRecommend2 + "\t" + String(format: "%.2f", durationRecommend2) + " months"
                        + "\nSentence 3: " + sentenceRecommend3 + "\t" + String(format: "%.2f", durationRecommend3) + " months" + "\n"
                        + "Total duration: " + String(format: "%.2f", totalDuration) + " months" + "\n\n"
                        + "Sentence Type: Concurrent (serve sentences at the same time)"
                    }
                    else if(sentenceRecommend1 != "Fined" && sentenceRecommend2 == "Fined" && sentenceRecommend3 != "Fined"){
                        
                    }
                    else if(sentenceRecommend1 != "Fined" && sentenceRecommend2 != "Fined" && sentenceRecommend3 == "Fined"){
                        
                    }
                    else{
                        let fineRecommend1 = fineModel(offence: offence1, severity: severity1, intent: intent1, sentence: sentenceRecommend1, sentenceType: "Concurrent")!.fineAmount
                        let fineRecommend2 = fineModel(offence: offence2, severity: severity2, intent: intent2, sentence: sentenceRecommend2, sentenceType: "Concurrent")!.fineAmount
                        let fineRecommend3 = fineModel(offence: offence3, severity: severity3, intent: intent3, sentence: sentenceRecommend3, sentenceType: "Concurrent")!.fineAmount
                        let totalFine = fineRecommend1 + fineRecommend2 + fineRecommend3
                        
                        outputTextView.text = "Sentence 1: " + sentenceRecommend1 + "\t" + "Amount: $" + String(format: "%.2f", fineRecommend1)
                        + "\nSentence 2: " + sentenceRecommend2 + "\t" + "Amount: $" + String(format: "%.2f", fineRecommend2)
                        + "\nSentence 3: " + sentenceRecommend3 + "\t" + "Amount: $" + String(format: "%.2f", fineRecommend3) + "\n"
                        + "Total fine: $" + String(format: "%.2f", totalFine)
                    }
                }
                else if(severity1 == severity2 && severity1 != severity3){
                    // severity 1 && severity 2 = Concurrent
                    // severity 1 && severity 3 = Cumulative
                    // check if sentence is fined or not so you select different targets and use different models
                }
                else if(severity1 != severity2 && severity1 == severity3){
                    // severity 1 && severity 2 = Cumulative
                    // severity 1 && severity 3 = Concurrent
                    // check if sentence is fined or not so you select different targets and use different models
                }
                else if(severity2 == severity1 && severity2 == severity3){
                    // severity 1 && severity 2 = Concurrent
                    // severity 1 && severity 3 = Concurrent
                    // check if sentence is fined or not so you select different targets and use different models
                }
                else if(severity2 != severity1 && severity2 == severity3){
                    // severity 1 && severity 2 = Cumulative
                    // severity 1 && severity 3 = Concurrent
                    // check if sentence is fined or not so you select different targets and use different models
                }
                else if(severity2 == severity1 && severity2 != severity3){
                    // severity 1 && severity 2 = Concurrent
                    // severity 1 && severity 3 = Cumulative
                    // check if sentence is fined or not so you select different targets and use different models
                }
                else if(severity3 == severity1 && severity3 == severity2){
                    // severity 1 && severity 2 = Concurrent
                    // severity 1 && severity 3 = Concurrent
                    // check if sentence is fined or not so you select different targets and use different models
                }
                else if(severity3 != severity1 && severity3 == severity2){
                    // severity 1 && severity 2 = Cumulative
                    // severity 1 && severity 3 = Concurrent
                    // check if sentence is fined or not so you select different targets and use different models
                }
                else if(severity3 == severity1 && severity3 != severity2){
                    // severity 1 && severity 2 = Concurrent
                    // severity 1 && severity 3 = Cumulative
                    // check if sentence is fined or not so you select different targets and use different models
                }
                else{
                    // severity 1 && severity 2 = Cumulative
                    // severity 1 && severity 3 = Cumulative
                    // check if sentence is fined or not so you select different targets and use different models
                }
            }
            else{
                // showMessage(message: "Uh-oh! It seems there's an issue with your submission. \n\nPlease review the form and ensure the information in the text box is accurate and complete.",  controller: self)
                showMessage(message: "Invalid isThreeOffences form",  controller: self)
            }
        }
        else{
            showMessage(message: "Uh-oh! It seems there's an issue with your submission. \n\nPlease review the form and ensure the information in the text box is accurate and complete.",  controller: self)
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
    // MARK: validForm()
    // ========================FORM========================
    func validForm() -> Bool{
        let characterRegEx = "^[a-zA-Z ]*$"
        let characterPredicate = NSPredicate(format: "SELF MATCHES %@", characterRegEx)
        
        let severityNumberRegEx = "[1-4]"
        let severityNumberPredicate = NSPredicate(format: "SELF MATCHES %@", severityNumberRegEx)
        
        let numberRegEx = #"^[0-9]*(\.[0-9]+)?$"#
        let numberPredicate = NSPredicate(format: "SELF MATCHES %@", numberRegEx)
        
        // MARK: validForm() - isOneOffence
        if(isOneOffence == true && isTwoOffences == false && isThreeOffences == false){
            
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
                showMessage(message: "[isOneOffence] Offence1 input should only contain letters.",  controller: self)
                
                return false
            }
            else if(!severityNumberPredicate.evaluate(with: severity1)){
                showMessage(message: "[isOneOffence] Severity1 input should not contain a letter. Please choose from 1 (least severe) to 4 (most severe).",  controller: self)
                
                return false
            }
            else if(intent1.lowercased() != "intentional" && intent1.lowercased() != "reckless" && intent1.lowercased() != "knowing" && intent1.lowercased() != "negligent"){
                showMessage(message: "[isOneOffence] Please choose among the following intent1 inputs: \n Intentional\n Reckless\n Knowing\n Negligent\n",  controller: self)
                
                return false
            }
            else if(!numberPredicate.evaluate(with: remand1TextField.text)){
                showMessage(message: "[isOneOffence] Remand1 should not contain a letter. Please input the duration the offender is in custody before sentence in months.",  controller: self)
                
                return false
            }
        }
        // MARK: validForm() - isTwoOffences
        else if(isOneOffence == false && isTwoOffences == true && isThreeOffences == false){
            if(offence3View.isHidden == true){
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
                    showMessage(message: "[isTwoOffences] Offence1 input should only contain letters.",  controller: self)
                    
                    return false
                }
                else if(!severityNumberPredicate.evaluate(with: severity1)){
                    showMessage(message: "[isTwoOffences] Severity1 input should not contain a letter. Please choose from 1 (least severe) to 4 (most severe).",  controller: self)
                    
                    return false
                }
                else if(intent1.lowercased() != "intentional" && intent1.lowercased() != "reckless" && intent1.lowercased() != "knowing" && intent1.lowercased() != "negligent"){
                    showMessage(message: "[isTwoOffences] Please choose among the following intent1 inputs: \n Intentional\n Reckless\n Knowing\n Negligent\n",  controller: self)
                    
                    return false
                }
                else if(!numberPredicate.evaluate(with: remand1TextField.text)){
                    showMessage(message: "[isTwoOffences] Remand1 should not contain a letter. Please input the duration the offender is in custody before sentence in months.",  controller: self)
                    
                    return false
                }
                // ===========================offence 2===========================
                else if(!characterPredicate.evaluate(with: offence2)){
                    showMessage(message: "[isTwoOffences] Offence2 input should only contain letters.",  controller: self)
                    
                    return false
                }
                else if(!severityNumberPredicate.evaluate(with: severity2)){
                    showMessage(message: "[isTwoOffences] Severity2 input should not contain a letter. Please choose from 1 (least severe) to 4 (most severe).",  controller: self)
                    
                    return false
                }
                else if(intent2.lowercased() != "intentional" && intent2.lowercased() != "reckless" && intent2.lowercased() != "knowing" && intent2.lowercased() != "negligent"){
                    showMessage(message: "[isTwoOffences] Please choose among the following intent2 inputs: \n Intentional\n Reckless\n Knowing\n Negligent\n",  controller: self)
                    
                    return false
                }
                else if(!numberPredicate.evaluate(with: remand2TextField.text)){
                    showMessage(message: "[isTwoOffences] Remand2 should not contain a letter. Please input the duration the offender is in custody before sentence in months.",  controller: self)
                    
                    return false
                }
            }
            else if(offence2View.isHidden == true){
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
                    showMessage(message: "[isTwoOffences] Offence1 input should only contain letters.",  controller: self)
                    
                    return false
                }
                else if(!severityNumberPredicate.evaluate(with: severity1)){
                    showMessage(message: "[isTwoOffences] Severity1 input should not contain a letter. Please choose from 1 (least severe) to 4 (most severe).",  controller: self)
                    
                    return false
                }
                else if(intent1.lowercased() != "intentional" && intent1.lowercased() != "reckless" && intent1.lowercased() != "knowing" && intent1.lowercased() != "negligent"){
                    showMessage(message: "[isTwoOffences] Please choose among the following intent1 inputs: \n Intentional\n Reckless\n Knowing\n Negligent\n",  controller: self)
                    
                    return false
                }
                else if(!numberPredicate.evaluate(with: remand1TextField.text)){
                    showMessage(message: "[isTwoOffences] Remand1 should not contain a letter. Please input the duration the offender is in custody before sentence in months.",  controller: self)
                    
                    return false
                }
                // ===========================offence 3===========================
                else if(!characterPredicate.evaluate(with: offence3)){
                    showMessage(message: "[isTwoOffences] Offence2 input should only contain letters.",  controller: self)
                    
                    return false
                }
                else if(!severityNumberPredicate.evaluate(with: severity3)){
                    showMessage(message: "[isTwoOffences] Severity2 input should not contain a letter. Please choose from 1 (least severe) to 4 (most severe).",  controller: self)
                    
                    return false
                }
                else if(intent3.lowercased() != "intentional" && intent3.lowercased() != "reckless" && intent3.lowercased() != "knowing" && intent3.lowercased() != "negligent"){
                    showMessage(message: "[isTwoOffences] Please choose among the following intent2 inputs: \n Intentional\n Reckless\n Knowing\n Negligent\n",  controller: self)
                    
                    return false
                }
                else if(!numberPredicate.evaluate(with: remand3TextField.text)){
                    showMessage(message: "[isTwoOffences] Remand2 should not contain a letter. Please input the duration the offender is in custody before sentence in months.",  controller: self)
                    
                    return false
                }
            }
        }
        // MARK: validForm() - isThreeOffences
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
                showMessage(message: "[isThreeOffences] Offence1 input should only contain letters.",  controller: self)
                
                return false
            }
            else if(!severityNumberPredicate.evaluate(with: severity1)){
                showMessage(message: "[isThreeOffences] Severity1 input should not contain a letter. Please choose from 1 (least severe) to 4 (most severe).",  controller: self)
                
                return false
            }
            else if(intent1.lowercased() != "intentional" && intent1.lowercased() != "reckless" && intent1.lowercased() != "knowing" && intent1.lowercased() != "negligent"){
                showMessage(message: "[isThreeOffences] Please choose among the following intent1 inputs: \n Intentional\n Reckless\n Knowing\n Negligent\n",  controller: self)
                
                return false
            }
            else if(!numberPredicate.evaluate(with: remand1TextField.text)){
                showMessage(message: "[isThreeOffences] Remand1 should not contain a letter. Please input the duration the offender is in custody before sentence in months.",  controller: self)
                
                return false
            }
            // ===========================offence 2===========================
            else if(!characterPredicate.evaluate(with: offence2)){
                showMessage(message: "[isThreeOffences] Offence2 input should only contain letters.",  controller: self)
                
                return false
            }
            else if(!severityNumberPredicate.evaluate(with: severity2)){
                showMessage(message: "[isThreeOffences] Severity2 input should not contain a letter. Please choose from 1 (least severe) to 4 (most severe).",  controller: self)
                
                return false
            }
            else if(intent2.lowercased() != "intentional" && intent2.lowercased() != "reckless" && intent2.lowercased() != "knowing" && intent2.lowercased() != "negligent"){
                showMessage(message: "[isThreeOffences] Please choose among the following intent2 inputs: \n Intentional\n Reckless\n Knowing\n Negligent\n",  controller: self)
                
                return false
            }
            else if(!numberPredicate.evaluate(with: remand2TextField.text)){
                showMessage(message: "[isThreeOffences] Remand2 should not contain a letter. Please input the duration the offender is in custody before sentence in months.",  controller: self)
                
                return false
            }
            // ===========================offence 3===========================
            else if(!characterPredicate.evaluate(with: offence3)){
                showMessage(message: "[isThreeOffences] Offence3 input should only contain letters.",  controller: self)
                
                return false
            }
            else if(!severityNumberPredicate.evaluate(with: severity3)){
                showMessage(message: "[isThreeOffences] Severity3 input should not contain a letter. Please choose from 1 (least severe) to 4 (most severe).",  controller: self)
                
                return false
            }
            else if(intent3.lowercased() != "intentional" && intent3.lowercased() != "reckless" && intent3.lowercased() != "knowing" && intent3.lowercased() != "negligent"){
                showMessage(message: "[isThreeOffences] Please choose among the following intent3 inputs: \n Intentional\n Reckless\n Knowing\n Negligent\n",  controller: self)
                
                return false
            }
            else if(!numberPredicate.evaluate(with: remand3TextField.text)){
                showMessage(message: "[isThreeOffences] Remand3 should not contain a letter. Please input the duration the offender is in custody before sentence in months.",  controller: self)
                
                return false
            }
        }
        else{
            showMessage(message: "Something went wrong with validForm function",  controller: self)
        }
        
        return true
    }
    // ========================FORM========================
    
    // MARK: setUp
    func setUp(){
        // ========================FORM========================
        showForm2 = true
        
        offence2View.isHidden = true
        addOffence3View.isHidden = true
        offence3View.isHidden = true
        
        isOneOffence = true
        isTwoOffences = false
        isThreeOffences = false
        // ========================FORM========================
        
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
    // MARK: resetForm()
    func resetForm(){
        if(isOneOffence == true && isTwoOffences == false && isThreeOffences == false){
            if(offence3View.isHidden == true){
                offence3TextField.text = nil
                severity3TextField.text = nil
                intent3TextField.text = nil
                remand3TextField.text = nil
            }
            else{
                offence1TextField.text = nil
                severity1TextField.text = nil
                intent1TextField.text = nil
                remand1TextField.text = nil
            }
        }
        else if(isOneOffence == false && isTwoOffences == true && isThreeOffences == false){
            if(offence3View.isHidden == true){
                offence3TextField.text = nil
                severity3TextField.text = nil
                intent3TextField.text = nil
                remand3TextField.text = nil
            }
            else if(offence2View.isHidden == true){
                offence2TextField.text = nil
                severity2TextField.text = nil
                intent2TextField.text = nil
                remand2TextField.text = nil
            }
        }
    }
}
