//
//  CreateMLFine.swift
//  SentenceApp
//
//  Created by Alesson Abao on 21/09/23.
//

import CoreML

func createMLAllFineRegressorModel(offence: String, severity: Int, intent: String, sentence: String, sentenceType: String) -> AllFineRegressorModelOutput?{
    do{
        // instantiate a new object model
        let config = MLModelConfiguration()
        // add model
        let fineModel = try AllFineRegressorModel(configuration: config)
        // use model to recommend sentence
        let recommendFine = try fineModel.prediction(offence: offence, offenceCategory: Double(severity), intent: intent, sentence: sentence, sentenceType: sentenceType)
        
        return recommendFine
    }
    catch{
        print("Something went wrong with createMLAllFineRegressorModel.")
    }
    
    return nil
}

func createMLTrainingFineRegressorModel(offence: String, severity: Int, intent: String, sentence: String, sentenceType: String) -> TrainingFineRegressorModelOutput?{
    do{
        // instantiate a new object model
        let config = MLModelConfiguration()
        // add model
        let fineModel = try TrainingFineRegressorModel(configuration: config)
        // use model to recommend sentence
        let recommendFine = try fineModel.prediction(offence: offence, offenceCategory: Double(severity), intent: intent, sentence: sentence, sentenceType: sentenceType)
        
        return recommendFine
    }
    catch{
        print("Something went wrong with createMLTrainingFineRegressorModel.")
    }
    
    return nil
}

