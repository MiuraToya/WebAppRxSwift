//
//  ViewController.swift
//  WebAppMVVM
//
//  Created by 三浦　登哉 on 2021/05/16.
//

import UIKit
import WebKit
import RxSwift
import RxCocoa
import RxOptional
import RxWebKit

final class WebViewController: UIViewController {
    
    @IBOutlet private weak var progressView: UIProgressView!
    @IBOutlet private weak var webView: WKWebView!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupWebView()
    }
    
    private func setupWebView() {
        // 宣言的に挙動を記述
        // オブザーバー(イベントを検知するもの)を定義
        let loadingObservable = webView.rx.loading.share()
        
        // プログレスバーの表示・非表示(イベントを流す)
        loadingObservable
            .map{ return !$0 }
            .observeOn(MainScheduler.instance)
            .bind(to: progressView.rx.isHidden)
            .disposed(by: disposeBag)
        
        // iPhoneの時計のアクティビティインジケーター表示制御(イベントを流す)
        loadingObservable
            .bind(to: UIApplication.shared.rx.isNetworkActivityIndicatorVisible)
            .disposed(by: disposeBag)
        
        // NavigationControllerのタイトルを表示(イベントを流す)
        loadingObservable
            .map{ [weak self] _ in return self?.webView.title}
            .observeOn(MainScheduler.instance)
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)
        
        // プログレスバーのゲージ表示制御(イベントを流す)
        webView.rx.estimatedProgress
            .map{ return Float($0) }
            .observeOn(MainScheduler.instance)
            .bind(to: progressView.rx.progress)
            .disposed(by: disposeBag)
        
        guard let url = URL(string: "https://www.google.com/") else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
}

