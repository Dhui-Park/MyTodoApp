//
//  ViewController.swift
//  MyTodoApp
//
//  Created by dhui on 12/4/23.
//

import UIKit

class MemoListVC: UIViewController {
    
    enum SectionType: Int {
        case normal = 0
        case favorite = 1
        case pinned = 2
    }

    @IBOutlet weak var deleteAllBtn: UIBarButtonItem!
    
    @IBOutlet weak var writeANewTodoBtn: UIBarButtonItem!
    
    @IBOutlet weak var memoTableView: UITableView!
    
    var memoList: [Memo] = [Memo(), Memo(), Memo(), Memo()]
    var favoriteMemoList = [Memo(), Memo(), Memo(), Memo()]
    var pinnedMemoList = [Memo(), Memo(), Memo(), Memo()]
    
    var snapshot = NSDiffableDataSourceSnapshot<SectionType, Memo>()
    
    var dataSource: UITableViewDiffableDataSource<SectionType, Memo>? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellNib = UINib(nibName: "MemoCell", bundle: nil)
        self.memoTableView.register(cellNib, forCellReuseIdentifier: "MemoCell")
        
        /// cellProvider: 결국 cellForRowAt에 해당하는 것.
        dataSource = UITableViewDiffableDataSource(tableView: self.memoTableView, cellProvider: { (tableView, indexPath, item) -> UITableViewCell? in
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MemoCell", for: indexPath) as? MemoCell else { return nil }
            
            cell.isDoneLabel.text = item.isDone ? "✅" : "☑️"
            cell.todoContentLabel.text = item.content
            
            return cell
        })
        
        self.snapshot.appendSections([.normal])
        self.snapshot.appendItems(memoList, toSection: .normal)
        
        self.dataSource?.apply(self.snapshot, animatingDifferences: true)
        
    } // viewDidLoad()


}

