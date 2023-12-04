//
//  Memo.swift
//  MyTodoApp
//
//  Created by dhui on 12/4/23.
//

import Foundation
import UIKit

struct Memo: Hashable {
    var uuid: UUID = UUID()
    var isDone: Bool
    var content: String
    
    init(isDone: Bool = false, content: String = "하하하하") {
        self.isDone = isDone
        self.content = content
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}
