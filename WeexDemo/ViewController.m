//
//  ViewController.m
//  WeexDemo
//
//  Created by Swift on 2018/4/14.
//  Copyright © 2018年 Swift. All rights reserved.
//

#import "ViewController.h"

#import <WeexSDK.h>

@interface ViewController ()

@property (nonatomic, strong) WXSDKInstance * instance;

@property (nonatomic, strong) WXView * weexView;

@property (nonatomic, strong) UIView * contentView;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [_instance destroyInstance];
    _instance = [[WXSDKInstance alloc] init];
    if([WXPrerenderManager isTaskExist:[self.url absoluteString]]){
        _instance = [WXPrerenderManager instanceFromUrl:self.url.absoluteString];
    }
    _instance.viewController = self;
    
    [self.view addSubview:self.contentView];
    
    CGFloat naviHight = self.navigationController.navigationBar.frame.origin.y + self.navigationController.navigationBar.frame.size.height;
    _instance.frame = CGRectMake(0, naviHight, self.view.bounds.size.width, self.view.bounds.size.height - naviHight);;
    __weak typeof(self) weakSelf = self;
    _instance.onCreate = ^(UIView *view) {
        [weakSelf.weexView removeFromSuperview];
        weakSelf.weexView = view;
        [weakSelf.view addSubview:weakSelf.weexView];
    };
    
    _instance.onFailed = ^(NSError *error) {
        //process failure
    };
    
    _instance.renderFinish = ^ (UIView *view) {
        //process renderFinish
    };
    NSURL *URL = self.url;
    NSString *randomURL = [NSString stringWithFormat:@"%@%@random=%d",URL.absoluteString,URL.query?@"&":@"?",arc4random()];
//    [_instance renderWithURL:[NSURL URLWithString:randomURL] options:@{@"bundleUrl":URL.absoluteString} data:nil];
    [_instance renderWithURL:URL options:@{@"bundleUrl":[URL absoluteString]} data:nil];
    if([_instance.pageName hasPrefix:@"http://dotwe.org"] || [_instance.pageName hasPrefix:@"https://dotwe.org"]) {
        self.navigationItem.title = @"Weex Online Example";
    } else {
        self.navigationItem.title = _instance.pageName;
    }
}

- (UIView *)contentView
{
    if (!_contentView)
    {
        _contentView = [UIView new];
    }
    return _contentView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [_instance destroyInstance];
}


@end
