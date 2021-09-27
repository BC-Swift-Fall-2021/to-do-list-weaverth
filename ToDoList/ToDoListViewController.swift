//
//  ViewController.swift
//  ToDoList
//
//  Created by Teddy Weaver on 9/21/21.
//

import UIKit

class ToDoListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var toDoArray = ["Learn Swift", "Build Apps", "Change the World", "Take a Vacation"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            let destination = segue.destination as! ToDoDetailTableViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            destination.toDoItem = toDoArray[selectedIndexPath.row]
        }
        else{
            if let selectedIndexPath = tableView.indexPathForSelectedRow{
                tableView.deselectRow(at: selectedIndexPath, animated: true)
            }
        }
    }

    @IBAction func unwindFromDetail(segue: UIStoryboardSegue) {
        let source = segue.source as! ToDoDetailTableViewController
        if let selectedIndexPath = tableView.indexPathForSelectedRow{
            toDoArray[selectedIndexPath.row] = source.toDoItem
            tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
        }
        else{
            let newIndexPath = IndexPath(row: toDoArray.count, section: 0)
            toDoArray.append(source.toDoItem)
            tableView.insertRows(at: [newIndexPath], with: .bottom)
            tableView.scrollToRow(at: newIndexPath, at: .bottom, animated: true)
        }
    }
}

extension ToDoListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("😎 numberOfRowsinSection was just called. Returning \(toDoArray.count)")
        return toDoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("🥸 cellForRowAt was just called for indexPath.row = \(indexPath.row) which is the cell containing \(toDoArray[indexPath.row])")
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = toDoArray[indexPath.row]
        return cell
    }
}
