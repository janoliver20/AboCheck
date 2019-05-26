//
//  ListViewController.swift
//  AboCheck
//
//  Created by Niklas Wagner on 15.05.19.
//  Copyright © 2019 Cortiel_Langer_Wagner. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    @IBOutlet weak var ListViewController: UITableView!
    
    let allAbos = AboClass.allAbos

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        allAbos.loadAbo()
        ListViewController.delegate = self
        ListViewController.dataSource = self
        
    }
    
   

}

extension ListViewController:  UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}
