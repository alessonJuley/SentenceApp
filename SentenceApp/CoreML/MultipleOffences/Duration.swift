//
//  Duration.swift
//  SentenceApp
//
//  Created by Alesson Abao on 6/09/23.
//

import CoreML

func durationModel(offence: String, severity: Int, intent: String, remandDuration: Int, sentence: String, sentenceType: String) -> DurationRegressorModelOutput?{
    do{
        // instantiate a new object model
        let config = MLModelConfiguration()
        // add model
        let durationModel = try DurationRegressorModel(configuration: config)
        // use model to recommend sentence
        let recommendDuration = try durationModel.prediction(offence: offence, offenceCategory: Double(severity), intent: intent, remandDuration: Double(remandDuration), sentence: sentence, sentenceType: sentenceType)
        return recommendDuration
    }
    catch{
        print("[CoreML>MultipleOffences>Duration.swift]Something went wrong with duration model.")
    }
    
    return nil
}
