//
//  ViewController.swift
//  LeaksDemo
//
//  Created by 关东升 on 2016-2-18.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var emp: Employee?
        var dept: Department?
        
        emp = Employee(no: 7698, name: "Blake", job :"Salesman", salary : 1600)
        dept = Department(no : 30, name: "Sales", manager : emp!)
        
        emp!.dept = dept
        
        emp = nil
        dept = nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

class Employee {
    var no : Int
    var name : String
    var job : String
    var salary : Double
    var dept : Department?
    
    init(no : Int, name: String, job : String, salary : Double) {
        self.no = no
        self.name = name
        self.job = job
        self.salary = salary
        print("员工\(name) 已经构造成功。")
    }
    deinit {
        print("员工\(name) 已经析构成功。")
    }
    
}

class Department {
    var no : Int = 0
    var name : String = ""
    //unowned var manager : Employee
    var manager : Employee  //制造内存泄漏点
    
    init(no : Int, name: String, manager : Employee) {
        self.no = no
        self.name = name
        self.manager = manager
        print("部门\(name) 已经构造成功。")
    }
    deinit {
        print("部门\(name) 已经析构成功。")
    }
}

