//
//  WDElement+Queries.m
//  WDUSBClient
//
//  Created by admini on 16/10/19.
//  Copyright © 2016年 netdragon. All rights reserved.
//

#import "WDElement+Queries.h"
#import "WDClient.h"
#import "WDUtils.h"
#import "YYModel.h"
#import "WDRect.h"
@implementation WDElement (Queries)
- (CGRect)rect {
    __block CGRect rect = (CGRect){0, 0, 0, 0};
    dispatch_semaphore_t signal = dispatch_semaphore_create(0);
    NSString *endPoint = [NSString stringWithFormat:@"/session/%@/element/%@/rect", self.client.sessionID, self.elementID];
    [self.client dispatchMethod:@"GET" endpoint:endPoint parameters:@{} completion:^(NSDictionary *response, NSError *requestError) {
        //NSLog(@"Rect = %@", response);
        NSDictionary *httpResJson  = @{};
        if ([WDUtils isResponseSuccess:response]) {
            
            httpResJson = [response objectForKey:WDHttpResponseKey];
    
        }
        WDHttpResponse *httpResponse = [WDHttpResponse yy_modelWithJSON:  httpResJson];
        WDRect *wdRect =httpResponse.rect;
        rect = (CGRect){wdRect.x.integerValue, wdRect.y.integerValue,
            wdRect.width.integerValue, wdRect.height.integerValue};
        
        dispatch_semaphore_signal(signal);
    }];
    dispatch_semaphore_wait(signal, DISPATCH_TIME_FOREVER);
    return rect;
}

- (CGSize)size {
    CGRect rect = self.rect;
    return rect.size;
}

- (CGPoint)location {
    CGPoint point = self.rect.origin;
    return point;
}

- (NSString *)text {
    __block NSString *text =@"";
    dispatch_semaphore_t signal = dispatch_semaphore_create(0);
    NSString *endPoint = [NSString stringWithFormat:@"/session/%@/element/%@/text", self.client.sessionID, self.elementID];
    [self.client dispatchMethod:@"GET" endpoint:endPoint parameters:@{} completion:^(NSDictionary *response, NSError *requestError) {
        NSDictionary *httpResJson  = @{};
        if (![WDUtils isResponseSuccess:response]) {
            NSLog(@"获取节点文本失败");
        }
        httpResJson = [response objectForKey:WDHttpResponseKey];
        WDHttpResponse *httpResponse = [WDHttpResponse yy_modelWithJSON:  httpResJson];
        text =httpResponse.text;
        dispatch_semaphore_signal(signal);

    }];
    dispatch_semaphore_wait(signal, DISPATCH_TIME_FOREVER);
    return text;
}


- (BOOL)displayed {
    __block BOOL display = false;
    dispatch_semaphore_t signal = dispatch_semaphore_create(0);
    NSString *endPoint = [NSString stringWithFormat:@"/session/%@/element/%@/displayed", self.client.sessionID, self.elementID];
    [self.client dispatchMethod:@"GET" endpoint:endPoint parameters:@{} completion:^(NSDictionary *response, NSError *requestError) {
        NSDictionary *httpResJson  = @{};
        if (![WDUtils isResponseSuccess:response]) {
            NSLog(@"获取节点显示属性失败");
        }
        httpResJson = [response objectForKey:WDHttpResponseKey];
        WDHttpResponse *httpResponse = [WDHttpResponse yy_modelWithJSON:  httpResJson];
        display =httpResponse.displayed;
        dispatch_semaphore_signal(signal);
    }];
    dispatch_semaphore_wait(signal, DISPATCH_TIME_FOREVER);
    return display;
}

- (BOOL)accessible {
    //NSLog(@"%s", __func__);
    __block BOOL accessible = false;
    dispatch_semaphore_t signal = dispatch_semaphore_create(0);
    NSString *endPoint = [NSString stringWithFormat:@"/session/%@/element/%@/accessible", self.client.sessionID, self.elementID];
    [self.client dispatchMethod:@"GET" endpoint:endPoint parameters:@{} completion:^(NSDictionary *response, NSError *requestError) {
        NSDictionary *httpResJson  = @{};
        if (![WDUtils isResponseSuccess:response]) {
            NSLog(@"获取节点显示属性失败");
        }
        httpResJson = [response objectForKey:WDHttpResponseKey];
        WDHttpResponse *httpResponse = [WDHttpResponse yy_modelWithJSON:  httpResJson];
        accessible =httpResponse.accessible;
        dispatch_semaphore_signal(signal);
    }];
    dispatch_semaphore_wait(signal, DISPATCH_TIME_FOREVER);
    return accessible;
}

- (BOOL)enabled {
    //NSLog(@"%s", __func__);
    __block BOOL enabled = false;
    dispatch_semaphore_t signal = dispatch_semaphore_create(0);
    NSString *endPoint = [NSString stringWithFormat:@"/session/%@/element/%@/enabled", self.client.sessionID, self.elementID];
    [self.client dispatchMethod:@"GET" endpoint:endPoint parameters:@{} completion:^(NSDictionary *response, NSError *requestError) {
        NSDictionary *httpResJson  = @{};
        if (![WDUtils isResponseSuccess:response]) {
            NSLog(@"获取节点显示属性失败");
        }
        httpResJson = [response objectForKey:WDHttpResponseKey];
        WDHttpResponse *httpResponse = [WDHttpResponse yy_modelWithJSON:  httpResJson];
        enabled =httpResponse.enabled;
        dispatch_semaphore_signal(signal);
    }];
    dispatch_semaphore_wait(signal, DISPATCH_TIME_FOREVER);
    return enabled;
}

- (NSString *)name {
    __block NSString *name = @"";
    dispatch_semaphore_t signal = dispatch_semaphore_create(0);
    NSString *endPoint = [NSString stringWithFormat:@"/session/%@/element/%@/attribute/name", self.client.sessionID, self.elementID];
    [self.client dispatchMethod:@"GET" endpoint:endPoint parameters:@{} completion:^(NSDictionary *response, NSError *requestError) {
        NSDictionary *httpResJson  = @{};
        if (![WDUtils isResponseSuccess:response]) {
            NSLog(@"获取节点显示属性失败");
        }
        httpResJson = [response objectForKey:WDHttpResponseKey];
        WDHttpResponse *httpResponse = [WDHttpResponse yy_modelWithJSON:  httpResJson];
        name =httpResponse.name;
        dispatch_semaphore_signal(signal);
    }];
    dispatch_semaphore_wait(signal, DISPATCH_TIME_FOREVER);
    return name;
}

// curl -X POST $JSON_HEADER -d "" $DEVICE_URL/session/$SESSION_ID/element/5/click
- (BOOL)click {
    __block BOOL isClick = false;
    NSString *endPoint = [NSString stringWithFormat:@"/session/%@/element/%@/click", self.client.sessionID, self.elementID];
    dispatch_semaphore_t signal = dispatch_semaphore_create(0);
    [self.client dispatchMethod:@"POST" endpoint:endPoint parameters:@{} completion:^(NSDictionary *response, NSError *requestError) {
        if ([WDUtils isResponseSuccess: response]) isClick = true;
        dispatch_semaphore_signal(signal);
    }];
    dispatch_semaphore_wait(signal, DISPATCH_TIME_FOREVER);
    return isClick;
}

/*
 curl -X POST $JSON_HEADER \
 -d "{\"value\":[\"h\",\"t\",\"t\",\"p\",\":\",\"/\",\"/\",\"g\",\"i\",\"t\",\"h\",\"u\",\"b\",\".\",\"c\",\"o\",\"m\",\"\\n\"]}" \
 $DEVICE_URL/session/$SESSION_ID/element/5/value
 */
- (BOOL)typeText:(NSString *)text {
    NSArray *chars = [text componentsSeparatedByString: @""];
    __block BOOL isType = false;
    NSString *endPoint = [NSString stringWithFormat:@"/session/%@/element/%@/value", self.client.sessionID, self.elementID];
    dispatch_semaphore_t signal = dispatch_semaphore_create(0);
    [self.client dispatchMethod:@"POST" endpoint:endPoint parameters:@{
                                                                       @"value" : chars
                                                                       } completion:^(NSDictionary *response, NSError *requestError) {
        if ([WDUtils isResponseSuccess: response]) isType = true;
        dispatch_semaphore_signal(signal);
    }];
    dispatch_semaphore_wait(signal, DISPATCH_TIME_FOREVER);
    return isType;
}

//curl -X POST $JSON_HEADER -d "" $DEVICE_URL/session/$SESSION_ID/element/5/clear
- (BOOL)clearText {
    __block BOOL isClear = false;
    NSString *endPoint = [NSString stringWithFormat:@"/session/%@/element/%@/clear", self.client.sessionID, self.elementID];
    dispatch_semaphore_t signal = dispatch_semaphore_create(0);
    [self.client dispatchMethod:@"POST" endpoint:endPoint parameters:@{} completion:^(NSDictionary *response, NSError *requestError) {
                                                                           if ([WDUtils isResponseSuccess: response]) isClear = true;
                                                                           dispatch_semaphore_signal(signal);
                                                                       }];
    dispatch_semaphore_wait(signal, DISPATCH_TIME_FOREVER);
    return isClear;
}

- (BOOL)scrollToDirection:(NSString *)direction {
    __block BOOL isScroll = false;
    NSString *endPoint = [NSString stringWithFormat:@"/session/%@/uiaElement/%@/scroll", self.client.sessionID, self.elementID];
    dispatch_semaphore_t signal = dispatch_semaphore_create(0);
    [self.client dispatchMethod:@"POST" endpoint:endPoint parameters:@{@"direction" : direction} completion:^(NSDictionary *response, NSError *requestError) {
        if ([WDUtils isResponseSuccess: response]) isScroll = true;
        dispatch_semaphore_signal(signal);
    }];
    dispatch_semaphore_wait(signal, DISPATCH_TIME_FOREVER);
    return isScroll;
}

//  [[FBRoute POST:@"/uiaTarget/:uuid/dragfromtoforduration"] respondWithTarget:self action:@selector(handleDrag:)],
- (BOOL)dragFrom:(CGPoint)from to:(CGPoint)to forDuration:(CGFloat)duration {
    __block BOOL isDrag = false;
    NSString *endPoint = [NSString stringWithFormat:@"/session/%@/uiaTarget/%@/dragfromtoforduration", self.client.sessionID, self.elementID];
    dispatch_semaphore_t signal = dispatch_semaphore_create(0);
    [self.client dispatchMethod:@"POST" endpoint:endPoint parameters:@{
                                                                       @"fromX" : @(from.x),
                                                                       @"fromY" : @(from.y),
                                                                       @"toX"   : @(to.x),
                                                                       @"toY"   : @(to.y)
                                                                       } completion:^(NSDictionary *response, NSError *requestError) {
        if ([WDUtils isResponseSuccess: response]) isDrag = true;
        dispatch_semaphore_signal(signal);
    }];
    dispatch_semaphore_wait(signal, DISPATCH_TIME_FOREVER);
    return isDrag;
}

- (BOOL)swipeLeft {
    __block BOOL isSendMessageSuccess = false;
    NSString *endPoint = [NSString stringWithFormat:@"/session/%@/element/%@/swipeLeft", self.client.sessionID, self.elementID];
    dispatch_semaphore_t signal = dispatch_semaphore_create(0);
    [self.client dispatchMethod:@"GET" endpoint:endPoint parameters:@{} completion:^(NSDictionary *response, NSError *requestError) {
        if ([WDUtils isResponseSuccess: response]) isSendMessageSuccess = true;
        dispatch_semaphore_signal(signal);
    }];
    dispatch_semaphore_wait(signal, DISPATCH_TIME_FOREVER);
    return isSendMessageSuccess;
}

- (BOOL)swipeRight {
    __block BOOL isSendMessageSuccess = false;
    NSString *endPoint = [NSString stringWithFormat:@"/session/%@/element/%@/swipeRight", self.client.sessionID, self.elementID];
    dispatch_semaphore_t signal = dispatch_semaphore_create(0);
    [self.client dispatchMethod:@"GET" endpoint:endPoint parameters:@{} completion:^(NSDictionary *response, NSError *requestError) {
        if ([WDUtils isResponseSuccess: response]) isSendMessageSuccess = true;
        dispatch_semaphore_signal(signal);
    }];
    dispatch_semaphore_wait(signal, DISPATCH_TIME_FOREVER);
    return isSendMessageSuccess;
}






@end
