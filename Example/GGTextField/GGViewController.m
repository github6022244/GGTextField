//
//  GGViewController.m
//  GGTextField Demo
//
//  Created by GG on 2026/4/2.
//

#import "GGViewController.h"
#import "GGTextField.h"

#pragma mark - 子控制器声明
@interface GGViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *demoItems;
@end

@implementation GGViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"GGTextField 示例";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupDemoItems];
    
    [self setUpUI];
    
    [self.tableView reloadData];
}

#pragma mark - Setup

- (void)setupDemoItems {
    _demoItems = @[
        @{@"title": @"基础输入", @"desc": @"普通文本输入，带字数限制", @"vcClass": @"GGTextFieldBasicDemoViewController"},
        @{@"title": @"手机号输入", @"desc": @"自动校验 11 位手机号格式", @"vcClass": @"GGTextFieldPhoneDemoViewController"},
        @{@"title": @"身份证号", @"desc": @"身份证号码输入，自动转大写 X", @"vcClass": @"GGTextFieldIDCardDemoViewController"},
        @{@"title": @"密码输入", @"desc": @"8-16 位，含数字和大小写字母", @"vcClass": @"GGTextFieldPasswordDemoViewController"},
        @{@"title": @"银行卡号", @"desc": @"银行卡号输入与校验", @"vcClass": @"GGTextFieldBankCardDemoViewController"},
        @{@"title": @"金额输入", @"desc": @"价格输入，支持两位小数", @"vcClass": @"GGTextFieldMoneyDemoViewController"},
        @{@"title": @"禁止编辑", @"desc": @"只读模式展示", @"vcClass": @"GGTextFieldReadOnlyDemoViewController"},
        @{@"title": @"自定义样式", @"desc": @"Placeholder 颜色、Padding 等", @"vcClass": @"GGTextFieldCustomStyleDemoViewController"},
    ];
}

#pragma mark - UI
- (void)setUpUI {
    [self.view addSubview:self.tableView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.tableView.frame = CGRectMake(0.f, 0.f, self.view.bounds.size.width, self.view.bounds.size.height);
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.demoItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellReuseID = @"DemoCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellReuseID];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:16.0];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14.f];
    }
    
    NSDictionary *item = self.demoItems[indexPath.row];
    
    cell.textLabel.text = item[@"title"];
    cell.detailTextLabel.text = item[@"desc"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIViewController *vc = [self viewControllerForIndex:indexPath.row];
    if (vc) {
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - View Controller Factory

- (UIViewController *)viewControllerForIndex:(NSInteger)index {
    NSDictionary *dict = self.demoItems[index];
    
    NSString *vcClass = dict[@"vcClass"];
    
    if (!vcClass.length) {
        return nil;
    }
    
    UIViewController *vc = [NSClassFromString(vcClass) new];
    
    vc.title = dict[@"title"];
    
    return vc;
}

#pragma mark - getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 50.f;
        _tableView.rowHeight = 50.f;
        _tableView.estimatedSectionHeaderHeight = 12.f;
        _tableView.estimatedSectionFooterHeight = 12.f;
    }
    
    return _tableView;
}

@end
