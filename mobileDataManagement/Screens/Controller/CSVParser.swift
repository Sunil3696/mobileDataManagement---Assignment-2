class CSVParser {
    func parseCSV(_ csvData: String) -> [[String: String]] {
        var result: [[String: String]] = []
        let rows = csvData.components(separatedBy: "\n")
        
        // Ensure the header is correctly split
        guard let header = rows.first?.components(separatedBy: ",") else { return result }
        
        // Iterate over each row after the header
        for row in rows.dropFirst() {
            // Handle rows with quoted fields containing commas and newlines
            var columns: [String] = []
            var currentColumn = ""
            var insideQuotes = false
            
            for character in row {
                if character == "\"" {
                    insideQuotes.toggle()
                } else if character == "," && !insideQuotes {
                    columns.append(currentColumn)
                    currentColumn = ""
                } else {
                    currentColumn.append(character)
                }
            }
            // Append the last column
            columns.append(currentColumn)
            
            // Map the columns to the header
            var rowData: [String: String] = [:]
            for (index, column) in columns.enumerated() {
                if index < header.count {
                    rowData[header[index]] = column
                }
            }
            result.append(rowData)
        }
        
        return result
    }
}
