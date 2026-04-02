//
//  GGTextFieldCustomStyleDemoViewController.m
//  GGTextField Demo
//
//  Created by GG on 2026/4/2.
//

#import "GGTextFieldCustomStyleDemoViewController.h"
#import "GGTextField.h"

@interface GGTextFieldCustomStyleDemoViewController ()
@property (nonatomic, strong) GGTextField *customField;
@end

@implementation GGTextFieldCustomStyleDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUI];
}

- (void)setupUI {
    // 标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"自定义样式示例";
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    titleLabel.frame = CGRectMake(0.f, 100.f, self.view.bounds.size.width, 30.f);
    
    // 自定义样式的输入框
    self.customField = [[GGTextField alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(titleLabel.frame) + 20.f, self.view.bounds.size.width - 40, 50)];
    self.customField.placeholder = @"自定义 Placeholder 颜色字体和 Padding 、clearButton 位置";
    self.customField.borderStyle = UITextBorderStyleNone;
    self.customField.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0];
    self.customField.layer.cornerRadius = 8;
    self.customField.layer.borderWidth = 1;
    self.customField.layer.borderColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0].CGColor;
    
    // 自定义 Placeholder 颜色
    self.customField.placeholderTextColor = [UIColor redColor];
    
    // 自定义 Placeholder 字体
    self.customField.placeholderFont = [UIFont boldSystemFontOfSize:11.f];
    
    // 自定义 Padding
    self.customField.textInsets = UIEdgeInsetsMake(0, 30, 0, 30);
    
    // 自定义 ClearButton 位置
    self.customField.clearButtonPositionAdjustment = UIOffsetMake(-30, 0);
    
    // 其他属性
    self.customField.maxCountLimit = 50;
    self.customField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    [self.view addSubview:self.customField];
    
    // 说明
    UITextView *infoView = [[UITextView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.customField.frame) + 20.f, self.view.bounds.size.width - 40, 300)];
    infoView.font = [UIFont systemFontOfSize:14];
    infoView.editable = NO;
    infoView.text = @"功能说明：\n\n1. placeholderTextColor、placeholderFont: 自定义 Placeholder \n2. textInsets: 控制文字 Padding\n3. 调整 ClearButton 位置";
    infoView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:infoView];
}

@end
