import Foundation

struct ToDo: Codable {
    var title: String
    var isComplete: Bool
    var dueDate: Date
    var amount: Int
    var notes: String?

    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("todos").appendingPathExtension("plist")
    
    static func loadToDos() -> [ToDo]? {
        guard let codedToDos = try? Data(contentsOf: ArchiveURL) else {return nil}
        let propertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode(Array<ToDo>.self, from: codedToDos)
    }
    
    static func saveToDos(_ todos: [ToDo]) {
        let propertyListEncoder = PropertyListEncoder()
        let codedToDos = try? propertyListEncoder.encode(todos)
        try? codedToDos?.write(to: ArchiveURL, options: .noFileProtection)
    }
    
    static func loadSampleToDos() -> [ToDo] {
        let todo1 = ToDo(title: "Hours of sleep", isComplete: false, dueDate: Date(),amount: 2, notes: "Not enough")
        let todo2 = ToDo(title: "Miles run", isComplete: false, dueDate: Date(), amount: 0, notes: "Above zero?")
        let todo3 = ToDo(title: "Times I've been to Walmart", isComplete: false, dueDate: Date(), amount: 4, notes: "You know it's alot.")
        return [todo1, todo2, todo3]
    }
    
    static let dueDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
}
