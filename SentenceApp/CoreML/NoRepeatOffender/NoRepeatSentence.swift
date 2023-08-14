//
//  NoRepeatSentence.swift
//  SentenceApp
//
//  Created by Alesson Abao on 14/08/23.
//

import CoreML

func noRepeatOffenderSentenceModel(offense: String, severity: Int, intent: String) -> SentenceRecommendOutput?{
    do{
        // instantiate a new object model
        let config = MLModelConfiguration()
        // model
        let sentenceModel = try SentenceRecommend(configuration: config)
        // use model to make a predicition
        let recommendSentence = try sentenceModel.prediction(Offence: offense, Offence_Category: Double(severity), Intent: intent)

        return recommendSentence
    }
    catch{
        
    }
    return nil
}
