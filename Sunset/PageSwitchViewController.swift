//
//  PageViewSwitchController.swift
//
//
//  Created by Kevin Lima on 06/08/2018.
//

import UIKit

class PageViewSwitchController: UIPageViewController, UIPageViewControllerDataSource {
    lazy var viewControllerList:[UIViewController] = {
        let storyBoard =  UIStoryboard(name: "Main", bundle: nil)
        let firstVC: UIViewController = storyBoard.instantiateViewController(withIdentifier: "FirstViewController")
        let secondVC: UIViewController = storyBoard.instantiateViewController(withIdentifier: "SecondViewController")
        return [firstVC, secondVC]
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        
        if let firstViewController = viewControllerList.first{
            self.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return 2
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = viewControllerList.index(of: viewController) else {return nil}
        
        let previousIndex = vcIndex - 1
        guard previousIndex >= 0 else{return nil}
        guard viewControllerList.count > previousIndex else{return nil}
        
        return viewControllerList[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = viewControllerList.index(of: viewController) else {return nil}
        
        let nextIndex = vcIndex + 1
        guard viewControllerList.count != nextIndex else{return nil}
        guard viewControllerList.count > nextIndex else{return nil}
        
        return viewControllerList[nextIndex]
    }
}
