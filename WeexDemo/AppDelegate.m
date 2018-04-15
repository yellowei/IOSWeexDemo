//
//  AppDelegate.m
//  WeexDemo
//
//  Created by Swift on 2018/4/14.
//  Copyright © 2018年 Swift. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <WeexSDK.h>

//Model
#import "WXConfigCenterProtocol.h"
#import "WXNavigationHandlerImpl.h"
#import "WXEventModule.h"
#import "WXImgLoaderDefaultImpl.h"

#define BUNDLE_URL [NSString stringWithFormat:@"file://%@/bundlejs/landing.weex.js",[NSBundle mainBundle].bundlePath]

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self initWindow];
    [self initWeex];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

# pragma mark - Private Methods
- (void)initWindow
{
    self.window= [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.window makeKeyAndVisible];
    
    ViewController * tempVC = [[ViewController alloc] init];
//    NSString *str = [NSString stringWithFormat:@"http://192.168.31.25:8081/dist/index.js"];
    NSString *str = [NSString stringWithFormat:BUNDLE_URL];
    tempVC.url = [NSURL URLWithString:str];
    self.window.rootViewController = [[WXRootViewController alloc] initWithRootViewController:tempVC];
    
}

- (void)initWeex
{
    [WXAppConfiguration setAppGroup:@"AliApp"];
    [WXAppConfiguration setAppName:@"WeexDemo"];
    [WXAppConfiguration setExternalUserAgent:@"ExternalUA"];
    
    [WXSDKEngine initSDKEnvironment];
    
    [WXSDKEngine registerHandler:[WXImgLoaderDefaultImpl new] withProtocol:@protocol(WXImgLoaderProtocol)];
//    [WXSDKEngine registerHandler:[WXEventModule new] withProtocol:@protocol(WXEventModuleProtocol)];
//    [WXSDKEngine registerHandler:[WXConfigCenterDefaultImpl new] withProtocol:@protocol(WXConfigCenterProtocol)];
    [WXSDKEngine registerHandler:[WXNavigationHandlerImpl new] withProtocol:@protocol(WXNavigationProtocol)];
    
//    [WXSDKEngine registerComponent:@"select" withClass:NSClassFromString(@"WXSelectComponent")];
    [WXSDKEngine registerModule:@"event" withClass:[WXEventModule class]];
//    [WXSDKEngine registerModule:@"syncTest" withClass:[WXSyncTestModule class]];
//    [WXSDKEngine registerModule:@"titleBar" withClass:NSClassFromString(@"WXTitleBarModule")];
//    [WXSDKEngine registerExtendCallNative:@"test" withClass:NSClassFromString(@"WXExtendCallNativeTest")];
//    [WXSDKEngine registerModule:@"ext" withClass:[WXExtModule class]];
}


@end
