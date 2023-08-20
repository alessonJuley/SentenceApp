//
//  NoRepeatDuration.swift
//  SentenceApp
//
//  Created by Alesson Abao on 14/08/23.
//

import CoreML

// [CreateML] Sentence duration using tabular regression
// Algorithm: Automatic
// What algorithm CreateML chose: One Hot Encoder → One Hot Encoder → One Hot Encoder → Feature Vectorizer → GLM Regressor
// Target: Period_in_Months
// Features: Offence, offence category (severity), intent, and sentence
// Issue: Duration has negative values
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

// [CreateML] Sentence duration using tabular classification
// Algorithm: Automatic
// What algorithm CreateML chose: One Hot Encoder → One Hot Encoder → One Hot Encoder → Feature Vectorizer → Tree Ensemble Classifier
// Target: Period_in_Months
// Features: Offence, offence category (severity), intent, and sentence
// Issue: Duration is 0.00
//func noRepeatOffenderDurationModel(offense: String, severity: Int, intent: String, sentence: String) -> SentenceDurationClassifierOutput?{
//    do{
//        // instantiate a new object model
//        let config = MLModelConfiguration()
//        // model
//        let durationModel = try SentenceDurationClassifier(configuration: config)
//        // use model to make a predicition
//        let recommendDuration = try durationModel.prediction(Offence: offense, Offence_Category: Double(severity), Intent: intent, Sentence: sentence)
//
//        return recommendDuration
//    }
//    catch{
//
//    }
//
//    return nil
//}

// [CreateML] Sentence duration using tabular classification
// Algorithm: Automatic
// What algorithm CreateML chose: One Hot Encoder → One Hot Encoder → One Hot Encoder → Feature Vectorizer → Tree Ensemble Classifier
// Target: Period_in_Months
// Features: offence, severity, intent, and sentence
// Issue: Duration is 0.00
//func noRepeatOffenderDurationModel(offense: String, severity: Int, intent: String, sentence: String) -> AutomaticTrainingDurationOutput?{
//    do{
//        // instantiate a new object model
//        let config = MLModelConfiguration()
//        // model
//        let durationModel = try AutomaticTrainingDuration(configuration: config)
//        // use model to make a predicition
//        let recommendDuration = try durationModel.prediction(offence: offense, severity: Double(severity), intent: intent, sentence: sentence)
//
//        return recommendDuration
//    }
//    catch{
//
//    }
//
//    return nil
//}
