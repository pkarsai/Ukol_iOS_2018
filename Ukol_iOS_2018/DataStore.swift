//
//  DataStore.swift
//  Ukol_iOS_2018
//
//  Created by Péter Karsai on 2018.06.19..
//  Copyright © 2018. My Web Kft. All rights reserved.
//

import Foundation

class DataStore {
    
    private let baseURL = URL(string: "https://api.my-web.hu/notes/index.php/notes")!
    private var notes = [Note]()
    
    func getNumberOfNotes() -> Int {
        return notes.count;
    }
    
    func createNote(title: String, completion: @escaping () -> Void) {
        let note: [String: Any] = ["title": title]
        var request = URLRequest(url: baseURL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONSerialization.data(withJSONObject: note, options: [])
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                print (error!)
                return
            }
            do {
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                let noteJSON = jsonObject as! [String: Any]
                if let newNote = Note(fromJSON: noteJSON) {
                    self.notes.append(newNote)
                } else {
                    print("Error creating note")
                }
            } catch (let error) {
                print(error)
            }
            OperationQueue.main.addOperation {
                completion()
            }
        }
        task.resume()
    }
 
    func getNotes(completion: @escaping () -> Void) {
        let request = URLRequest(url: baseURL)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                print (error!)
                return
            }
            do {
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                if let notesArray = jsonObject as? [AnyObject] {
                    self.notes.removeAll()
                    for note in notesArray {
                        let noteJSON = note as! [String: Any]
                        if let newNote = Note(fromJSON: noteJSON) {
                            self.notes.append(newNote)
                        } else {
                            print("Error creating note")
                        }
                    }
                } else {
                    print("Unexpected JSON structure")
                }
            } catch (let error) {
                print(error)
            }

            OperationQueue.main.addOperation {
                completion()
            }
        }
        task.resume()
    }
    
    func getNote(forRow row: Int) -> Note {
        return notes[row]
    }
    
    func deleteNote(withId id: Int, completion: @escaping () -> Void) {
        let url = URL(string: "\(baseURL)/index/\(id)")!
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if (error != nil) {
                print(error!)
                return
            }
            OperationQueue.main.addOperation {
                completion()
            }
        }
        task.resume()
    }
    
    func updateNote(aNote note: Note, completion: @escaping () -> Void) {
        let note: [String: Any] = ["id": note.id!, "title": note.title!]
        let url = URL(string: "\(baseURL)/index/\(note["id"]!)")!
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONSerialization.data(withJSONObject: note, options: [])
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if (error != nil) {
                print(error!)
                return
            }
            OperationQueue.main.addOperation {
                completion()
            }
        }
        task.resume()
    }
    
}
