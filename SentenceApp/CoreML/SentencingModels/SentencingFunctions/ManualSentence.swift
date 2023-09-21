//
//  ManualSentence.swift
//  SentenceApp
//
//  Created by Alesson Abao on 21/09/23.
//

import CoreML

func manualAllSentenceModel(offence: String, severity: Int, intent: String) -> AllSentenceModelOutput?{
    do{
        // instantiate a new object model
        let config = MLModelConfiguration()
        // add model
        let sentenceModel = try AllSentenceModel(configuration: config)
        // use model to recommend sentence
        let recommendSentence = try sentenceModel.prediction(offence: offence, offenceCategory: Double(severity), intent: intent)
        
        return recommendSentence
    }
    catch{
        print("Something went wrong with manualAllSentenceModel.")
    }
    
    return nil
}

func manualTrainingSentenceModel(offence: String, severity: Int, intent: String) -> TrainingSentenceModelOutput?{
    do{
        // instantiate a new object model
        let config = MLModelConfiguration()
        // add model
        let sentenceModel = try TrainingSentenceModel(configuration: config)
        // use model to recommend sentence
        let recommendSentence = try sentenceModel.prediction(offence: offence, offenceCategory: Double(severity), intent: intent)
        
        return recommendSentence
    }
    catch{
        print("Something went wrong with manualTrainingSentenceModel.")
    }
    
    return nil
}
