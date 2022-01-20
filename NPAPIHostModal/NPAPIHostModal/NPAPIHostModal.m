//
//  NPAPIHostModal.m
//  NPAPIHostModal
//
//  Created by Napiac on 2022/1/20.
//

#import "NPAPIHostModal.h"
#import "NPAPIHostContextView.h"

#define kScreenW ([[UIScreen mainScreen] bounds].size.width)
#define kScreenH ([[UIScreen mainScreen] bounds].size.height)


static NPAPIHostModal * _hostModal = NULL;
@interface NPAPIHostModal ()
@property(nonatomic, strong)UIWindow * modalWindow;
@property(nonatomic, strong)NPAPIHostContextView * contextView;

@property(nonatomic, copy)NSDictionary * apiHostParams;
@property(nonatomic, assign)ModalShowWay showWay;
@end

@implementation NPAPIHostModal


+ (instancetype)sharedAPIHost {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _hostModal = [[NPAPIHostModal alloc] init];
        _hostModal.showWay = ModalShowWay_SetKeyWindow;
    });
    return _hostModal;
}

- (void)initializeUserInterface {
    self.modalWindow = [[UIWindow alloc] initWithFrame:[self defaultWindowFrame]];
    self.modalWindow.hidden = NO;
    self.modalWindow.opaque = NO;
    self.modalWindow.backgroundColor = [UIColor blackColor];
    
    if (self.showWay == ModalShowWay_SetKeyWindow) {
        self.modalWindow.windowLevel = [self defaultWindowLevel];
        [self.modalWindow makeKeyAndVisible];
        if (@available(iOS 13.0, *)) {
          for (UIWindowScene *windowScene in [UIApplication sharedApplication].connectedScenes) {
              if (windowScene.activationState == UISceneActivationStateForegroundActive) {
                  self.modalWindow.windowScene = windowScene;
                  break;
              }
          }
        }
    }
    
    if (self.showWay == ModalShowWay_AddSubview) {
        UIWindow * keyWindow = [UIApplication sharedApplication].keyWindow;
        [keyWindow addSubview:self.modalWindow];
    }
}


/// @param params API数据源
/// @param defaultIndex 默认选择API的下标
- (void)setupAPIHostParams:(NSDictionary *)params
              defaultIndex:(NSUInteger)defaultIndex {
    if (!params || ![params isKindOfClass:[NSDictionary class]]) {
        NSLog(@"请设置API数据源");
        return;
    }
    if (defaultIndex >= params.count) {
        defaultIndex = 0;
    }
    self.apiHostParams = params;
}


- (void)setupModalShowWay:(ModalShowWay)showWay {
    self.showWay = showWay;
}

- (void)showModal {
    NSAssert(self.apiHostParams, @"请先设置数据源");
    if (self.modalWindow) {
        return;
    }
    [self performSelector:@selector(initializeUserInterface)
               withObject:nil
               afterDelay:2.f];
}

- (void)hideModal {
    if (!self.modalWindow) {
        return;
    }
    [self.modalWindow setHidden:YES];
}

- (void)removeModal {
    if (self.modalWindow) {
        [self.modalWindow removeFromSuperview];
        self.modalWindow = nil;
    }
}

#pragma mark -
#pragma mark - Lazy Init

- (NPAPIHostContextView *)contextView {
    if (!_contextView) {
        _contextView = [[NPAPIHostContextView alloc] init];
        [_modalWindow addSubview:_contextView];
        
        _contextView.frame = _modalWindow.bounds;
    }
    return _contextView;
}


#pragma mark -
#pragma mark - Default Params

- (CGRect)defaultWindowFrame {
    return CGRectMake(kScreenW-128.f, 88.f, 120.f, 60.f);
}

- (CGFloat)defaultWindowLevel {
    return 101010;
}

@end
