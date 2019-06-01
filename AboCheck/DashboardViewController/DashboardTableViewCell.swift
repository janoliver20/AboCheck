//
//  DashboardTableCellViewController.swift
//  AboCheck
//
//  Created by Jan Cortiel on 26.05.19.
//  Copyright © 2019 Cortiel_Langer_Wagner. All rights reserved.
//

import UIKit

class DashBoardTableViewCell: UITableViewCell {
    
    var abo: Abo? {
        didSet {
            aboTitleLbl.text = abo?.title
            let nextPayment = abo?.getDurationTillNextPayDate()
            
            if abo?.endDate != nil {
                countDaysLbl.text = "End in \(String(describing: nextPayment)) days!"
            }
            else {
                countDaysLbl.text = "Next Payment in \(String(describing: nextPayment)) days!"
            }
            
            
        }
    }
    
    private let aboTitleLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.black
        lbl.textAlignment = .left
        return lbl
    }()
    
    private let countDaysLbl: UILabel  = {
        let lbl = UILabel()
        lbl.textColor = UIColor.red
        lbl.textAlignment = .left
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(aboTitleLbl)
        addSubview(countDaysLbl)
        
        aboTitleLbl.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 0, enableInsets: false)
        countDaysLbl.anchor(top: aboTitleLbl.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 8, width: 0, height: 0, enableInsets: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}
