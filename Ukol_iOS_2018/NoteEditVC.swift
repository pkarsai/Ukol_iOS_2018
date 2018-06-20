//
//  NoteEditVC.swift
//  Ukol_iOS_2018
//
//  Created by Péter Karsai on 2018.06.19..
//  Copyright © 2018. My Web Kft. All rights reserved.
//

import UIKit

class NoteEditVC: UIViewController {

    @IBOutlet weak var noteView: UITextView!
    
    var note: Note!
    var dataStore: DataStore!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBAction func saveNote(_ sender: Any) {
        spinner.startAnimating()
        note.title = noteView.text
        dataStore.updateNote(aNote: note) {
            self.spinner.stopAnimating()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        noteView.text = note.title
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
