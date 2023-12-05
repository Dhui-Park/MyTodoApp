//
//  MemoCell.swift
//  MyTodoApp
//
//  Created by dhui on 12/4/23.
//

import UIKit
import SwipeCellKit

class MemoCell: SwipeTableViewCell {

    @IBOutlet weak var isDoneLabel: UILabel!
    
    @IBOutlet weak var todoContentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateUI(with cellData: Memo, delegate: SwipeTableViewCellDelegate) {
        print(#fileID, #function, #line, "- ")
        self.isDoneLabel.text = cellData.isDone ? "✅" : "☑️"
        self.todoContentLabel.text = cellData.content
        self.delegate = delegate
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
