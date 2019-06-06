//
//  ListViewController.swift
//  AboCheck
//
//  Created by Niklas Wagner on 15.05.19.
//  Copyright © 2019 Cortiel_Langer_Wagner. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
//    @IBOutlet var listViewController: UITableView!
    @IBOutlet var aboSearchBar: UISearchBar!
    @IBOutlet var aboTableView: UITableView!

    let allAbos = AboClass.allAbos
    var aboArray = AboClass.allAbos.getArrays()
    var currentAbos: [Abo] = [Abo]() // Filtered Abos for search bar

    override func viewDidLoad() {
        super.viewDidLoad()
        aboTableView.dataSource = self
        aboTableView.delegate = self
        aboSearchBar.delegate = self
        aboTableView.tableFooterView = UIView()
        
//        listViewController.tableFooterView = UIView()
    }
    override func viewWillAppear(_ animated: Bool) {
        allAbos.loadAbo()
//        listViewController.delegate = self
//        listViewController.dataSource = self
        
        currentAbos = aboArray
    }

    // Filter List with search bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        currentAbos = searchText.isEmpty ? aboArray : aboArray.filter { (item: Abo) -> Bool in

            // If Abo matches the searchText, return true to include it
            item.title?.range(of: searchText, range: nil, locale: nil) != nil
        }

        aboTableView.reloadData()
    }

    // Cancel search
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        aboSearchBar.showsCancelButton = true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return allAbos.count()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allAbos.count()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "aboCell", for: indexPath) as! ListTableViewCell
        let aboObject = allAbos.get(at: indexPath.row)
        cell.nameLabel?.text = aboObject?.title
        cell.costsLabel.text = aboObject?.costsMonthly.description
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
     
        let action = UIContextualAction(style: .destructive, title: "Delete") { _, _, completion in
            self.aboArray.remove(at: indexPath.row)
            self.aboTableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
        }

        // action.image = trash
        action.backgroundColor = .red

        return action
    }
}
