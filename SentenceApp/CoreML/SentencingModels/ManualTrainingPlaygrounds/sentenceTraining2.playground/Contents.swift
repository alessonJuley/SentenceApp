import Cocoa
import CoreML
import CreateML

// ========================================NOTE========================================
// CHOOSE ANY CLASSIFIER
// DATASET: trainingCases1
// =======================================RESULTS======================================
// trainingAccuracy: 96.58119658119658
// validationAccuracy: 100.0
// evaluationAccuracy: 97.77777777777777
// ========================================NOTE========================================

// Step 1: Load the csv file (dataset)
guard let csvFile = Bundle.main.url(forResource: "trainingCases1", withExtension: "csv"), let createDataTable = try? MLDataTable(contentsOf: csvFile) else{
    fatalError("Unable to load data")
}

// Step 2: Set columns (features) that we are going to based on the output (target)
let classifierColumns = ["offence", "offenceCategory", "intent", "sentence"]
// these are the columns we are interested in (columns should reflect what's in the dataset)
let classifierTable = createDataTable[classifierColumns]

// Step 3: Randomly split data to training and testing data. Training = 80%, testing = 20%
let (classifierTestingTable, classifierTrainingTable) = classifierTable.randomSplit(by: 0.20, seed: 5)

// Step 4: Call MLRandomForestClassifier. targetColumn value should exist in the chosen columns (classifierColumns)

// =========================================MLRandomForestClassifier=========================================
// MLRandomForestClassifier
// trainingAccuracy: 96.58119658119658
// validationAccuracy: 100.0
// evaluationAccuracy: 97.77777777777777
let classifier = try MLRandomForestClassifier(trainingData: classifierTrainingTable, targetColumn: "sentence")
// =========================================MLRandomForestClassifier=========================================



// =========================================MLDecisionTreeClassifier=========================================
// MLDecisionTreeClassifier
// trainingAccuracy: 96.58119658119658
// validationAccuracy: 100.0
// evaluationAccuracy: 97.77777777777777
// let classifier = try MLDecisionTreeClassifier(trainingData: classifierTrainingTable, targetColumn: "sentence")
// =========================================MLDecisionTreeClassifier=========================================



// =========================================MLBoostedTreeClassifier=========================================
// MLBoostedTreeClassifier
// trainingAccuracy: 96.58119658119658
// validationAccuracy: 100.0
//  evaluationAccuracy: 97.77777777777777
// let classifier = try MLBoostedTreeClassifier(trainingData: classifierTrainingTable, targetColumn: "sentence")
// =========================================MLBoostedTreeClassifier=========================================



// =========================================MLLogisticRegressionClassifier=========================================
// MLLogisticRegressionClassifier
// trainingAccuracy: 96.58119658119658
// validationAccuracy: 100.0
// evaluationAccuracy: 97.77777777777777
// let classifier = try MLLogisticRegressionClassifier(trainingData: classifierTrainingTable, targetColumn: "sentence")
// =========================================MLLogisticRegressionClassifier=========================================



// =========================================MLSupportVectorClassifier=========================================
// MLSupportVectorClassifier
//▿ Linear SVM currently only supports binary classification. Use the boosted_trees_classifier for multi-class classification.
//
//  ▿ generic : 1 element
//    - reason : "Linear SVM currently only supports binary classification. Use the boosted_trees_classifier for multi-class classification.\n"

// let classifier = try MLSupportVectorClassifier(trainingData: classifierTrainingTable, targetColumn: "sentence")
// =========================================MLSupportVectorClassifier=========================================



// evaluate the classifier
// Classifier training accuracy as a percentage
let trainingError = classifier.trainingMetrics.classificationError
let trainingAccuracy = (1.0 - trainingError) * 100
print("trainingAccuracy: \(trainingAccuracy)")

// Classifier validation accuracy as a percentage
let validationError = classifier.validationMetrics.classificationError
let validationAccuracy = (1.0 - validationError) * 100
print("validationAccuracy: \(validationAccuracy)")

// Evaluate the classifier
let classifierEvaluation = classifier.evaluation(on: classifierTestingTable)

// Classifier evaluation accuracy as a percentage
let evaluationError = classifierEvaluation.classificationError
let evaluationAccuracy = (1.0 - evaluationError) * 100
print("evaluationAccuracy: \(evaluationAccuracy)")


// Step 5: Create metadata (additional data associated with the actual model, model info)
let metaData = MLModelMetadata(author: "Alesson Abao", shortDescription: "Sentence output using MLRandomForestClassifier", version: "2.0")

// Step 6: Create variable where you want to save the model
// let outputFileName = "insertDirectory/modelName.mlmodel"
// try classifier.write(toFile: outputFileName, metadata: metaData)
