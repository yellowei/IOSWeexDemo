//
//  ViewController.h
//  WeexDemo
//
//  Created by Swift on 2018/4/14.
//  Copyright © 2018年 Swift. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SRWebSocket.h>

@interface ViewController : UIViewController

@property (nonatomic, strong) NSString *script;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, assign) BOOL showNavigationBar;
@property (nonatomic, strong) SRWebSocket *hotReloadSocket;
@property (nonatomic, strong) NSString *source;
@end

