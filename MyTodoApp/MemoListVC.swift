//
//  ViewController.swift
//  MyTodoApp
//
//  Created by dhui on 12/4/23.
//

import UIKit

class MemoListVC: UIViewController {
    
    enum SectionType: Int {
        case all = 0 // 전체
        case isDone = 1 // 완료
        case isNotDone = 2 // 미완료
    }

    @IBOutlet weak var deleteAllBtn: UIBarButtonItem!
    
    @IBOutlet weak var writeANewMemoBtn: UIBarButtonItem!
    
    @IBOutlet weak var memoTableView: UITableView!
    
    var memoList: [Memo] = [Memo(), Memo(), Memo(), Memo()]
    var favoriteMemoList = [Memo(), Memo(), Memo(), Memo()]
    var pinnedMemoList = [Memo(), Memo(), Memo(), Memo()]
    
    var snapshot = NSDiffableDataSourceSnapshot<SectionType, Memo>()
    
    var dataSource: UITableViewDiffableDataSource<SectionType, Memo>? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        
        self.snapshot.appendSections([.all])
        self.snapshot.appendItems(memoList, toSection: .all)
        self.dataSource?.apply(self.snapshot, animatingDifferences: true)
        
        addActions()
    } // viewDidLoad()
    
    fileprivate func addActions() {
        self.writeANewMemoBtn.target = self
        self.writeANewMemoBtn.action = #selector(showAddMemoAlert(_:))
    }

}

//MARK: - IBActions
extension MemoListVC {
    @objc fileprivate func showAddMemoAlert(_ sender: UIBarButtonItem) {
        print(#fileID, #function, #line, "- ")
        
        let alert = UIAlertController(title: "새로운 메모 추가하기", message: "새 메모를 추가해주세요", preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: { tf in
            print(#fileID, #function, #line, "- tf.text: \(tf.text)")
        })
        
        alert.textFields?.first?.placeholder = "빡코딩하기"
        
        let addMemoAction = UIAlertAction(title: NSLocalizedString("추가", comment: "추가 액션"), style: .default, handler: { [weak self] _ in
            guard let userInput =  alert.textFields?.first?.text, let self = self else {
                print(#fileID, #function, #line, "- 작성된 내용이 없습니다.")
                return
            }
            print(#fileID, #function, #line, "- userInput: \(userInput)")
            
            let newMemo = Memo(content: userInput)
            
            memoList.insert(newMemo, at: 0)
            
            self.snapshot.appendItems(memoList, toSection: .all)
            self.dataSource?.apply(self.snapshot, animatingDifferences: true)
            
        })
        
        let dismissAction = UIAlertAction(title: "닫기", style: .destructive)
        
        alert.addAction(addMemoAction)
        alert.addAction(dismissAction)
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension MemoListVC {
    
    fileprivate func configureTableView() {
        let cellNib = UINib(nibName: "MemoCell", bundle: nil)
        self.memoTableView.register(cellNib, forCellReuseIdentifier: "MemoCell")
        
        self.memoTableView.delegate = self
        
        /// cellProvider: 결국 cellForRowAt에 해당하는 것.
        dataSource = UITableViewDiffableDataSource(tableView: self.memoTableView, cellProvider: { (tableView, indexPath, item) -> UITableViewCell? in
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MemoCell", for: indexPath) as? MemoCell else { return nil }
            
            cell.isDoneLabel.text = item.isDone ? "✅" : "☑️"
            cell.todoContentLabel.text = item.content
            
            return cell
        })
    }
}

extension MemoListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let filterAllAction = UIAction(title: "전체", handler: { _ in
            print(#fileID, #function, #line, "- 전체")
        })
        
        let filterIsDoneAction = UIAction(title: "완료", handler: { _ in
            print(#fileID, #function, #line, "- 완료")
        })
        
        let filterIsNotDoneAction = UIAction(title: "미완료", handler: { _ in
            print(#fileID, #function, #line, "- 미완료")
        })
        
        let segmentControl = UISegmentedControl(frame: .zero, actions: [filterAllAction, filterIsDoneAction, filterIsNotDoneAction])
        
        segmentControl.selectedSegmentIndex = 0
        segmentControl.backgroundColor = .white
        
        return segmentControl
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
}
