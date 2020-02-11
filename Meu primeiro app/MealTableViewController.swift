//
//  MealTableViewController.swift
//  Meu primeiro app
//
//  Created by Jonathan on 05/02/20.
//  Copyright © 2020 hbsis. All rights reserved.
//

import UIKit
import os.log

class MealTableViewController: UITableViewController {
    
    //MARK: Properties
    
    var bars = [Bar]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        
        loadSampleMeals()
    }
    
    private func loadSampleMeals() {
        let photo1 = UIImage(named: "Image-1")
        let photo2 = UIImage(named: "Image-2")
        let photo3 = UIImage(named: "Image-3")
        
        guard let Bar1 = Bar(name: "Bar do ze", photo: photo1, rating: 4, latitude: 1, longitude: 2, telefone: "nao")
            else {
                fatalError("Unable to in")
        }
        
        guard let Bar2 = Bar(name: "No trabalho", photo: photo2, rating: 4, latitude: 1, longitude: 2, telefone: "nao") else {
            fatalError("Unable to instantiate meal2")
        }
        
        guard let Bar3 = Bar(name: "Bar dos tiozinho", photo: photo3, rating: 4, latitude: 1, longitude: 2, telefone: "nao")
            else {
                fatalError("Unable to instantiate meal2")
                
        }
        bars += [Bar1, Bar2, Bar3]
        
    }
    

    override func numberOfSections(in tableView: UITableView) -> Int {
    
        return 1
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return bars.count
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            bars.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "MealTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MealTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let bar = bars[indexPath.row]
        cell.nameLabel.text = bar.name
        cell.photoImageView.image = bar.photo
        cell.ratingControl.ratiwg = bar.rating
        
        return cell
    }
    
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? ViewController, let bares = sourceViewController.bar {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing meal.
                bars[selectedIndexPath.row] = bares
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                
            // Add a new meal.
            let newIndexPath = IndexPath(row: bars.count, section: 0)
            
            bars.append(bares)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "AddItem":
            os_log("Adding a new meal.", log: OSLog.default, type: .debug)
            
        case "ShowDetail":
            guard let mealDetailViewController = segue.destination as? ViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedMealCell = sender as? MealTableViewCell else {
                fatalError("Unexpected sender: \(sender)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedMealCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedMeal = bars[indexPath.row]
            mealDetailViewController.bar = selectedMeal
            
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }

}
