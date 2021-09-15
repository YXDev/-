//
//  UCEditWifiInfoView.m
//  UcloudlinkProject
//
//  Created by wangyx on 2021/7/2.
//  Copyright © 2021 liwenfeng. All rights reserved.
//

#import "UCEditWifiInfoView.h"
#import "Masonry.h"

@interface UCEditWifiInfoView ()<UITextFieldDelegate>

@property (nonatomic, strong) UILabel *nameLable;
@property (nonatomic, strong) UITextField *nameTextField;

@property (nonatomic, strong) UILabel *pwdLabel;
@property (nonatomic, strong) UITextField *pwdTextField;
@property (nonatomic, strong) UIButton *lockButton;

@end

@implementation UCEditWifiInfoView

- (instancetype)init {
    if (self = [super init]) {
        [self customUI];
        [self nameLable];
        [self nameTextField];
        [self pwdLabel];
        [self lockButton];
        [self pwdTextField];
        [self separateLine];
    }
    return self;
}

#pragma mark - public method
- (void)setName:(NSString *)name pwd:(NSString *)pwd {
    self.nameTextField.text = name;
    self.pwdTextField.text = pwd;
}

- (NSString *)fetchName {
    return self.nameTextField.text;
}

- (NSString *)fetchPWD {
    return self.pwdTextField.text;
}

#pragma mark - action
- (void)onLockButtonClick:(UIButton *)btn {
    btn.selected = !btn.isSelected;
    self.pwdTextField.secureTextEntry = !btn.isSelected;
}


#pragma mark - UITextFieldDelegate
- (void)textFieldDidChangeSelection:(UITextField *)textField {
    if ([textField isEqual:self.pwdTextField] && [self.delegate respondsToSelector:@selector(onPWDFieldChanged:)]) {
        [self.delegate onPWDFieldChanged:textField];
    }
    if ([textField isEqual:self.nameTextField] && [self.delegate respondsToSelector:@selector(onNameFieldChanged:)]) {
        [self.delegate onNameFieldChanged:textField];
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//    NSMutableString *text = [textField.text mutableCopy];
//    [text replaceCharactersInRange:range withString:string];
    NSString *newContent = [textField.text stringByReplacingCharactersInRange:range withString:string];
//
//      [textField setText:newContent];
//    NSLog(@"text:%@",text);
    if (newContent.length <= 5) {
        textField.text = newContent;
    }
    return NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textFieldShouldClear:(UITextField *)textField {
    return YES;
}

#pragma mark - getter

- (void)customUI {
    self.layer.cornerRadius = 8.f;
    self.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor whiteColor];
}
//UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 40 *2 -16, 0)];
//    label.text = self.connectView.titleLable.text;
//    label.font = self.connectView.titleLable.font;
//    label.numberOfLines = 0;
//    [label sizeToFit];
//    CGFloat height = label.frame.size.height;
//    CGFloat w = label.frame.size.width;

- (UILabel *)nameLable {
    if (!_nameLable) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1000, 0)];
        label.font = [UIFont systemFontOfSize:16];
        label.text = @"网络名称";
        label.numberOfLines = 0;
        [label sizeToFit];
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(20);
            make.leading.equalTo(self).offset(16);
            make.width.mas_equalTo(label.frame.size.width);
        }];
//        [label setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        _nameLable = label;
    }
    return  _nameLable;
}

- (UITextField *)nameTextField {
    if (!_nameTextField) {
        UITextField *textF = [[UITextField alloc] init];
        textF.textAlignment = NSTextAlignmentLeft;
        textF.font = [UIFont systemFontOfSize:16];
        textF.delegate = self;
        [self addSubview:textF];
        [textF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.nameLable.mas_right).offset(30);
            make.centerY.equalTo(self.nameLable);
            make.trailing.equalTo(self).offset(- 16);
        }];
        _nameTextField = textF;
    }
    return  _nameTextField;
}

- (void)separateLine {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor blackColor];
    [self addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self);
        make.height.equalTo(@1);
        make.centerY.equalTo(self);
    }];
}

- (UILabel *)pwdLabel {
    if (!_pwdLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:16];
        label.text = @"密码";
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(- 20);
            make.left.equalTo(self.nameLable);
            make.width.equalTo(self.nameLable);
//            make.right.equalTo(self.nameLable);
//            make.width.mas_equalTo(self.nameLable);
        }];
        _pwdLabel = label;
    }
    return  _pwdLabel;
}

- (UIButton *)lockButton {
    if (!_lockButton) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"show_pwd"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"hide_pwd"] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(onLockButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(25, 25));
            make.bottom.equalTo(self.pwdLabel.mas_bottom);
            make.trailing.equalTo(self).offset(- 16);
        }];

        _lockButton = btn;
    }
    return  _lockButton;

}

- (UITextField *)pwdTextField {
    if (!_pwdTextField) {
        UITextField *textF = [[UITextField alloc] init];
        textF.secureTextEntry = YES;
        textF.clearButtonMode = UITextFieldViewModeAlways;
        textF.keyboardType = UIKeyboardTypeASCIICapable;
        textF.font = [UIFont systemFontOfSize:16];
        textF.delegate = self;
        [self addSubview:textF];
        [textF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLable.mas_right).offset(30);
            make.centerY.equalTo(self.pwdLabel);
            make.right.equalTo(self.lockButton.mas_left).offset(- 16);
        }];
        _pwdTextField = textF;
    }
    return  _pwdTextField;

}



@end
