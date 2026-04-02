//
//  GGTextFieldPasswordDemoViewController.m
//  GGTextField Demo
//
//  Created by GG on 2026/4/2.
//

#import "GGTextFieldPasswordDemoViewController.h"
#import "GGTextField.h"

@interface GGTextFieldPasswordDemoViewController ()
@property (nonatomic, strong) GGTextField *passwordField;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UIButton *toggleButton;
@end

@implementation GGTextFieldPasswordDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUI];
}

- (void)setupUI {
    // 标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"密码输入示例";
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    titleLabel.frame = CGRectMake(0.f, 100.f, self.view.bounds.size.width, 30.f);
    
    // 密码输入框
    self.passwordField = [[GGTextField alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(titleLabel.frame) + 20.f, self.view.bounds.size.width - 40, 44)];
    self.passwordField.placeholder = @"请输入密码 (8-16 位)";
    self.passwordField.borderStyle = UITextBorderStyleRoundedRect;
    self.passwordField.maxCountLimit = 16;
    self.passwordField.ggType = GGTextFieldType_Password;
    self.passwordField.secureTextEntry = YES;
    
    __weak typeof(self) weakSelf = self;
    self.passwordField.textEditingChangedJugeReslutBlock = ^(BOOL jugeReslut) {
        if (jugeReslut) {
            weakSelf.statusLabel.text = @"✓ 密码格式正确 (需含数字和大小写字母)";
            weakSelf.statusLabel.textColor = [UIColor greenColor];
        } else {
            weakSelf.statusLabel.text = @"✗ 密码格式错误";
            weakSelf.statusLabel.textColor = [UIColor redColor];
        }
    };
    
    [self.view addSubview:self.passwordField];
    
    // 状态标签
    self.statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.passwordField.frame) + 20.f, self.view.bounds.size.width - 40, 30)];
    self.statusLabel.font = [UIFont systemFontOfSize:14];
    self.statusLabel.text = @"请输入密码进行验证";
    [self.view addSubview:self.statusLabel];
    
    // 显示/隐藏按钮
    self.toggleButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.toggleButton setTitle:@"显示密码" forState:UIControlStateNormal];
    [self.toggleButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.toggleButton.frame = CGRectMake(20, CGRectGetMaxY(self.statusLabel.frame) + 20.f, 120, 40);
    [self.toggleButton addTarget:self action:@selector(togglePasswordVisibility) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.toggleButton];
    
    // 状态标签
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, CGRectGetMinY(self.toggleButton.frame), self.view.bounds.size.width - 170, 30)];
    tipLabel.font = [UIFont systemFontOfSize:12];
    tipLabel.textColor = [UIColor grayColor];
    tipLabel.text = @"8-16 位，含数字和大小写字母";
    [self.view addSubview:tipLabel];
    
    // 说明
    UITextView *infoView = [[UITextView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(tipLabel.frame) + 20.f, self.view.bounds.size.width - 40, 200)];
    infoView.font = [UIFont systemFontOfSize:14];
    infoView.editable = NO;
    infoView.text = @"功能说明：\n\n1. 8-16 位长度限制\n2. 必须包含数字\n3. 必须包含大小写字母\n4. 实时格式校验";
    infoView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:infoView];
}

- (void)togglePasswordVisibility {
    self.passwordField.secureTextEntry = !self.passwordField.secureTextEntry;
    NSString *title = self.passwordField.secureTextEntry ? @"显示密码" : @"隐藏密码";
    [self.toggleButton setTitle:title forState:UIControlStateNormal];
}

@end
