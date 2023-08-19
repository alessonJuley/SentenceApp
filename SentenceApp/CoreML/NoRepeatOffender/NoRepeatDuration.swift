//
//  NoRepeatDuration.swift
//  SentenceApp
//
//  Created by Alesson Abao on 14/08/23.
//

import CoreML

// Sentence duration using tabular regression
// Algorithm: Automatic
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

// Sentence duration using tabular classification
// Algorithm: Automatic
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

// Sentence duration using tabular classification
// Algorithm: Random forest
/* Max iterations: 10
    Max depth: 6
    Min loss reduction: 0
    Min child weight: 0.1
    Row Subsample ratio: 0.8
    Column subsample ratio: 0.8
 */
// Target: Period_in_Months
// Features: Offence, offence category (severity), intent, and sentence
// Issue: Duration is 0.00
//func noRepeatOffenderDurationModel(offense: String, severity: Int, intent: String, sentence: String) -> SentenceClassifier2Output?{
//    do{
//        // instantiate a new object model
//        let config = MLModelConfiguration()
//        // model
//        let durationModel = try SentenceClassifier2(configuration: config)
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
