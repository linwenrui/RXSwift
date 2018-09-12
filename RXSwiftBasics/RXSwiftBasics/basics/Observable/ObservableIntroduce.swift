//
//  ObservableIntroduce.swift
//  RXSwiftBasics
//
//  Created by XH-LWR on 2018/9/12.
//  Copyright © 2018年 lwr. All rights reserved.
//

import UIKit
import RxSwift

class ObservableIntroduce: UIViewController {

    /**
     1. Observable<T>
     这个类就是Rx框架的基础,可观察序列
     作用: 异步的产生一些列的Event(事件),即一个Observable<T>对象会随着时间推移不定期得产生event(element: T)这样一个东西
     Event还可以携带数据, 它的泛型<T>就是用来指定这个Event携带的数据的类型
     用Observer(订阅者)来订阅它,这样订阅者才能收到Observable<T>不时发出的Event
     
     2. Event
     Event是一个枚举,也就是Observable可以发出3种不同类型的Event事件
     next: 可以携带数据<T>的事件
     error: 表示一个错误, 可以携带具体的错误内容, 一旦Observable发出了error event事件,则这个Observable就等于终止了
     completed: 正常的结束了,一旦发出则终止
     
     3. Observable与Sequence比较
     (1)把Observable的实例想象成一个Swift中的Sequence:
        - 一个Observable(ObservableType)相当于一个序列Sequence(SequenceType)
        - ObservableType:subscribe(_:)方法相当于SequenceType.generate()
     (2)区别
        - SequenceType是同步的循环,而Observable是异步的
        - Observable对象会在有任何Event时候,自动将Event作为一个参数通过ObservableType.subscribe(_:)发出,并不需要使用next方法
     
     4. 创建Observable序列
     */
    
    enum Myerror: Error {
        case A
        case B
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // a. just()方法
        // (1)该方法通过传入一个默认值来初始化
        // (2)显式指定类型,则必须携带该类型数据Observable<Int>
        let _ = Observable<Int>.just(5)
        
        // b. of()
        // (1)该方法接受可变数量的参数(必须要是同类型的)
        // (2)显式的声明Observable的泛型,Swift会自动推断
        let _ = Observable.of("A", "B", "C")
        
        // c. from()
        // (1)需要一个数据参数
        // (2)元素会被当做这个Observable所发出event携带的数据内容,与of()一样
        let _ = Observable.from(["A", "B", "C"])
        
        // d. empty()
        // 创建一个空内容的Observable序列
        let _ = Observable<Int>.empty()
        
        // e. never()
        // 创建一个永远不会发出Event(也不会终止)的Observable序列
        let _ = Observable<Int>.never()
        
        // f. error()
        // 直接发送错误事件
        let _ = Observable<Int>.error(Myerror.A)
        
        // g. range()
        // 创建一个这个范围内所有值作为初始值的Observable序列
        let _ = Observable.range(start: 1, count: 5)
        let _ = Observable.of(1, 2, 3, 4, 5)
        
        // h. repeatElement()
        // 无限发出给定元素的Event的Observable序列(永不终止)
        let _ = Observable.repeatElement(1)
        
        // i. generate()
        // 只有当提供的所有的判断条件都为true的时候,才会给出动作的Observable序列
        let _ = Observable.generate(
            initialState: 0,
            condition: { $0 <= 10 },
            iterate: { $0 + 2 }
        )
        
        let _ = Observable.of(0, 2, 4, 6, 8, 10)
        
        // j. create()
        // 接受一个block形式的参数,任务是对每一个过来的订阅进行处理
        
        // 这个block有一个回调参数observer就是订阅这个Observable对象的订阅者
        // 当一个订阅者订阅这个Observable对象的时候, 就会将订阅者作为参数传入这个block来执行一些内容
        let observable = Observable<String>.create { (observer) -> Disposable in
            // 对订阅者发出了.next事件,且携带了一个数据
            observer.onNext("hello world")
            // 对订阅者发出了.compeleted事件
            observer.onCompleted()
            // 因为一个订阅行为会有一个Disposable类型的返回值,所以在结尾一定要return一个Disposable
            return Disposables.create()
        }
        
        let _ = observable.subscribe {
            print($0)
        }
        
        // k. deferred()
        // 创建一个Observable工厂,通过传入一个block来执行延迟Observable序列创建的行为,而这个block里就是真正的实例化序列对象的地方
        
        // 用于标记是奇数还是偶数
        var isOdd = true
        // 使用deferred()方法延迟Observable序列的初始化,通过传入的block来实现Observable序列的初始化并且返回
        let factory: Observable<Int> = Observable.deferred { () -> Observable<Int> in
            // 让每次执行这个block时候都会让奇,偶数进行交替
            isOdd = !isOdd
            // 根据isOdd参数,决定创建并放回的是奇数Observable,还是偶数Observable
            guard isOdd else {
                return Observable.of(2, 4, 6, 8)
            }
            return Observable.of(1, 3, 5, 7)
        }
        
        let _ = factory.subscribe {
            print("\(isOdd)", $0)
        }
        
        let _ = factory.subscribe { (event) in
            switch event {
            case .next(_):
                print("\(isOdd)", event.element!)
                break
            case .error(_):
                break
            case .completed:
                break
            }
        }
        
        // l. interval()
        // Observable序列每隔一段设定的时间,会发出一个索引数的元素,而且会一直发送下去
//        let _ = Observable<Int>.interval(1, scheduler: MainScheduler.instance).subscribe {
//            print($0)
//        }
        
        // m. timer()
        // 创建Observable序列在经过设定的一段时间后,产生唯一的一个元素
        
        // 2秒后发出一个的一个元素0
        let _ = Observable<Int>.timer(2, scheduler: MainScheduler.instance).subscribe { // MainScheduler.instance 主线程
            print($0)
        }
        
        // 另一种是创建Observable序列在经过设定的一段时间后,每隔一段时间产生一个元素
        let _ = Observable<Int>.timer(4, period: 1, scheduler: MainScheduler.instance).subscribe {
            print($0)
        }
    }
}
