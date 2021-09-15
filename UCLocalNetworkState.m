//
//  UCLocalNetworkStateUtil.m
//  MyTest
//
//  Created by wangyx on 2021/7/14.
//

#import "UCLocalNetworkState.h"

@interface UCLocalNetworkState ()<NSNetServiceDelegate>

@property (nonatomic, copy) Completion completion;

@property (nonatomic, strong)  NSNetService *service;

@property (nonatomic, assign) NSTimeInterval lastCall;

@property (nonatomic, assign) BOOL lastState;

@end

@implementation UCLocalNetworkState

static UCLocalNetworkState* _instance;
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[UCLocalNetworkState alloc] init];
    });
    return _instance;
}

- (void)startRequestLoaclNetworkState:(Completion)completion {
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
    if ((interval - self.lastCall) < 3) { // 3秒内多次publish，NSNetService回调不会执行
        completion(self.lastState);
        self.completion = nil;
        return;
    }
    self.completion = completion;
    self.lastCall = interval;
    [self.service publish];
    [self performSelector:@selector(userDeniedLocalNetwork) withObject:nil afterDelay:1];
}

- (void)userDeniedLocalNetwork {
    if (self.completion) {
        self.completion(NO);
        self.completion = nil;
        self.lastState = NO;
    }
}

- (void)netServiceDidPublish:(NSNetService *)sender {
    if (self.completion) {
        self.completion(YES);
        self.completion = nil;
        self.lastState = YES;
    }
}

// 如果用户未允许 本地网络访问权限，则该回调并不会执行
- (void)netService:(NSNetService *)sender didNotPublish:(NSDictionary<NSString *,NSNumber *> *)errorDict {
    
}

#pragma mark - getter
- (NSNetService *)service {
    if (!_service) {
        _service = [[NSNetService alloc] initWithDomain:@"local." type:@"_lnp._tcp." name:@"LocalNetworkPrivacy" port:1100];
        _service.delegate = self;
    }
    return _service;
}

@end
