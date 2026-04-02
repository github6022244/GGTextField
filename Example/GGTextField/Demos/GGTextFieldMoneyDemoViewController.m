//
//  GGTextFieldMoneyDemoViewController.m
//  GGTextField Demo
//
//  Created by GG on 2026/4/2.
//

#import "GGTextFieldMoneyDemoViewController.h"
#import "GGTextField.h"

@interface GGTextFieldMoneyDemoViewController ()
@property (nonatomic, strong) GGTextField *moneyField;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UILabel *amountLabel;
@end

@implementation GGTextFieldMoneyDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUI];
}

- (void)setupUI {
    // 标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"金额输入示例";
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    titleLabel.frame = CGRectMake(0.f, 100.f, self.view.bounds.size.width, 30.f);
    
    // 金额输入框
    self.moneyField = [[GGTextField alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(titleLabel.frame) + 20.f, self.view.bounds.size.width - 40, 44)];
    self.moneyField.placeholder = @"请输入金额 (如：100.50)";
    self.moneyField.borderStyle = UITextBorderStyleRoundedRect;
    self.moneyField.ggType = GGTextFieldType_Money;
    self.moneyField.keyboardType = UIKeyboardTypeDecimalPad;
    
    __weak typeof(self) weakSelf = self;
    self.moneyField.textChangeBlock = ^(NSString *text) {
        weakSelf.amountLabel.text = [NSString stringWithFormat:@"金额：¥ %@", text ?: @"0.00"];
    };
    
    self.moneyField.textEditingChangedJugeReslutBlock = ^(BOOL jugeReslut) {
        if (jugeReslut) {
            weakSelf.statusLabel.text = @"✓ 金额格式正确";
            weakSelf.statusLabel.textColor = [UIColor greenColor];
        } else {
            weakSelf.statusLabel.text = @"✗ 金额格式错误 (最多两位小数)";
            weakSelf.statusLabel.textColor = [UIColor redColor];
        }
    };
    
    [self.view addSubview:self.moneyField];
    
    // 金额显示
    self.amountLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.moneyField.frame) + 20.f, self.view.bounds.size.width - 40, 30)];
    self.amountLabel.font = [UIFont boldSystemFontOfSize:16];
    self.amountLabel.textColor = [UIColor orangeColor];
    self.amountLabel.text = @"金额：¥ 0.00";
    [self.view addSubview:self.amountLabel];
    
    // 状态标签
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.amountLabel.frame) + 20.f, self.view.bounds.size.width - 40, 30)];
    tipLabel.font = [UIFont systemFontOfSize:12];
    tipLabel.textColor = [UIColor grayColor];
    tipLabel.text = @"支持整数或两位小数";
    [self.view addSubview:tipLabel];
    
    // 说明
    UITextView *infoView = [[UITextView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(tipLabel.frame) + 20.f, self.view.bounds.size.width - 40, 200)];
    infoView.font = [UIFont systemFontOfSize:14];
    infoView.editable = NO;
    infoView.text = @"功能说明：\n\n1. 数字键盘\n2. 支持小数点\n3. 最多两位小数\n4. 自动过滤非法字符\n5. 实时金额格式化";
    infoView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:infoView];
}

@end
