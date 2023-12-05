//
//  Memo.swift
//  MyTodoApp
//
//  Created by dhui on 12/4/23.
//

import Foundation
import UIKit

class Memo: NSObject {
    var uuid: UUID = UUID()
    var isDone: Bool
    var content: String
    
    init(isDone: Bool = false, content: String = "하하하하") {
        self.isDone = isDone
        self.content = content
    }
    
    static func == (lhs: Memo, rhs: Memo) -> Bool {
        return lhs.uuid == rhs.uuid
    }
    
}
