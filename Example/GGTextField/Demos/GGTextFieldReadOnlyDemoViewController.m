//
//  GGTextFieldReadOnlyDemoViewController.m
//  GGTextField Demo
//
//  Created by GG on 2026/4/2.
//

#import "GGTextFieldReadOnlyDemoViewController.h"
#import "GGTextField.h"

@interface GGTextFieldReadOnlyDemoViewController ()
@property (nonatomic, strong) GGTextField *readOnlyField;
@property (nonatomic, strong) UISwitch *enableSwitch;
@end

@implementation GGTextFieldReadOnlyDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUI];
}

- (void)setupUI {
    // 标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"禁止编辑示例";
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    titleLabel.frame = CGRectMake(0.f, 100.f, self.view.bounds.size.width, 30.f);
    
    // 只读输入框
    self.readOnlyField = [[GGTextField alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(titleLabel.frame) + 20.f, self.view.bounds.size.width - 40, 44)];
    self.readOnlyField.placeholder = @"此字段不可编辑";
    self.readOnlyField.borderStyle = UITextBorderStyleRoundedRect;
    self.readOnlyField.text = @"这是一段只读文本";
    self.readOnlyField.enableEdit = NO;
    self.readOnlyField.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.readOnlyField];
    
    // 开关控制
    UILabel *switchLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.readOnlyField.frame) + 20.f, 100, 30)];
    switchLabel.text = @"允许编辑:";
    [self.view addSubview:switchLabel];
    
    self.enableSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(120, CGRectGetMinY(switchLabel.frame), 0, 0)];
    [self.enableSwitch addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.enableSwitch];
    
    // 说明
    UITextView *infoView = [[UITextView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.enableSwitch.frame) + 20.f, self.view.bounds.size.width - 40, 200)];
    infoView.font = [UIFont systemFontOfSize:14];
    infoView.editable = NO;
    infoView.text = @"功能说明：\n\n1. enableEdit 属性控制编辑权限\n2. YES: 允许编辑\n3. NO: 禁止编辑 (只读)\n4. 只读时背景色自动变灰\n5. 无法弹出键盘";
    infoView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:infoView];
}

- (void)switchValueChanged:(UISwitch *)sender {
    self.readOnlyField.enableEdit = sender.on;
    self.readOnlyField.backgroundColor = sender.on ? [UIColor whiteColor] : [UIColor lightGrayColor];
    self.readOnlyField.text = sender.on ? @"现在可以编辑了" : @"此字段不可编辑";
}

@end
