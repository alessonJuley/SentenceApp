//
//  ManualDuration.swift
//  DurationApp
//
//  Created by Alesson Abao on 21/09/23.
//

import CoreML

func manualAllDurationClassifierModel(offence: String, severity: Int, intent: String, remandDuration: Int, sentence: String, sentenceType: String) -> AllDurationClassifierModelOutput?{
    do{
        // instantiate a new object model
        let config = MLModelConfiguration()
        // add model
        let durationModel = try AllDurationClassifierModel(configuration: config)
        // use model to recommend sentence
        let recommendDuration = try durationModel.prediction(offence: offence, offenceCategory: Double(severity), intent: intent, remandDuration: Double(remandDuration), sentence: sentence, sentenceType: sentenceType)
        
        return recommendDuration
    }
    catch{
        print("Something went wrong with manualAllDurationClassifierModel")
    }
    
    return nil
}

func manualTrainingDurationClassifierModel(offence: String, severity: Int, intent: String, remandDuration: Int, sentence: String, sentenceType: String) -> TrainingDurationClassifierModelOutput?{
    do{
        // instantiate a new object model
        let config = MLModelConfiguration()
        // add model
        let durationModel = try TrainingDurationClassifierModel(configuration: config)
        // use model to recommend sentence
        let recommendDuration = try durationModel.prediction(offence: offence, offenceCategory: Double(severity), intent: intent, remandDuration: Double(remandDuration), sentence: sentence, sentenceType: sentenceType)
        
        return recommendDuration
    }
    catch{
        print("Something went wrong with manualTrainingDurationClassifierModel")
    }
    
    return nil
}
