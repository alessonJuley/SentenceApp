import Foundation
import CreateML

/// Create a data table from a CSV file in the playground’s `Resources` folder.
let csvFile = Bundle.main.url(forResource: "MarsHabitats", withExtension: "csv")!
let dataTable = try MLDataTable(contentsOf: csvFile)
