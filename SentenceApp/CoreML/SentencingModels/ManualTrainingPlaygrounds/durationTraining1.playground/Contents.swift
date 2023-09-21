import Cocoa
import CoreML
import CreateML

// ========================================NOTE========================================
// DON'T CHOOSE ANY CLASSIFIER.
// DATASET: allCases1
// =======================================RESULTS======================================
// BEST RESULTS
// Algorithm: MLRandomForestClassifier
// trainingAccuracy: 48.529411764705884
// validationAccuracy: 29.41176470588236
// evaluationAccuracy: 27.692307692307693

// WORST RESULTS
// Algorithm: MLLogisticRegressionClassifier
// trainingAccuracy: 61.76470588235294
// validationAccuracy: 11.764705882352944
// evaluationAccuracy: 24.615384615384617
// ========================================NOTE========================================

// Step 1: Load the csv file (dataset)
guard let csvFile = Bundle.main.url(forResource: "allCases1", withExtension: "csv"), let createDataTable = try? MLDataTable(contentsOf: csvFile) else{
    fatalError("Unable to load data")
}

// Step 2: Set columns (features) that we are going to based on the output (target)
let classifierColumns = ["offence", "offenceCategory", "intent", "remandDuration", "totalDuration", "sentence", "sentenceType", "totalDuration"]
// these are the columns we are interested in (columns should reflect what's in the dataset)
let classifierTable = createDataTable[classifierColumns]

// Step 3: Randomly split data to training and testing data. Training = 80%, testing = 20%
let (classifierTestingTable, classifierTrainingTable) = classifierTable.randomSplit(by: 0.20, seed: 5)


// Step 4: Call MLRandomForestClassifier. targetColumn value should exist in the chosen columns (classifierColumns)

// =========================================MLRandomForestClassifier=========================================
// MLRandomForestClassifier
// durationTraining1 results
// Using 5 features to train a model to predict totalDuration.
// Random forest classifier:
// --------------------------------------------------------
// Number of examples          : 204
// Number of classes           : 59
// Number of feature columns   : 5
// Number of unpacked features : 5
// +-----------+--------------+-------------------+---------------------+-------------------+---------------------+
// | Iteration | Elapsed Time | Training Accuracy | Validation Accuracy | Training Log Loss | Validation Log Loss |
// +-----------+--------------+-------------------+---------------------+-------------------+---------------------+
// | 1         | 0.046908     | 0.436275          | 0.250000            | 2.451836          | 3.168804            |
// | 2         | 0.091690     | 0.450980          | 0.250000            | 2.201256          | 2.876478            |
// | 3         | 0.134730     | 0.504902          | 0.333333            | 2.155759          | 2.821800            |
// | 4         | 0.179417     | 0.495098          | 0.166667            | 2.168501          | 2.852478            |
// | 5         | 0.227248     | 0.470588          | 0.500000            | 2.149207          | 2.852477            |
// | 10        | 0.444867     | 0.485294          | 0.416667            | 2.146212          | 2.730868            |
// +-----------+--------------+-------------------+---------------------+-------------------+---------------------+
// trainingAccuracy: 48.529411764705884
// validationAccuracy: 29.41176470588236
// evaluationAccuracy: 27.692307692307693

let classifier = try MLRandomForestClassifier(trainingData: classifierTrainingTable, targetColumn: "totalDuration")
// =========================================MLRandomForestClassifier=========================================



// =========================================MLDecisionTreeClassifier=========================================
// MLDecisionTreeClassifier
// durationTraining1 results
// Decision tree classifier:
// --------------------------------------------------------
// Number of examples          : 204
// Number of classes           : 59
// Number of feature columns   : 5
// Number of unpacked features : 5
// +-----------+--------------+-------------------+---------------------+-------------------+---------------------+
// | Iteration | Elapsed Time | Training Accuracy | Validation Accuracy | Training Log Loss | Validation Log Loss |
// +-----------+--------------+-------------------+---------------------+-------------------+---------------------+
// | 1         | 0.052815     | 0.470588          | 0.416667            | 2.140780          | 2.923061            |
// +-----------+--------------+-------------------+---------------------+-------------------+---------------------+
// trainingAccuracy: 47.05882352941176
// validationAccuracy: 29.41176470588236
// evaluationAccuracy: 27.692307692307693

// let classifier = try MLDecisionTreeClassifier(trainingData: classifierTrainingTable, targetColumn: "totalDuration")
// =========================================MLDecisionTreeClassifier=========================================



// =========================================MLBoostedTreeClassifier=========================================
// MLBoostedTreeClassifier

// Boosted trees classifier:
// --------------------------------------------------------
// Number of examples          : 204
// Number of classes           : 59
// Number of feature columns   : 5
// Number of unpacked features : 5
// +-----------+--------------+-------------------+---------------------+-------------------+---------------------+
// | Iteration | Elapsed Time | Training Accuracy | Validation Accuracy | Training Log Loss | Validation Log Loss |
// +-----------+--------------+-------------------+---------------------+-------------------+---------------------+
// | 1         | 0.053459     | 0.470588          | 0.416667            | 2.867063          | 3.434886            |
// | 2         | 0.107805     | 0.539216          | 0.416667            | 2.467025          | 3.150096            |
// | 3         | 0.168977     | 0.568627          | 0.416667            | 2.167927          | 2.977915            |
// | 4         | 0.224899     | 0.607843          | 0.416667            | 1.924110          | 2.850782            |
// | 5         | 0.281079     | 0.666667          | 0.416667            | 1.725105          | 2.773834            |
// | 10        | 0.570203     | 0.754902          | 0.416667            | 1.097007          | 2.555672            |
// +-----------+--------------+-------------------+---------------------+-------------------+---------------------+
// trainingAccuracy: 75.49019607843137
// validationAccuracy: 29.41176470588236
// evaluationAccuracy: 26.15384615384615

// let classifier = try MLBoostedTreeClassifier(trainingData: classifierTrainingTable, targetColumn: "totalDuration")
// =========================================MLBoostedTreeClassifier=========================================



// =========================================MLLogisticRegressionClassifier=========================================
// MLLogisticRegressionClassifier
// Logistic regression:
// --------------------------------------------------------
// Number of examples          : 204
// Number of classes           : 59
// Number of feature columns   : 5
// Number of unpacked features : 5
// Number of coefficients      : 2088
// Starting L-BFGS
// --------------------------------------------------------
// +-----------+----------+-----------+--------------+-------------------+---------------------+
// | Iteration | Passes   | Step size | Elapsed Time | Training Accuracy | Validation Accuracy |
// +-----------+----------+-----------+--------------+-------------------+---------------------+
// | 0         | 4        | 21.000000 | 0.002809     | 0.215686          | 0.117647            |
// | 1         | 9        | 1.350329  | 0.005356     | 0.240196          | 0.176471            |
// | 2         | 14       | 0.815454  | 0.007762     | 0.294118          | 0.058824            |
// | 3         | 15       | 1.000000  | 0.008600     | 0.333333          | 0.058824            |
// | 4         | 16       | 1.000000  | 0.009447     | 0.553922          | 0.117647            |
// | 9         | 25       | 1.000000  | 0.014965     | 0.617647          | 0.117647            |
// +-----------+----------+-----------+--------------+-------------------+---------------------+
// trainingAccuracy: 61.76470588235294
// validationAccuracy: 11.764705882352944
// evaluationAccuracy: 24.615384615384617

// let classifier = try MLLogisticRegressionClassifier(trainingData: classifierTrainingTable, targetColumn: "totalDuration")
// =========================================MLLogisticRegressionClassifier=========================================



// =========================================MLSupportVectorClassifier=========================================
// MLSupportVectorClassifier
// durationTraining1 results
// Using 5 features to train a model to predict totalDuration.
// Playground execution terminated: An error was thrown and was not caught:
// ▿ Linear SVM currently only supports binary classification. Use the boosted_trees_classifier for multi-class classification.
//  ▿ generic : 1 element
//    - reason : "Linear SVM currently only supports binary classification. Use the boosted_trees_classifier for multi-class classification.\n"

// let classifier = try MLSupportVectorClassifier(trainingData: classifierTrainingTable, targetColumn: "totalDuration")
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
let metaData = MLModelMetadata(author: "Alesson Abao", shortDescription: "Duration output using classifier. Added sentence column.", version: "1.2")

// Step 6: Create variable where you want to save the model
let outputFileName = "/Users/alessonabao/Desktop/AllDurationClassifierModel.mlmodel"
try classifier.write(toFile: outputFileName, metadata: metaData)
