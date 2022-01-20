//
//  AppDelegate.m
//  NPAPIHostModal
//
//  Created by Napiac on 2022/1/20.
//

#import "AppDelegate.h"
#import "NPAPIHostModal.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    NSDictionary * params = @{@"开发":@"http://developer.com",
                              @"测试":@"http://test.com",
                              @"生产":@"http://realease.com"};
    
    NPAPIHostModal * hostModal = [NPAPIHostModal sharedAPIHost];
    [hostModal setupAPIHostParams:params defaultIndex:2];
    [hostModal setupModalShowWay:ModalShowWay_AddSubview];
    [hostModal showModal];
    
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
