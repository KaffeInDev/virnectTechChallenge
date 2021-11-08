//
//  MainContetViewModel.swift
//  VirnectTechChallenge
//
//  Created by JunKyung.Park on 2021/11/08.
//

import Foundation
import SwiftUI
import Combine
import CoreModular

class MainViewModel: ObservableObject {
    enum KindOfBooks: String {
        case computer = "컴퓨터"
        case travel = "여행"
        case music = "음악"
        case society = "사회"
    }
    @Published var books: [Model.Books.Item] = []
    var kindOfBooks: KindOfBooks = .computer
    private var cancelables: Set<AnyCancellable> = Set()
    
    func searchBook() {
        Remote<Model.Books>.search(kindOfBooks.rawValue).asObservable()
            .replaceError(with: .mock)
            .map { $0.items }
            .print()
            .assign(to: \.books, on: self)
            .store(in: &cancelables)
    }
}
