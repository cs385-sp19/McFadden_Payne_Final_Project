/*  Name: Luke McFadden, Adam Payne
 *  Assignment: Final Project
 *  Documentation Stmt: None
 */

import Foundation
import UIKit

class ToDoViewController: UITableViewController {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var isCompleteButton: UIButton!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var dueDatePickerView: UIDatePicker!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var stepperLabel: UILabel!
    
    var isPickerHidden = true
    var todo: ToDo?
    
    @IBAction func amountStepper(_ sender: UIStepper) {
        sender.minimumValue = Double((-1 * (todo?.amount ?? 0)))
        updatetAmountLabel(amount: Int(sender.value))
    }
    
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        updateDueDateLabel(date: dueDatePickerView.date)
    }
    
    @IBAction func returnPressed(_ sender: UITextField) {
        titleTextField.resignFirstResponder()
    }
    
    @IBAction func isCompleteButtonTapped(_ sender: UIButton) {
        isCompleteButton.isSelected = !isCompleteButton.isSelected
    }
    
    func updatetAmountLabel(amount: Int) {
        let text = String(amount + (todo?.amount ?? 0))
        print("amount stepper is: ", amount)
        stepperLabel.text = text
    }
    
    func updateDueDateLabel(date: Date) {
        dueDateLabel.text = ToDo.dueDateFormatter.string(from: date)
    }
    
    func updateSaveButtonState() {
        let text = titleTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let normalCellHeight = CGFloat(44)
        let largeCellHeight = CGFloat(200)
        switch(indexPath) {
        case [1,0]: //Due Date Cell
            return isPickerHidden ? normalCellHeight : largeCellHeight
        case [2,0]: //Notes Cell
            return largeCellHeight
        default: return normalCellHeight
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "saveUnwind" else {return}
        let title = titleTextField.text!
        let isComplete = isCompleteButton.isSelected
        let dueDate = dueDatePickerView.date
        let amount = Int(stepperLabel.text ?? "0")
        let notes = notesTextView.text
        todo = ToDo(title: title, isComplete: isComplete, dueDate: dueDate,amount: amount ?? 0, notes: notes)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch(indexPath) {
        case[1,0]:
            isPickerHidden = !isPickerHidden
            dueDateLabel.textColor = isPickerHidden ? .black : tableView.tintColor
            tableView.beginUpdates()
            tableView.endUpdates()
        default: break
        }
    }
    
    func assignBackground(){
        tableView.backgroundView = UIImageView(image: UIImage(named: "graphPaperGreen"))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let todo = todo {
            navigationItem.title = "Task"
            titleTextField.text = todo.title
            isCompleteButton.isSelected = todo.isComplete
            dueDatePickerView.date = todo.dueDate
            notesTextView.text = todo.notes
            stepperLabel.text = String(todo.amount)
        }
        else {
            dueDatePickerView.date = Date().addingTimeInterval(24*60*60)
        }
        updateDueDateLabel(date: dueDatePickerView.date)
        updateSaveButtonState()
        //self.view.backgroundColor = UIColor(hue: 0.50, saturation: 0.66, brightness: 0.66, alpha: 1.0)
        assignBackground()
    }
}
