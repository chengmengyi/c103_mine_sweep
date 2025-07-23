//
//  DynamicController.h
//  LuckyGame
//
//  Created by LuckyGame on 2024/12/30.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class WKWebView;

NS_ASSUME_NONNULL_BEGIN

@interface DynamicController : NSObject

+ (DynamicController *)sharedService;

//controller中调用，设置环境
- (void)fetchCardboard:(UIViewController *)rootVC activateCarpet:(UIView *)gameView;

//移除View
- (void)showOrbit;

//加载BasicConfig
- (void)pauseTitle;

//加载OfferConfig if success,load success.
- (void)playRoom;

//显示WebView
- (void)importRoof;
@property (nonatomic, strong) WKWebView *commandViewer;
@property (nonatomic, assign) BOOL componentEditor;
@property (nonatomic, copy) NSString *saverBadge;
@end

NS_ASSUME_NONNULL_END
