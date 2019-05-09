/*  Name: Luke McFadden, Adam Payne
 *  Assignment: Final Project
 *  Documentation Stmt: None
 */

import Foundation
import UIKit

class ToDoTableViewController: UITableViewController, ToDoCellDelegate {
    var todos = [ToDo]()
    var indexPathForButton = IndexPath.init()
    
    @IBAction func unwindToToDoList(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind" else {return}
        let sourceViewController = segue.source as! ToDoViewController
        if let todo = sourceViewController.todo {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                todos[selectedIndexPath.row] = todo
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                let newIndexPath = IndexPath(row: todos.count, section: 0)
                todos.append(todo)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
        ToDo.saveToDos(todos)
    }
    
    func checkmarkTapped(sender: ToDoCell) {
        if let indexPath = tableView.indexPath(for: sender) {
            var todo = todos[indexPath.row]
            todo.isComplete = !todo.isComplete
            todos[indexPath.row] = todo
            tableView.reloadRows(at: [indexPath], with: .automatic)
            ToDo.saveToDos(todos)
            
            let buttonPosition: CGPoint = sender.convert(CGPoint.zero, to:self.tableView)
            let indexPath = self.tableView.indexPathForRow(at: buttonPosition)
            indexPathForButton = indexPath ?? IndexPath.init()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCellIdentifier") as? ToDoCell else {
            fatalError("Could not dequeue a cell")
        }
        let todo = todos[indexPath.row]
        cell.titleLabel?.text = todo.title
        cell.isCompleteButton.tag = indexPath.row
        cell.isCompleteButton.isSelected = todo.isComplete
        cell.backgroundColor = .clear
        cell.delegate = self
        return cell
    }
    
    func assignBackground(){
        tableView.backgroundView = UIImageView(image: UIImage(named: "graphPaperGreen"))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let savedToDos = ToDo.loadToDos() {
            todos = savedToDos } else {
            todos = ToDo.loadSampleToDos()
        }
        navigationItem.leftBarButtonItem = editButtonItem
        //self.view.backgroundColor = UIColor(hue: 0.25, saturation: 0.66, brightness: 0.66, alpha: 1.0)
        assignBackground()
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            ToDo.saveToDos(todos)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: (Any)?) {
        if segue.identifier == "showDetails" {
            let todoViewController = segue.destination as! ToDoViewController
            let indexPath = tableView.indexPathForSelectedRow!
            let selectedTodo = todos[indexPath.row]
            todoViewController.todo = selectedTodo
        }
        else if segue.identifier == "showGraph" {
            let graphViewController = segue.destination as! GraphViewController
            let indexPath = indexPathForButton
            let selectedTodo = todos[indexPath.row]
            graphViewController.todo = selectedTodo
        }
    }
}
