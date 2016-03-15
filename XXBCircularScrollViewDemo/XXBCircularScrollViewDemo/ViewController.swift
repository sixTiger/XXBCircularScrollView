//
//  ViewController.swift
//  XXBCircularScrollViewDemo
//
//  Created by xiaobing on 16/3/15.
//  Copyright © 2016年 xiaobing. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIScrollViewDelegate {
    
    var _scrollView: UIScrollView?
    var _currentIndex = 0
    var _priventIndex = 0
    var _nextIndex = 0
    var _iteamArray:[UIView] = [UIView]()
    
    let viewWidth = UIScreen.mainScreen().bounds.size.width
    override func viewDidLoad() {
        super.viewDidLoad()
        _initItemArray()
        _initScrollView()
        _setupFrameWithCurrentIndex()
    }
    //MARK:- view
    func _initScrollView(){
        
        _scrollView = UIScrollView(frame:CGRectMake(0, 64, viewWidth, 300))
        view.addSubview(_scrollView!)
        _scrollView!.delegate = self
        _currentIndex = 0;
        _scrollView!.contentSize = CGSizeMake(viewWidth * 3, 0);
        _scrollView!.pagingEnabled = true;
        _scrollView!.contentOffset = CGPointMake(viewWidth, 0);
        _scrollView?.showsHorizontalScrollIndicator = true
        _scrollView?.showsVerticalScrollIndicator = true
    }
    
    func _initItemArray() {
        if (_iteamArray.count <= 0) {
            for index  in 0...5 {
                let view = UIView(frame: CGRectMake(0, 0, viewWidth, 300))
                view.backgroundColor = UIColor(red: (CGFloat)(arc4random_uniform(255)) / 255.0, green: (CGFloat)(arc4random_uniform(255)) / 255.0, blue: (CGFloat)(arc4random_uniform(255)) / 255.0, alpha: 1.0)
                let label = UILabel(frame: view.bounds)
                view.addSubview(label)
                label.textAlignment = NSTextAlignment.Center
                label.text = "我是第  \(index) 个页面"
                _iteamArray.append(view);
            }
        }
    }
    
    //MARK:- control
    func _setupFrameWithCurrentIndex() {
        let count = _iteamArray.count
        let currentView = _iteamArray[_currentIndex]
        var currentViewFrame = currentView.frame
        currentViewFrame.origin.x = currentViewFrame.size.width
        currentView.frame = currentViewFrame
        _scrollView?.addSubview(currentView)
        
        _priventIndex = (_currentIndex + count - 1)%count
        let priventView = _iteamArray[_priventIndex]
        var priventViewFrame = priventView.frame
        priventViewFrame.origin.x = 0
        priventView.frame = priventViewFrame
        _scrollView?.addSubview(priventView)
        
        _nextIndex = (_currentIndex + count + 1)%count
        let nextView = _iteamArray[_nextIndex]
        var nextViewFrame = nextView.frame
        nextViewFrame.origin.x = 2 * nextViewFrame.size.width;
        nextView.frame = nextViewFrame
        _scrollView?.addSubview(nextView)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let realIndex = Int((_scrollView!.contentOffset.x / _scrollView!.bounds.size.width + 0.5 ))
        var moveX: CGFloat = 0.0
        if (realIndex != 1) {
            if (realIndex == 0 ) {
                if (Int((_scrollView!.contentOffset.x / _scrollView!.bounds.size.width + 0.6 )) == 0){
                    print("<<<<<<<<<<<")
                    moveX = _scrollView!.bounds.size.width ;
                    _currentIndex += (realIndex + _iteamArray.count - 1);
                    _currentIndex %= _iteamArray.count;
                }
            } else {
                
                if (Int((_scrollView!.contentOffset.x / _scrollView!.bounds.size.width + 0.4 )) == 2) {
                    print(">>>>>>>>>>>>>>")
                    moveX = -scrollView.bounds.size.width ;
                    _currentIndex += (realIndex + _iteamArray.count - 1);
                    _currentIndex %= _iteamArray.count;
                }
            }
        }
        _setupFrameWithCurrentIndex()
        _scrollView?.contentOffset = CGPointMake(_scrollView!.contentOffset.x + moveX, 0)
    }
}

