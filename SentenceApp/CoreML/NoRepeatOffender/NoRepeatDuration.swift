//
//  NoRepeatDuration.swift
//  SentenceApp
//
//  Created by Alesson Abao on 14/08/23.
//

import CoreML

func noRepeatOffenderDurationModel(offense: String, severity: Int, intent: String, sentence: String) -> SentenceDurationRegressorOutput?{
    do{
        // instantiate a new object model
        let config = MLModelConfiguration()
        // model
        let durationModel = try SentenceDurationRegressor(configuration: config)
        // use model to make a predicition
        let recommendDuration = try durationModel.prediction(Offence: offense, Offence_Category: Double(severity), Intent: intent, Sentence: sentence)
        
        return recommendDuration
    }
    catch{

    }

    return nil
}
