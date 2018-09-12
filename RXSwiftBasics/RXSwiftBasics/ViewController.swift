//
//  ViewController.swift
//  RXSwiftBasics
//
//  Created by XH-LWR on 2018/9/11.
//  Copyright © 2018年 lwr. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

/// RxSwift: 它只是基于 Swift 语言的 Rx 标准实现接口库,所以 RxSwift 里不包含任何 Cocoa或者 UI 方面的类
/// RxCocoa: 是基于 RxSwift针对于 iOS开发的一个库,它通过 Extention的方法给原生的比如 UI 控件添加了 Rx的特性,使得我们更容易订阅和响应这些控件的事件

struct UnitListModel {
    let data = Observable.just([
        Unit(name: "Observable介绍,创建可观察序列", vcStr: "ObservableIntroduce"),
        Unit(name: "Observable订阅,事件监听,订阅销毁", vcStr: "ObservableSubscibe"),
        Unit(name: "观察者1:AnyObsercer,Binder", vcStr: ""),
        Unit(name: "观察者2:AnyObserver,Binder", vcStr: ""),
        Unit(name: "Subjects,Varibles", vcStr: ""),
        Unit(name: "变换操作符:buffer,map,flatMap,scan", vcStr: ""),
        Unit(name: "过滤操作符:filter,take,skip等", vcStr: ""),
        Unit(name: "条件和布尔操作符:amb,takeWhile,skipWhile等", vcStr: ""),
        Unit(name: "结合操作符:startWith,merge,zip等", vcStr: ""),
        Unit(name: "算法&聚合操作符:toArray,reduce,concat", vcStr: ""),
        Unit(name: "连接操作符:connect,publsh,replay,multicast", vcStr: ""),
        Unit(name: "其他操作符:delay,materialize,timeout", vcStr: ""),
        Unit(name: "错误处理", vcStr: ""),
        Unit(name: "调试操作", vcStr: ""),
        Unit(name: "特征序列1:Single,Completable,Maybe", vcStr: ""),
        Unit(name: "特征序列2:Driver", vcStr: ""),
        Unit(name: "特征序列3：ControlProperty、 ControlEvent", vcStr: ""),
        Unit(name: "调度器、subscribeOn、observeOn", vcStr: ""),
        Unit(name: "UI控件扩展1：UILabel", vcStr: ""),
        Unit(name: "UI控件扩展2：UITextField、UITextView", vcStr: ""),
        Unit(name: "UI控件扩展3：UIButton、UIBarButtonItem", vcStr: ""),
        Unit(name: "UI控件扩展4：UISwitch、UISegmentedControl", vcStr: ""),
        Unit(name: "UI控件扩展5：UIActivityIndicatorView、UIApplication", vcStr: ""),
        Unit(name: "UI控件扩展6：UISlider、UIStepper", vcStr: ""),
        Unit(name: "双向绑定：<->", vcStr: ""),
        Unit(name: "UI控件扩展7：UIGestureRecognizer", vcStr: ""),
        Unit(name: "UI控件扩展8：UIDatePicker", vcStr: ""),
        Unit(name: "UITableView的使用1：基本用法", vcStr: ""),
        Unit(name: "UITableView的使用2：RxDataSources", vcStr: ""),
        Unit(name: "UITableView的使用3：刷新表格数据", vcStr: ""),
        Unit(name: "UITableView的使用4：表格数据的搜索过滤", vcStr: ""),
        Unit(name: "UITableView的使用5：可编辑表格", vcStr: ""),
        Unit(name: "UITableView的使用6：不同类型的单元格混用", vcStr: ""),
        Unit(name: "UITableView的使用7：样式修改", vcStr: ""),
        Unit(name: "UICollectionView的使用1：基本用法", vcStr: ""),
        Unit(name: "UICollectionView的使用2：RxDataSources", vcStr: ""),
        Unit(name: "UICollectionView的使用3：刷新集合数据", vcStr: ""),
        Unit(name: "UICollectionView的使用4：样式修改", vcStr: ""),
        Unit(name: "UIPickerView的使用", vcStr: ""),
        Unit(name: "[unowned self] 与 [weak self]", vcStr: ""),
        Unit(name: "URLSession的使用1：请求数据", vcStr: ""),
        Unit(name: "URLSession的使用2：结果处理、模型转换", vcStr: ""),
        Unit(name: "结合RxAlamofire使用1：数据请求", vcStr: ""),
        Unit(name: "结合RxAlamofire使用2：结果处理、模型转换", vcStr: ""),
        Unit(name: "结合RxAlamofire使用3：文件上传", vcStr: ""),
        Unit(name: "结合RxAlamofire使用4：文件下载", vcStr: ""),
        Unit(name: "结合Moya使用1：数据请求", vcStr: ""),
        Unit(name: "结合Moya使用2：结果处理、模型转换", vcStr: ""),
        Unit(name: "MVVM架构演示1：基本介绍、与MVC比较", vcStr: ""),
        Unit(name: "MVVM架构演示2：使用Observable样例", vcStr: ""),
        Unit(name: "MVVM架构演示3：使用Driver样例", vcStr: ""),
        Unit(name: "一个用户注册样例1：基本功能实现", vcStr: ""),
        Unit(name: "一个用户注册样例2：显示网络请求活动指示器", vcStr: ""),
        Unit(name: "结合MJRefresh使用1：下拉刷新", vcStr: ""),
        Unit(name: "结合MJRefresh使用2：上拉加载、以及上下拉组合", vcStr: ""),
        Unit(name: "DelegateProxy样例1：获取地理定位信息", vcStr: ""),
        Unit(name: "DelegateProxy样例2：图片选择功能", vcStr: ""),
        Unit(name: "DelegateProxy样例3：应用生命周期的状态变化", vcStr: ""),
        Unit(name: "sendMessage和methodInvoked的区别", vcStr: ""),
        Unit(name: "订阅UITableViewCell里的按钮点击事件", vcStr: ""),
        Unit(name: "通知NotificationCenter的使用", vcStr: ""),
        Unit(name: "键值观察KVO的使用", vcStr: "")
    ])
}

class ViewController: UIViewController {

    /// DisposeBag：作用是 Rx 在视图控制器或者其持有者将要销毁的时候，自动释法掉绑定在它上面的资源。它是通过类似“订阅处置机制”方式实现（类似于 NotificationCenter 的 removeObserver）
    /// rx.items(cellIdentifier:）:这是 Rx 基于 cellForRowAt 数据源方法的一个封装。传统方式中我们还要有个 numberOfRowsInSection 方法，使用 Rx 后就不再需要了（Rx 已经帮我们完成了相关工作）
    /// rx.modelSelected： 这是 Rx 基于 UITableView委托回调方法 didSelectRowAt 的一个封装
    
    @IBOutlet weak var tableView: UITableView!
    /// 数据源
    let listModel = UnitListModel()
    /// 负责对象销毁
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// 将数据源数据绑定到tableView上
        listModel.data.bind(to: tableView.rx.items(cellIdentifier: "cell")) {_, model, cell in
            cell.textLabel?.text = model.name
            cell.detailTextLabel?.text = model.vcStr
        }.disposed(by: disposeBag)
        
        /// tableView点击响应
        tableView.rx.modelSelected(Unit.self).subscribe(onNext: {[weak self] unit in
            print(unit.description)
            let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String ?? "RXSwiftBasics"
            guard let vcClass = NSClassFromString(appName + "." + unit.vcStr) as? UIViewController.Type else {
                return
            }
            let subVC = vcClass.init()
            subVC.title = unit.name
            self?.navigationController?.pushViewController(subVC, animated: true)
        }).disposed(by: disposeBag)
    }
}

struct Unit {
    let name: String
    let vcStr: String
    init(name: String, vcStr: String) {
        self.name = name
        self.vcStr = vcStr
    }
}

extension Unit: CustomStringConvertible {
    var description: String {
        return "name: \(name) vcStr: \(vcStr)"
    }
}
