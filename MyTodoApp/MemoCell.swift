//
//  MemoCell.swift
//  MyTodoApp
//
//  Created by dhui on 12/4/23.
//

import UIKit

class MemoCell: UITableViewCell {

    @IBOutlet weak var isDoneLabel: UILabel!
    
    @IBOutlet weak var todoContentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
