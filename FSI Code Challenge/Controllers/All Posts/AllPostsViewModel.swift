//
//  AllPostsViewModel.swift
//  FSI Code Challenge
//
//  Created by Joel Youngblood on 11/13/19.
//  Copyright © 2019 Joel Youngblood. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

struct AllPostsSectionData {
    var items: [Post]
}

extension AllPostsSectionData: SectionModelType {
    typealias Item = Post
    
    init(original: Self, items: [Self.Item]) {
        self = original
        self.items = items
    }
}

final class AllPostsViewModel {
    
    private let disposeBag = DisposeBag()
    let isLoading = BehaviorRelay<Bool>(value: false)
    let error = PublishSubject<FSIError>()
    let allPosts = PublishSubject<[Post]>()
    
    func fetchAllPosts() {
        isLoading.accept(true)
        Network.request(from: Posts.allPosts, for: [Post].self)
            .subscribeOn(SerialDispatchQueueScheduler(qos: .userInitiated)).subscribe(onNext: { [weak self] posts in
                self?.isLoading.accept(false)
                self?.allPosts.onNext(posts)
            }, onError: { [weak self] error in
                self?.isLoading.accept(false)
                if let fsiError = error as? FSIError {
                    self?.error.onNext(fsiError)
                } else {
                    //since this is the 'user facing' error, we just past unknown. We log it here for debugging though
                    Dlog.print(error)
                    self?.error.onNext(NetworkError.unknownError)
                }
            }).disposed(by: disposeBag)
    }
}
