//
//  TableViewController.swift
//  Ukol_iOS_2018
//
//  Created by Péter Karsai on 2018.06.19..
//  Copyright © 2018. My Web Kft. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var dataStore: DataStore!
    
    @IBAction func addNewNote(_ sender: Any) {
        dataStore.createNote(title: "New Note") {
            self.reloadNotes()
        }
    }
    
    // MARK: - Data Store
    
    func reloadNotes() {
        spinner.startAnimating()
        dataStore.getNotes {
            self.spinner.stopAnimating()
            self.tableView.reloadData()
        }
    }

    // MARK: - View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        reloadNotes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
         return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataStore.getNumberOfNotes()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)

        let note = dataStore.getNote(forRow: indexPath.row)
        cell.textLabel?.text = note.title

        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let note = dataStore.getNote(forRow: indexPath.row)
        performSegue(withIdentifier: "editNoteSegue", sender: note)
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let note = dataStore.getNote(forRow: indexPath.row)
            dataStore.deleteNote(withId: note.id!) {
                self.reloadNotes()
            }
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "editNoteSegue":
            let dvc = segue.destination as! NoteEditVC
            dvc.note = sender as! Note
            dvc.dataStore = dataStore
        default:
            preconditionFailure("Unrecognized segue identifier")
        }
    }

}
