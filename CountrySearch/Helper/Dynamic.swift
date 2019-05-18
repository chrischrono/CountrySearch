//
//  Dynamic.swift
//
//
// source: https://www.toptal.com/ios/swift-tutorial-introduction-to-mvvm
import Foundation

class Dynamic<T> {
    typealias Listener = (T) -> ()
    var listener: Listener?
    var mainAsyncListener: Listener?
    
    func bind(_ listener: Listener?) {
        self.listener = listener
    }
    
    func bindAndFire(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
    
    var value: T {
        didSet {
            listener?(value)
            guard let mainAsyncListener = mainAsyncListener else {
                return
            }
            DispatchQueue.main.async {
                mainAsyncListener(self.value)
            }
        }
    }
    
    init(_ v: T) {
        value = v
    }
}
