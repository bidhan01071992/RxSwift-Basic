//
//  ViewController.swift
//  RxSwiftBasic
//
//  Created by Roy, Bidhan (623) on 17/04/20.
//  Copyright © 2020 Roy, Bidhan (623). All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //RXSwift is all about sequence here an Observable emits number of events what we call sequence and when we subscribe to that Observable we can recieve those events.
        
        //Observable.of sequence create observable for each elment in the list
        
        //Dispose bag is to dispose allocated memory when work is done.
        
        let nameSequence = Observable.of("Bidhan","Shalini","Titas","Soumya")

        nameSequence.subscribe { name in
            print(name)
        }.disposed(by: disposeBag)
print("\n-------------------------------------------\n")
        Observable.of(1,2,3,4,5,6)
            .subscribe(onNext: { item in
              print(item)
            }).disposed(by: disposeBag)
print("\n-------------------------------------------\n")
        
        //Observable from creates sequence of the whole list together. we can use from only in case of array
        
        Observable.from(["A","B","C","D","E"])
            .subscribe(onNext: { character in
                print(character.lowercased())
            }).disposed(by: disposeBag)
print("\n-------------------------------------------\n")
        
        //just is used for a single element
        Observable.just("Bidhan")
            .subscribe(onNext: { item in
                print(item.uppercased())
            }).disposed(by: disposeBag)

print("\n-------------------------------------------\n")
        
        //Subject can emit events and also can subscribe to it. So it works as Observable and observer
        
        let citySubject = PublishSubject<String>()
        citySubject.onNext("Kolkata")
        citySubject.subscribe(onNext : { cityName in

            print(cityName)

            //citySubject.onNext("Delhi")
            }).disposed(by: disposeBag)

        citySubject.onNext("Bangalore")
        citySubject.onNext("Mumbai")

        print("\n-------------------------------------------\n")
// We can also create Observable by adding events and subscribing to possible scenarios
        //OnError will invoke when the observer will call onError
        //OnCompleted will invoke when the observer will call onCompleted
        
        Observable<String>.create { observer in
            observer.onNext("January")
            observer.onNext("February")
            observer.onNext("March")
            observer.onNext("April")
            observer.onCompleted()
            return Disposables.create()
        }.subscribe(onNext: { month in
            print(month)
        }, onError: { error in
            print(error.localizedDescription)
        }, onCompleted: {
            print("Completed")
        }, onDisposed: {
            print("Disposed")
            }).disposed(by: disposeBag)
        
       print("\n-------------------------------------------\n")
        let subject = PublishSubject<String>()
        subject.onNext("First")
        
        subject.subscribe(onNext: { item in
                print(item)
            }).disposed(by: disposeBag)
        subject.onNext("Second")
        subject.onNext("Third")
        subject.onCompleted()
        subject.onNext("Fourth")
        
        print("\n-------------------------------------------\n")
      //Variable is deprecated
        
        //Publish subject can subscribe to those events only which are fired after its subscription. For varibale anything works
        let variable = Variable([String]())
        variable.value.append("firstValue")
        variable.asObservable().subscribe(onNext: { item in
            print(item)
        }, onCompleted: {
            
            }).disposed(by: disposeBag)
        
        variable.value.append("secondValue")
        variable.value.append("thirdValue")
        variable.value.append("fourthValue")
        
        print("\n-------------------------------------------\n")
        
        //Behavious relay comes in place of Variable.Here value is read only , so different approach to add new events
        let behaviourRelay = BehaviorRelay(value: [String]())
        var value = behaviourRelay.value // value is read only for behaviourRelay
        
        value.append("First Behaviour")
        value.append("Second Behaviour")
        value.append("Third Behaviour")
        value.append("Fourth Behaviour")
        
        behaviourRelay.accept(value)
        
        behaviourRelay.asObservable().subscribe(onNext: { item in
           print(item)
        }, onCompleted: {
            
            }).disposed(by: disposeBag)
        
        print("\n-------------------------------------------\n")
        
    }


}

