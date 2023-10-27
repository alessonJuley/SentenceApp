//
//  Sentence.swift
//  SentenceApp
//
//  Created by Alesson Abao on 6/09/23.
//

import CoreML

func sentenceModel(offence: String, severity: Int, intent: String) -> SentenceClassificationModelOutput?{
    do{
        // instantiate a new object model
        let config = MLModelConfiguration()
        // add model
        let sentenceModel = try SentenceClassificationModel(configuration: config)
        // use model to recommend sentence
        let recommendSentence = try sentenceModel.prediction(offence: offence, offenceCategory: Double(severity), intent: intent)
        
        return recommendSentence
    }
    catch{
        print("[CoreML>MultipleOffences>Sentence.swift]Something went wrong with sentence model.")
    }
    
    return nil
}

func sentenceModel2(offence: String, severity: Int, intent: String) -> SentenceClassificationModelOutput?{
    do{
        // instantiate a new object model
        let config = MLModelConfiguration()
        // add model
        let sentenceModel = try SentenceClassificationModel(configuration: config)
        // use model to recommend sentence
        let recommendSentence = try sentenceModel.prediction(offence: offence, offenceCategory: Double(severity), intent: intent)
        
        return recommendSentence
    }
    catch{
        print("[CoreML>MultipleOffences>Sentence.swift]Something went wrong with sentence model.")
    }
    
    return nil
}

//func sentenceModel(offence: String, severity: Int, intent: String) -> SentenceClassifierOutput?{
//    do{
//        // instantiate a new object model
//        let config = MLModelConfiguration()
//        // add model
//        let sentenceModel = try SentenceClassifier(configuration: config)
//        // use model to recommend sentence
//        let recommendSentence = try sentenceModel.prediction(offence: offence, offenceCategory: Double(severity), intent: intent)
//
//        return recommendSentence
//    }
//    catch{
//        print("[CoreML>MultipleOffences>Sentence.swift]Something went wrong with sentence model.")
//    }
//
//    return nil
//}
