//
//  Fine.swift
//  SentenceApp
//
//  Created by Alesson Abao on 6/09/23.
//

import CoreML

func FineModel(offence: String, severity: Int, intent: String, sentence: String, sentenceType: String) -> FinesTabularRegressorOutput?{
    do{
        // instantiate a new object model
        let config = MLModelConfiguration()
        // add model
        let fineModel = try FinesTabularRegressor(configuration: config)
        // use model to recommend sentence
        let recommendFine = try fineModel.prediction(offence: offence, offenceCategory: Double(severity), intent: intent, sentence: sentence, sentenceType: sentenceType)
        
        return recommendFine
    }
    catch{
        print("[CoreML>MultipleOffences>Fine.swift]Something went wrong with fine model.")
    }
    
    return nil
}
