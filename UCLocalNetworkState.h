//
//  UCLocalNetworkStateUtil.h
//  MyTest
//
//  Created by wangyx on 2021/7/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^Completion)(BOOL state);

@interface UCLocalNetworkState : NSObject

+ (instancetype)sharedInstance;

- (void)startRequestLoaclNetworkState:(Completion)completion;

@end

NS_ASSUME_NONNULL_END
