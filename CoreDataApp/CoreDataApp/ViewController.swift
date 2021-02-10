//
//  ViewController.swift
//  CoreDataApp
//
//  Created by Krystyna Waniova on 15/12/2020.
//

import UIKit
import CoreData


class ViewController: UIViewController {
    
    

    @IBOutlet weak var tableView: UITableView!
    
    var notes: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title="Notes"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        // Do any additional setup after loading the view.
    }

    @IBAction func addNote(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "New Note",
                                        message: "Add a new note",
                                        preferredStyle: .alert)
          
        let saveAction = UIAlertAction(title: "Save", style: .default) {
          [unowned self] action in
          
          guard let textField = alert.textFields?.first,
            let noteToSave = textField.text else {
              return
          }
          
          self.save(text: noteToSave)
          self.tableView.reloadData()
        }
          
          let cancelAction = UIAlertAction(title: "Cancel",
                                           style: .cancel)
          
          alert.addTextField()
          
          alert.addAction(saveAction)
          alert.addAction(cancelAction)
          
          present(alert, animated: true)
    }
    
    func save(text: String) {
      
      guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
        return
      }
      
      // 1
      let managedContext =
        appDelegate.persistentContainer.viewContext
      
      // 2
      let entity =
        NSEntityDescription.entity(forEntityName: "Note",
                                   in: managedContext)!
      
      let note = NSManagedObject(entity: entity,
                                   insertInto: managedContext)
      
      // 3
      note.setValue(text, forKeyPath: "text")
      
      // 4
      do {
        try managedContext.save()
        notes.append(note)
      } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
      }
    }
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      
      //1
      guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
          return
      }
      
      let managedContext =
        appDelegate.persistentContainer.viewContext
      
      //2
      let fetchRequest =
        NSFetchRequest<NSManagedObject>(entityName: "Note")
      
      //3
      do {
        notes = try managedContext.fetch(fetchRequest)
      } catch let error as NSError {
        print("Could not fetch. \(error), \(error.userInfo)")
      }
    }

    
    
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    return notes.count
  }
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath)
                 -> UITableViewCell {

    let note = notes[indexPath.row]
       let cell =
         tableView.dequeueReusableCell(withIdentifier: "Cell",
                                       for: indexPath)
       cell.textLabel?.text =
         note.value(forKeyPath: "text") as? String
       return cell
  }
    
}



