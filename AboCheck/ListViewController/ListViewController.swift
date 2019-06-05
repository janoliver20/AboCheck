//
//  ListViewController.swift
//  AboCheck
//
//  Created by Niklas Wagner on 15.05.19.
//  Copyright © 2019 Cortiel_Langer_Wagner. All rights reserved.
//

import UIKit


class ListViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var listViewController: UITableView!
    @IBOutlet weak var aboSearchBar: UISearchBar!
    @IBOutlet weak var aboTableView: UITableView!
    
    
    
    let allAbos = AboClass.allAbos
    var aboArray = AboClass.allAbos.getArrays()
    var currentAbos = [Abo]() // Filtered Abos for search bar
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aboTableView.dataSource = self
        aboSearchBar.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        allAbos.loadAbo()
        listViewController.delegate = self
        listViewController.dataSource = self
        currentAbos = aboArray
    }
    
    
    // Filter List with search bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        currentAbos = searchText.isEmpty ? aboArray : aboArray.filter { (item: Abo) -> Bool in
            
            // If Abo matches the searchText, return true to include it
            return item.title?.range(of: searchText, range: nil, locale: nil) != nil
        }
        
        aboTableView.reloadData()
        
    }
    
    
    // Cancel search
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.aboSearchBar.showsCancelButton = true
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    
}

extension ListViewController:  UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return allAbos.count()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentAbos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "aboCell", for: indexPath) as! ListTableViewCell
        cell.nameLabel?.text = currentAbos[indexPath.row].title
        cell.costsLabel.text = currentAbos[indexPath.row].costsMonthly.description
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    // Swiping actions
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = deleteAction(at: indexPath)
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
        
    //    let abo = aboArray[indexPath.row]
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            self.aboArray.remove(at: indexPath.row)
            self.aboTableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
        }
        
       // action.image = trash
        action.backgroundColor = .red
        
        return action
        
    }
    
    
    
    
}


