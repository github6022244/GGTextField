//
//  GGTextFieldBankCardDemoViewController.m
//  GGTextField Demo
//
//  Created by GG on 2026/4/2.
//

#import "GGTextFieldBankCardDemoViewController.h"
#import "GGTextField.h"

@interface GGTextFieldBankCardDemoViewController ()
@property (nonatomic, strong) GGTextField *bankCardField;
@property (nonatomic, strong) UILabel *statusLabel;
@end

@implementation GGTextFieldBankCardDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUI];
}

- (void)setupUI {
    // 标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"银行卡号输入示例";
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    titleLabel.frame = CGRectMake(0.f, 100.f, self.view.bounds.size.width, 30.f);
    
    // 银行卡输入框
    self.bankCardField = [[GGTextField alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(titleLabel.frame) + 20.f, self.view.bounds.size.width - 40, 44)];
    self.bankCardField.placeholder = @"请输入银行卡号";
    self.bankCardField.borderStyle = UITextBorderStyleRoundedRect;
    self.bankCardField.ggType = GGTextFieldType_BankCard;
    self.bankCardField.keyboardType = UIKeyboardTypeNumberPad;
    
    __weak typeof(self) weakSelf = self;
    self.bankCardField.textEditingChangedJugeReslutBlock = ^(BOOL jugeReslut) {
        if (jugeReslut) {
            weakSelf.statusLabel.text = @"✓ 银行卡号格式正确";
            weakSelf.statusLabel.textColor = [UIColor greenColor];
        } else {
            weakSelf.statusLabel.text = @"✗ 银行卡号格式错误";
            weakSelf.statusLabel.textColor = [UIColor redColor];
        }
    };
    
    self.bankCardField.textChangeBlock = ^(NSString *text) {
        NSLog(@"text == %@", text);
    };
    
    [self.view addSubview:self.bankCardField];
    
    // 状态标签
    self.statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.bankCardField.frame) + 20.f, self.view.bounds.size.width - 40, 30)];
    self.statusLabel.font = [UIFont systemFontOfSize:14];
    self.statusLabel.text = @"请输入银行卡号进行验证";
    [self.view addSubview:self.statusLabel];
    
    // 说明
    UITextView *infoView = [[UITextView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.statusLabel.frame) + 20.f, self.view.bounds.size.width - 40, 200)];
    infoView.font = [UIFont systemFontOfSize:14];
    infoView.editable = NO;
    infoView.text = @"功能说明：\n\n1. 仅允许输入数字\n2. 自动过滤非数字字符\n3. 格式校验仅判断是否有输入(不做过多校验了)\n4. 实时校验";
    infoView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:infoView];
}

@end
