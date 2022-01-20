//
//  NPAPIHostModal.h
//  NPAPIHostModal
//
//  Created by Napiac on 2022/1/20.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ModalShowWay) {
    /// Default 直接设置为KeyWindow (一些以Window做的弹框会有问题)
    ModalShowWay_SetKeyWindow,
    /// 以addSubview方式添加
    ModalShowWay_AddSubview,
};

@interface NPAPIHostModal : NSObject

@property(nonatomic, strong, readonly)UIWindow * modalWindow;

+ (instancetype)sharedAPIHost;

/// 设置数据源
/// 例如：
/// @{
///     @"开发":@"http://debug.com",
///     @"测试":"http://test.com",
///     @"生产":@"http://realease.com"
///  }
/// @param params API数据源
/// @param defaultIndex 默认选择API的下标
- (void)setupAPIHostParams:(NSDictionary *)params
              defaultIndex:(NSUInteger)defaultIndex;


/// 设置显示方式
/// @param showWay ModalShowWay
- (void)setupModalShowWay:(ModalShowWay)showWay;


- (void)showModal;
- (void)hideModal;
- (void)removeModal;

@end

NS_ASSUME_NONNULL_END
