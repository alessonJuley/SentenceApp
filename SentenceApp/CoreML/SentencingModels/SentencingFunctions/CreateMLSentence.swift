//
//  CreateMLSentence.swift
//  SentenceApp
//
//  Created by Alesson Abao on 21/09/23.
//

import CoreML

func createMLAllSentenceClassifierModel(offence: String, severity: Int, intent: String) -> AllCMSentenceClassifierModelOutput?{
    do{
        // instantiate a new object model
        let config = MLModelConfiguration()
        // add model
        let sentenceModel = try AllCMSentenceClassifierModel(configuration: config)
        // use model to recommend sentence
        let recommendSentence = try sentenceModel.prediction(offence: offence, offenceCategory: Double(severity), intent: intent)
        
        return recommendSentence
    }
    catch{
        print("Something went wrong with createMLAllSentenceModel.")
    }
    
    return nil
}

func createMLTrainingSentenceClassifierModel(offence: String, severity: Int, intent: String) -> TrainingCMSentenceClassifierModelOutput?{
    do{
        // instantiate a new object model
        let config = MLModelConfiguration()
        // add model
        let sentenceModel = try TrainingCMSentenceClassifierModel(configuration: config)
        // use model to recommend sentence
        let recommendSentence = try sentenceModel.prediction(offence: offence, offenceCategory: Double(severity), intent: intent)
        
        return recommendSentence
    }
    catch{
        print("Something went wrong with createMLTrainingSentenceClassifierModel.")
    }
    
    return nil
}
