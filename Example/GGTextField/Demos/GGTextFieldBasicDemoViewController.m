//
//  GGTextFieldBasicDemoViewController.m
//  GGTextField Demo
//
//  Created by GG on 2026/4/2.
//

#import "GGTextFieldBasicDemoViewController.h"
#import "GGTextField.h"

@interface GGTextFieldBasicDemoViewController ()
@property (nonatomic, strong) GGTextField *textField;
@property (nonatomic, strong) UILabel *resultLabel;
@end

@implementation GGTextFieldBasicDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUI];
}

- (void)setupUI {
    NSUInteger maxLimit = 6;
    
    // 标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = [NSString stringWithFormat:@"基础输入示例（最大 %ld 字）", maxLimit];
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    titleLabel.frame = CGRectMake(0.f, 100.f, self.view.bounds.size.width, 30.f);
    
    // TextField
    self.textField = [[GGTextField alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(titleLabel.frame) + 20.f, self.view.bounds.size.width - 40, 44)];
    self.textField.placeholder = @"请输入内容";
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    self.textField.maxCountLimit = maxLimit;
    self.textField.ggType = GGTextFieldType_None;
    
    // 文字变化回调
    __weak typeof(self) weakSelf = self;
    self.textField.textChangeBlock = ^(NSString *text) {
        weakSelf.resultLabel.text = [NSString stringWithFormat:@"当前输入：%@ (%lu 字)", text ?: @"", (unsigned long)text.length];
    };
    
    // 格式判断回调
    self.textField.textEditingChangedJugeReslutBlock = ^(BOOL jugeReslut) {
        NSLog(@"格式判断结果：%d", jugeReslut);
    };
    
    [self.view addSubview:self.textField];
    
    // 结果展示
    self.resultLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.textField.frame) + 20.f, self.view.bounds.size.width - 40, 30)];
    self.resultLabel.font = [UIFont systemFontOfSize:14];
    self.resultLabel.textColor = [UIColor grayColor];
    self.resultLabel.text = @"当前输入： (0 字)";
    [self.view addSubview:self.resultLabel];
    
    // 说明
    UITextView *infoView = [[UITextView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.resultLabel.frame) + 20.f, self.view.bounds.size.width - 40, 200)];
    infoView.font = [UIFont systemFontOfSize:14];
    infoView.textColor = [UIColor darkTextColor];
    infoView.editable = NO;
    infoView.text = [NSString stringWithFormat:@"功能说明：\n\n1. 最大字数限制：%ld 字\n2. 实时显示输入内容\n3. 支持文字变化回调\n4. 支持格式验证回调", maxLimit];
    infoView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:infoView];
}

@end
