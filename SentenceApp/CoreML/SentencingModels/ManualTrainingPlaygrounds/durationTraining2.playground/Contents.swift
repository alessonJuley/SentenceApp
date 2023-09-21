import Cocoa
import CoreML
import CreateML

// ========================================NOTE========================================
// DON'T CHOOSE ANY CLASSIFIER.
// DATASET: trainingCases1
// =======================================RESULTS======================================
// BEST RESULTS
// Algorithm: MLRandomForestClassifier
// trainingAccuracy: 54.700854700854705
// validationAccuracy: 7.14285714285714
// evaluationAccuracy: 15.555555555555555

// WORST RESULTS
// Algorithm: MLBoostedTreeClassifier
// trainingAccuracy: 94.87179487179486
// validationAccuracy: 14.28571428571428
// evaluationAccuracy: 17.777777777777782

// ========================================NOTE========================================

// Step 1: Load the csv file (dataset)
guard let csvFile = Bundle.main.url(forResource: "trainingCases1", withExtension: "csv"), let createDataTable = try? MLDataTable(contentsOf: csvFile) else{
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
// Random forest classifier:
// --------------------------------------------------------
// Number of examples          : 117
// Number of classes           : 48
// Number of feature columns   : 5
// Number of unpacked features : 5
// +-----------+--------------+-------------------+---------------------+-------------------+---------------------+
// | Iteration | Elapsed Time | Training Accuracy | Validation Accuracy | Training Log Loss | Validation Log Loss |
// +-----------+--------------+-------------------+---------------------+-------------------+---------------------+
// | 1         | 0.036223     | 0.435897          | 0.111111            | 2.735749          | 4.101709            |
// | 2         | 0.067629     | 0.487179          | 0.111111            | 2.153470          | 3.382450            |
// | 3         | 0.096552     | 0.512820          | 0.111111            | 2.062029          | 3.255513            |
// | 4         | 0.127358     | 0.504274          | 0.111111            | 2.040940          | 3.067431            |
// | 5         | 0.156731     | 0.555556          | 0.222222            | 2.036278          | 2.972561            |
// | 10        | 0.311221     | 0.547009          | 0.111111            | 2.000584          | 2.959464            |
// +-----------+--------------+-------------------+---------------------+-------------------+---------------------+
// trainingAccuracy: 54.700854700854705
// validationAccuracy: 7.14285714285714
// evaluationAccuracy: 15.555555555555555

let classifier = try MLRandomForestClassifier(trainingData: classifierTrainingTable, targetColumn: "totalDuration")
// =========================================MLRandomForestClassifier=========================================



// =========================================MLDecisionTreeClassifier=========================================
// MLDecisionTreeClassifier
// Decision tree classifier:
// --------------------------------------------------------
// Number of examples          : 117
// Number of classes           : 48
// Number of feature columns   : 5
// Number of unpacked features : 5
// +-----------+--------------+-------------------+---------------------+-------------------+---------------------+
// | Iteration | Elapsed Time | Training Accuracy | Validation Accuracy | Training Log Loss | Validation Log Loss |
// +-----------+--------------+-------------------+---------------------+-------------------+---------------------+
// | 1         | 0.043312     | 0.512820          | 0.111111            | 1.804656          | 3.341231            |
// +-----------+--------------+-------------------+---------------------+-------------------+---------------------+
// trainingAccuracy: 51.28205128205128
// validationAccuracy: 7.14285714285714
// evaluationAccuracy: 15.555555555555555

// let classifier = try MLDecisionTreeClassifier(trainingData: classifierTrainingTable, targetColumn: "totalDuration")
// =========================================MLDecisionTreeClassifier=========================================



// =========================================MLBoostedTreeClassifier=========================================
// MLBoostedTreeClassifier
// Boosted trees classifier:
// --------------------------------------------------------
// Number of examples          : 117
// Number of classes           : 48
// Number of feature columns   : 5
// Number of unpacked features : 5
// +-----------+--------------+-------------------+---------------------+-------------------+---------------------+
// | Iteration | Elapsed Time | Training Accuracy | Validation Accuracy | Training Log Loss | Validation Log Loss |
// +-----------+--------------+-------------------+---------------------+-------------------+---------------------+
// | 1         | 0.039463     | 0.512820          | 0.111111            | 2.708529          | 3.431549            |
// | 2         | 0.075299     | 0.675214          | 0.111111            | 2.336820          | 3.160709            |
// | 3         | 0.113493     | 0.803419          | 0.111111            | 2.023893          | 2.982090            |
// | 4         | 0.152088     | 0.837607          | 0.222222            | 1.754241          | 2.920033            |
// | 5         | 0.192921     | 0.880342          | 0.222222            | 1.524181          | 2.768781            |
// | 10        | 0.400337     | 0.948718          | 0.222222            | 0.803667          | 2.484626            |
// +-----------+--------------+-------------------+---------------------+-------------------+---------------------+
// trainingAccuracy: 94.87179487179486
// validationAccuracy: 14.28571428571428
// evaluationAccuracy: 17.777777777777782

// let classifier = try MLBoostedTreeClassifier(trainingData: classifierTrainingTable, targetColumn: "totalDuration")
// =========================================MLBoostedTreeClassifier=========================================



// =========================================MLLogisticRegressionClassifier=========================================
// MLLogisticRegressionClassifier
// Logistic regression:
// --------------------------------------------------------
// Number of examples          : 117
// Number of classes           : 48
// Number of feature columns   : 5
// Number of unpacked features : 5
// Number of coefficients      : 1034
// Starting L-BFGS
// --------------------------------------------------------
// +-----------+----------+-----------+--------------+-------------------+---------------------+
// | Iteration | Passes   | Step size | Elapsed Time | Training Accuracy | Validation Accuracy |
// +-----------+----------+-----------+--------------+-------------------+---------------------+
// | 0         | 4        | 21.000000 | 0.001448     | 0.239316          | 0.000000            |
// | 1         | 9        | 1.839713  | 0.003298     | 0.427350          | 0.071429            |
// | 2         | 11       | 1.160420  | 0.004267     | 0.512821          | 0.142857            |
// | 3         | 17       | 2.196992  | 0.006103     | 0.692308          | 0.071429            |
// | 4         | 18       | 2.196992  | 0.006754     | 0.735043          | 0.142857            |
// | 9         | 28       | 1.000000  | 0.011036     | 0.769231          | 0.071429            |
// +-----------+----------+-----------+--------------+-------------------+---------------------+
// trainingAccuracy: 76.92307692307693
// validationAccuracy: 7.14285714285714
// evaluationAccuracy: 13.33333333333333

// let classifier = try MLLogisticRegressionClassifier(trainingData: classifierTrainingTable, targetColumn: "totalDuration")
// =========================================MLLogisticRegressionClassifier=========================================



// =========================================MLSupportVectorClassifier=========================================
// MLSupportVectorClassifier
// Playground execution terminated: An error was thrown and was not caught:
// ▿ Linear SVM currently only supports binary classification. Use the boosted_trees_classifier for multi-class classification.
//
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
let metaData = MLModelMetadata(author: "Alesson Abao", shortDescription: "Duration output using classifier. Added sentence column.", version: "1.3")

// Step 6: Create variable where you want to save the model
let outputFileName = "/Users/alessonabao/Desktop/TrainingDurationClassifierModel.mlmodel"
try classifier.write(toFile: outputFileName, metadata: metaData)
