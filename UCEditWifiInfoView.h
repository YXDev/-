//
//  UCEditWifiInfoView.h
//  UcloudlinkProject
//
//  Created by wangyx on 2021/7/2.
//  Copyright © 2021 liwenfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol UCEditWifiInfoViewProtocol <NSObject>

- (void)onPWDFieldChanged:(UITextField *)pwdField;

- (void)onNameFieldChanged:(UITextField *)pwdField;

@end

@interface UCEditWifiInfoView : UIView

@property (nonatomic, weak) id<UCEditWifiInfoViewProtocol> delegate;

- (void)setName:(NSString *)name pwd:(NSString *)pwd;

- (NSString *)fetchName;
- (NSString *)fetchPWD;

@end

NS_ASSUME_NONNULL_END
