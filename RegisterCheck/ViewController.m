//
//  ViewController.m
//  RegisterCheck
//
//  Created by xudandan on 16/3/8.
//  Copyright © 2016年 wulian. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) UIButton * submitBtn;
@end
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define USER_NAME @"^[A-Za-z0-9]{3,10}$"
#define USER_EMALL @"[A-Z0-9a-z._%+-]{3,}+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
#define PASSWORD @"[A-Za-z0-9]{6,20}"
#define PHONE_NUMBER @"[0-9]{3}\\-[0-9]{4}\\-[0-9]{4}"
#define TIP_USERNAME @"请填写 3-10位字母和数字的组合"
#define TIP_PASSWORD @"请填写 6-20位字母和数字的组合"
@implementation ViewController {
    UITextField *username;
    UITextField *password;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self makeView];
}

-(void)makeView {
    
    username = [[UITextField alloc] initWithFrame:CGRectMake(15, 66, SCREEN_WIDTH - 30, 44)];
    username.placeholder = @"username";
    username.clearButtonMode = UITextFieldViewModeWhileEditing;
    username.borderStyle = UITextBorderStyleRoundedRect;
    username.layer.borderColor = [UIColor blackColor].CGColor;
    username.delegate = self;
    [self.view addSubview:username];
   
    password = [[UITextField alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(username.frame) + 20, SCREEN_WIDTH - 30, 44)];
    password.placeholder = @"password";
    password.clearButtonMode = UITextFieldViewModeWhileEditing;
    password.secureTextEntry = YES;
    password.borderStyle = UITextBorderStyleRoundedRect;
    password.layer.borderColor = [UIColor blackColor].CGColor;
    password.delegate = self;
    [self.view addSubview:password];
    
    _submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - 40, CGRectGetMaxY(password.frame) + 40, 80, 38)];
    _submitBtn.backgroundColor = [UIColor blueColor];
    _submitBtn.layer.cornerRadius = 5.0;
    [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [_submitBtn addTarget:self action:@selector(submitBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_submitBtn];
}

-(void)submitBtnClicked:(UIButton *)btn {
    
    if ([self validateTextString:username.text andStandardString:USER_NAME] && [self validateTextString:password.text andStandardString:PASSWORD]) {
        
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"注册成功" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:sure];
        [self.navigationController presentViewController:alert animated:YES completion:nil];
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    NSLog(@"%s",__func__);
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"%s",__func__);
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    NSLog(@"%s",__func__);
    return  YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSLog(@"%s",__func__);
    
    NSLog(@"%u",textField.text.length);
    
    if (username == textField) {
        
        BOOL b = [self validateTextString:textField.text andStandardString:USER_NAME];
        UILabel * tipLabel = [self.view viewWithTag:101];
        
        if (!b) {
            if (!tipLabel) {
                tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(textField.frame) + 3, SCREEN_WIDTH - 30, 10)];
                tipLabel.tag = 101;                
                tipLabel.textColor = [UIColor grayColor];
                tipLabel.font = [UIFont systemFontOfSize:9];
                [self.view addSubview:tipLabel];
            }
            tipLabel.text = TIP_USERNAME;
        }else {
            tipLabel.text = @"";
        }
        
    }else if (password == textField) {
        
        BOOL b = [self validateTextString:textField.text andStandardString:PASSWORD];
        UILabel * tipLabel = [self.view viewWithTag:102];
        
        if (!b) {
            if (!tipLabel) {
                tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(textField.frame) + 3, SCREEN_WIDTH - 30, 12)];
                tipLabel.tag = 102;
                tipLabel.textColor = [UIColor grayColor];
                tipLabel.font = [UIFont systemFontOfSize:9];
                [self.view addSubview:tipLabel];
            }
            tipLabel.text = TIP_PASSWORD;
        }else {
            tipLabel.text = @"";
        }
        
    }
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSLog(@"%s",__func__);
    return YES;
}
- (BOOL)textFieldShouldClear:(UITextField *)textField {
    NSLog(@"%s",__func__);
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSLog(@"%s",__func__);
    return YES;
}

//正则表达式  判断格式是否正确
- (BOOL)validateTextString:(NSString *)textString andStandardString:(NSString *)standard {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",standard];
    return [predicate evaluateWithObject:textString];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
