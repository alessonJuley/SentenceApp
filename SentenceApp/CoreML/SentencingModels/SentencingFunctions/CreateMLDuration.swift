//
//  CreateMLDuration.swift
//  SentenceApp
//
//  Created by Alesson Abao on 21/09/23.
//

import CoreML

func createMLAllDurationRegressorModel(offence: String, severity: Int, intent: String, remandDuration: Int, sentence: String, sentenceType: String) -> AllDurationRegressorModelOutput?{
    do{
        // instantiate a new object model
        let config = MLModelConfiguration()
        // add model
        let durationModel = try AllDurationRegressorModel(configuration: config)
        // use model to recommend sentence
        let recommendDuration = try durationModel.prediction(offence: offence, offenceCategory: Double(severity), intent: intent, remandDuration: Double(remandDuration), sentence: sentence, sentenceType: sentenceType)
        
        return recommendDuration
    }
    catch{
        print("Something went wrong with createMLAllDurationRegressorModel")
    }
    
    return nil
}

func createMLTrainingRegressorModel(offence: String, severity: Int, intent: String, remandDuration: Int, sentence: String, sentenceType: String) -> TrainingDurationRegressorModelOutput?{
    do{
        // instantiate a new object model
        let config = MLModelConfiguration()
        // add model
        let durationModel = try TrainingDurationRegressorModel(configuration: config)
        // use model to recommend sentence
        let recommendDuration = try durationModel.prediction(offence: offence, offenceCategory: Double(severity), intent: intent, remandDuration: Double(remandDuration), sentence: sentence, sentenceType: sentenceType)
        
        return recommendDuration
    }
    catch{
        print("Something went wrong with createMLTrainingRegressorModel")
    }
    
    return nil
}
