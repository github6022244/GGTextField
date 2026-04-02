//
//  GGTextFieldIDCardDemoViewController.m
//  GGTextField Demo
//
//  Created by GG on 2026/4/2.
//

#import "GGTextFieldIDCardDemoViewController.h"
#import "GGTextField.h"

@interface GGTextFieldIDCardDemoViewController ()
@property (nonatomic, strong) GGTextField *idCardField;
@property (nonatomic, strong) UILabel *statusLabel;
@end

@implementation GGTextFieldIDCardDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUI];
}

- (void)setupUI {
    // 标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"身份证号输入示例";
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    titleLabel.frame = CGRectMake(0.f, 100.f, self.view.bounds.size.width, 30.f);
    
    // 身份证输入框
    self.idCardField = [[GGTextField alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(titleLabel.frame) + 20.f, self.view.bounds.size.width - 40, 44)];
    self.idCardField.placeholder = @"请输入 18 位身份证号";
    self.idCardField.borderStyle = UITextBorderStyleRoundedRect;
    self.idCardField.maxCountLimit = 18;
    self.idCardField.ggType = GGTextFieldType_IDCard;
    
    __weak typeof(self) weakSelf = self;
    self.idCardField.textChangeBlock = ^(NSString *text) {
        NSLog(@"身份证输入：%@", text);
    };
    
    self.idCardField.textEditingChangedJugeReslutBlock = ^(BOOL jugeReslut) {
        if (jugeReslut) {
            weakSelf.statusLabel.text = @"✓ 身份证号格式正确";
            weakSelf.statusLabel.textColor = [UIColor greenColor];
        } else {
            weakSelf.statusLabel.text = @"✗ 身份证号格式错误";
            weakSelf.statusLabel.textColor = [UIColor redColor];
        }
    };
    
    [self.view addSubview:self.idCardField];
    
    // 状态标签
    self.statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.idCardField.frame) + 20.f, self.view.bounds.size.width - 40, 30)];
    self.statusLabel.font = [UIFont systemFontOfSize:14];
    self.statusLabel.text = @"请输入身份证号进行验证";
    [self.view addSubview:self.statusLabel];
    
    // 说明
    UITextView *infoView = [[UITextView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.statusLabel.frame) + 20.f, self.view.bounds.size.width - 40, 200)];
    infoView.font = [UIFont systemFontOfSize:14];
    infoView.editable = NO;
    infoView.text = @"功能说明：\n\n1. 自动限制 18 位\n2. 小写 x 自动转大写 X\n3. 限制输入数字和 X 字符\n4. 完整的身份证校验算法\n5. 支持验证";
    infoView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:infoView];
}

@end
