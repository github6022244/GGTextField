//
//  GGTextFieldPhoneDemoViewController.m
//  GGTextField Demo
//
//  Created by GG on 2026/4/2.
//

#import "GGTextFieldPhoneDemoViewController.h"
#import "GGTextField.h"

@interface GGTextFieldPhoneDemoViewController ()
@property (nonatomic, strong) GGTextField *phoneField;
@property (nonatomic, strong) UILabel *statusLabel;
@end

@implementation GGTextFieldPhoneDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUI];
}

- (void)setupUI {
    // 标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"手机号输入示例";
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    titleLabel.frame = CGRectMake(0.f, 100.f, self.view.bounds.size.width, 30.f);
    
    // 手机号输入框
    self.phoneField = [[GGTextField alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(titleLabel.frame) + 20.f, self.view.bounds.size.width - 40, 44)];
    self.phoneField.placeholder = @"请输入 11 位手机号";
    self.phoneField.borderStyle = UITextBorderStyleRoundedRect;
    self.phoneField.maxCountLimit = 11;
    self.phoneField.ggType = GGTextFieldType_Phone;
    self.phoneField.keyboardType = UIKeyboardTypeNumberPad;
    
    __weak typeof(self) weakSelf = self;
    self.phoneField.textEditingChangedJugeReslutBlock = ^(BOOL jugeReslut) {
        if (jugeReslut) {
            weakSelf.statusLabel.text = @"✓ 手机号格式正确";
            weakSelf.statusLabel.textColor = [UIColor greenColor];
        } else {
            weakSelf.statusLabel.text = @"✗ 手机号格式错误";
            weakSelf.statusLabel.textColor = [UIColor redColor];
        }
    };
    
    [self.view addSubview:self.phoneField];
    
    // 状态标签
    self.statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.phoneField.frame) + 20.f, self.view.bounds.size.width - 40, 30)];
    self.statusLabel.font = [UIFont systemFontOfSize:14];
    self.statusLabel.text = @"请输入手机号进行验证";
    [self.view addSubview:self.statusLabel];
    
    // 说明
    UITextView *infoView = [[UITextView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.statusLabel.frame) + 20.f, self.view.bounds.size.width - 40, 200)];
    infoView.font = [UIFont systemFontOfSize:14];
    infoView.editable = NO;
    infoView.text = @"功能说明：\n\n1. 自动限制 11 位数字\n2. 仅允许输入数字\n3. 实时格式校验\n4. 支持 13-9 所有号段";
    infoView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:infoView];
}

@end
