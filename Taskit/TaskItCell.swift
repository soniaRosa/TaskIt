//
//  TaskItCell.swift
//  Taskit
//
//  Created by Sónia Rosa on 24/03/15.
//  Copyright (c) 2015 Sónia Rosa. All rights reserved.
//

import UIKit

class TaskItCell: UITableViewCell {
    
    
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
