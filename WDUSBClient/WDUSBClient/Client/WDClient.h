//
//  WDClient.h
//  HttpDemo
//
//  Created by admini on 16/10/17.
//  Copyright © 2016年 netdragon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FBHTTPOverUSBClient.h"
#import "WDElement.h"
#import "WDHttpResponse.h"
#import "WDElement+Queries.h"

extern NSString * const WDOrientationPORTRAIT;
extern NSString * const WDOrientationLANDSCAPE;
extern NSString * const WDOrientationUIA_DEVICE_ORIENTATION_LANDSCAPERIGHT;
extern NSString * const WDOrientationUIA_DEVICE_ORIENTATION_PORTRAIT_UPSIDEDOWN;


extern NSString * const WDHttpResponseKey;
extern NSString * const WDSessionIDKey;
extern NSString * const WDStatusKey;
extern NSString * const WDStatusCodeKey;
extern NSString * const WDUUIDKey;

extern NSString * const WDSendHttpMsgWithPOST;
extern NSString * const WDSendHttpMsgWithGET;

@interface WDClient : FBHTTPOverUSBClient

@property (nonatomic, copy) NSString *sessionID;

// 设置要启动的包名
@property (nonatomic, copy) NSString *bundleID;

// 启动App
- (void)startApp;

#warning monkey测试。还未实现，可借助提供的API自行实现。或者等新版本更新会有提供
// 开启Monkey测试。待完成
- (void)startMonkey;

// 截图, 还不知道怎么获取图片
- (void)screenshot;

// 按home键
- (void)pressHome;

// 挂起App duration秒
- (void)deactiveAppWithDuration:(NSInteger)duration;

// 完全匹配Label文字, 返回匹配的数组
- (NSMutableArray *)findElementsByLinkText:(NSString *)linkText;

// 模糊匹配, 返回包含的数组
- (NSMutableArray *)findElementsByParticalLinkText:(NSString *)partialLinkText;

// 通过类名, 返回所包含的对象
- (NSMutableArray *)findElementsByClassName:(NSString *)className;

// 获取手机屏幕大小
- (CGSize)windowSize;

// 通过XPath, 返回对象
- (NSMutableArray *)findElementsByXPath:(NSString *)xpath;

// 返回可见的cells
- (NSMutableArray *)getVisibleCells;

// 时时设置App旋转方向
@property (nonatomic, copy) NSString *orientation;

@end
