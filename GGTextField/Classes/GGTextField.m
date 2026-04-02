//
//  GGTextField.m
//  Seventeena
//
//  Created by WeiGuanghui on 2018/8/12.
//  Copyright © 2018年 zyy. All rights reserved.
//

#import "GGTextField.h"
//#import "GGTextFieldDelegateProxy.h"

@interface GGTextField () <UITextFieldDelegate>
//@property (nonatomic, strong) GGTextFieldDelegateProxy *delegateProxy;
@property (nonatomic, assign) BOOL _jugeReslut;
/// 保存外部代理
@property (nonatomic, weak) id<UITextFieldDelegate> externalDelegate;
@end

@implementation GGTextField

#pragma mark - Lifecycle

- (instancetype)init {
    if (self = [super init]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.maxCountLimit = NSIntegerMax;
    _placeholderTextColor = [UIColor systemGray6Color];
    _enablePaste = YES;
    _enableSelect = YES;
    _enableSelectAll = YES;
    _enableEdit = YES;
    
    self.delegate = self;
    
    [self addTarget:self action:@selector(textFieldChanged) forControlEvents:UIControlEventEditingChanged];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidChangeSelection:(UITextField *)textField {
    if ([self.externalDelegate respondsToSelector:@selector(textFieldDidChangeSelection:)]) {
        [self.externalDelegate textFieldDidChangeSelection:textField];
    }
}

- (nullable UIMenu *)textField:(UITextField *)textField editMenuForCharactersInRange:(NSRange)range suggestedActions:(NSArray<UIMenuElement *> *)suggestedActions API_AVAILABLE(ios(16.0)) {
    if ([self.externalDelegate respondsToSelector:@selector(textField:editMenuForCharactersInRange:suggestedActions:)]) {
        return [self.externalDelegate textField:textField editMenuForCharactersInRange:range suggestedActions:suggestedActions];
    }
    
    return nil;
}

- (void)textField:(UITextField *)textField willPresentEditMenuWithAnimator:(id<UIEditMenuInteractionAnimating>)animator API_AVAILABLE(ios(16.0))  {
    if ([self.externalDelegate respondsToSelector:@selector(textField:willPresentEditMenuWithAnimator:)]) {
        [self.externalDelegate textField:textField willPresentEditMenuWithAnimator:animator];
    }
}

- (void)textField:(UITextField *)textField willDismissEditMenuWithAnimator:(id<UIEditMenuInteractionAnimating>)animator API_AVAILABLE(ios(16.0)) {
    if ([self.externalDelegate respondsToSelector:@selector(textField:willDismissEditMenuWithAnimator:)]) {
        [self.externalDelegate textField:textField willDismissEditMenuWithAnimator:animator];
    }
}

- (void)textField:(UITextField *)textField insertInputSuggestion:(UIInputSuggestion *)inputSuggestion API_AVAILABLE(ios(18.4)) {
    if ([self.externalDelegate respondsToSelector:@selector(textField:insertInputSuggestion:)]) {
        [self.externalDelegate textField:textField insertInputSuggestion:inputSuggestion];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    // ✅ 先询问外部代理
    if ([self.externalDelegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
        BOOL shouldEdit = [self.externalDelegate textFieldShouldBeginEditing:textField];
        if (!shouldEdit) {
            return NO;
        }
    }
    
    return _enableEdit;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    // ✅ 转发给外部代理
    if ([self.externalDelegate respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
        return [self.externalDelegate textFieldShouldEndEditing:textField];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    // ✅ 通知外部代理
    if ([self.externalDelegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        [self.externalDelegate textFieldDidBeginEditing:textField];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    // ✅ 通知外部代理
    if ([self.externalDelegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        [self.externalDelegate textFieldDidEndEditing:textField];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason {
    if ([self.externalDelegate respondsToSelector:@selector(textFieldDidEndEditing:reason:)]) {
        [self.externalDelegate textFieldDidEndEditing:textField reason:reason];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    // ✅ 转发给外部代理
    if ([self.externalDelegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
        return [self.externalDelegate textFieldShouldReturn:textField];
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    // ✅ 转发给外部代理
    if ([self.externalDelegate respondsToSelector:@selector(textFieldShouldClear:)]) {
        return [self.externalDelegate textFieldShouldClear:textField];
    }
    
    if (!_enableEdit) {
        // 不允许编辑
        return NO;
    }
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // ✅ 先询问外部代理（如果实现了）
    if ([self.externalDelegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        BOOL shouldChange = [self.externalDelegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
        return shouldChange;
    }
    
    if (!_enableEdit) {
        // 不允许编辑
        return NO;
    }
    
    if (string.length == 0) {
        return YES; // 允许删除
    }

    NSInteger limit = self.maxCountLimit > 0 ? self.maxCountLimit : NSIntegerMax;
    if (textField.text.length + string.length - range.length > limit) {
        return NO;
    }

    switch (self.ggType) {
        case GGTextFieldType_Money: {
            if ([string isEqualToString:@"."]) {
                // 不在此处修改 self.text！避免副作用
                return ![textField.text containsString:@"."];
            }
            return [NSString gg_isMoneyString:string];
        }
            break;
        case GGTextFieldType_Phone: {
            NSString *newText = [textField.text stringByReplacingCharactersInRange:range withString:string];
            return newText.length <= 11 && [NSString gg_isDigitString:string];
        }
            break;
        case GGTextFieldType_IDCard: {
            NSString *newText = [textField.text stringByReplacingCharactersInRange:range withString:string];
            if (newText.length > 18) return NO;
            return [NSString gg_isValidIDCardChar:string];
        }
            break;
        case GGTextFieldType_Password:
            return YES;
            break;
        case GGTextFieldType_BankCard:
            return [NSString gg_isDigitString:string];
            break;
        case GGTextFieldType_None:
            return YES;
            break;
    }
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(paste:)) return _enablePaste;
    if (action == @selector(select:)) return _enableSelect;
    if (action == @selector(selectAll:)) return _enableSelectAll;
    return [super canPerformAction:action withSender:sender];
}

#pragma mark - Text Changed

- (void)textFieldChanged {
    // 身份证自动转大写 X（仅当用户输入小写 x 时）
    if (self.ggType == GGTextFieldType_IDCard && [self.text rangeOfString:@"x"].location != NSNotFound) {
        self.text = [self.text uppercaseString];
        return; // 避免重复回调
    }
    
    // 价格只有"."自动转"0."
    if (self.ggType == GGTextFieldType_Money && [self.text isEqual:@"."]) {
        self.text = @"0.";
        return; // 避免重复回调
    }

    // 回调 block
    if (self.textChangeBlock) {
        self.textChangeBlock(self.text);
    }

    // 校验
    BOOL jugeReslut = [self updateValidationResult];
    if (self.textEditingChangedJugeReslutBlock) {
        self.textEditingChangedJugeReslutBlock(jugeReslut);
    }
}

- (BOOL)updateValidationResult {
    NSString *text = self.text ?: @"";
    
    BOOL jugeReslut = YES;
    
    switch (self.ggType) {
        case GGTextFieldType_None:
            jugeReslut = YES;
            break;
        case GGTextFieldType_Phone:
            jugeReslut = [NSString gg_checkIsPhoneNumber:text];
            break;
        case GGTextFieldType_IDCard:
            jugeReslut = [NSString gg_checkIsIDCardNumber:text];
            break;
        case GGTextFieldType_Password:
            jugeReslut = [NSString gg_checkIsRightPassword:text];
            break;
        case GGTextFieldType_BankCard:
            jugeReslut = [NSString gg_IsBankCard:text];
            break;
        case GGTextFieldType_Money:
            jugeReslut = [NSString gg_isValidMoney:text];
            break;
    }
    
    return jugeReslut;
}

#pragma mark - Delegate Forwarding

- (void)setDelegate:(id<UITextFieldDelegate>)delegate {
    if (delegate == self) {
        [super setDelegate:self];
    } else {
        _externalDelegate = delegate;
        
        [super setDelegate:self];
    }
}

- (id<UITextFieldDelegate>)delegate {
    return self.externalDelegate;
}

#pragma mark - Private
- (NSMutableAttributedString *)_createPlaceholderAttribusString {
    NSMutableAttributedString *attsString = nil;
    NSString *_placelholder = self.placeholder ? : self.attributedPlaceholder.string;
    
    if (!_placelholder) {
        NSLog(@"placeholder = nil");
        return nil;
    }
    
    if (self.attributedPlaceholder) {
        attsString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedPlaceholder];
    } else if (self.placeholder) {
        attsString = [[NSMutableAttributedString alloc] initWithString:self.placeholder];
    }
        
    if (self.placeholderFont) {
        [attsString addAttributes:@{
            NSFontAttributeName: self.placeholderFont,
        } range:NSMakeRange(0, _placelholder.length)];
    } else {
        [attsString addAttributes:@{
            NSFontAttributeName: self.font ? : [UIFont systemFontOfSize:12.0],
        } range:NSMakeRange(0, _placelholder.length)];
    }
    
    if (self.placeholderTextColor) {
        [attsString addAttributes:@{
            NSForegroundColorAttributeName: self.placeholderTextColor,
        } range:NSMakeRange(0, _placelholder.length)];
    }
    
    return attsString;
}

#pragma mark - Setters

- (void)setEnableEdit:(BOOL)enableEdit {
    _enableEdit = enableEdit;
    
    if (!enableEdit && self.isEditing) {
        [self endEditing:YES];
    }
}

- (void)setGgType:(GGTextFieldType)ggType {
    _ggType = ggType;
    switch (ggType) {
        case GGTextFieldType_Money:
        case GGTextFieldType_Phone:
        case GGTextFieldType_BankCard:
            self.keyboardType = UIKeyboardTypeDecimalPad;
            self.secureTextEntry = NO;
            break;
        case GGTextFieldType_Password:
            self.keyboardType = UIKeyboardTypeDefault;
            self.secureTextEntry = YES;
            break;
        default:
            self.keyboardType = UIKeyboardTypeDefault;
            self.secureTextEntry = NO;
            break;
    }
    [self updateValidationResult];
}

- (void)setText:(NSString *)text {
    [super setText:text];
    // 🔸 注意：程序设置文本也应触发校验和回调（与原逻辑一致）
    [self textFieldChanged];
}

- (void)setPlaceholderTextColor:(UIColor *)placeholderTextColor {
    _placeholderTextColor = placeholderTextColor;
    
    self.attributedPlaceholder = [self _createPlaceholderAttribusString];
}

- (void)setPlaceholderFont:(UIFont *)placeholderFont {
    _placeholderFont = placeholderFont;
    
    self.attributedPlaceholder = [self _createPlaceholderAttribusString];
}

- (void)setPlaceholder:(NSString *)placeholder {
    [super setPlaceholder:placeholder];
    
    self.attributedPlaceholder = [self _createPlaceholderAttribusString];
}

#pragma mark - UI Overrides

- (CGRect)textRectForBounds:(CGRect)bounds {
    bounds = UIEdgeInsetsInsetRect(bounds, self.textInsets);
    return [super textRectForBounds:bounds];
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    bounds = UIEdgeInsetsInsetRect(bounds, self.textInsets);
    return [super editingRectForBounds:bounds];
}

- (CGRect)clearButtonRectForBounds:(CGRect)bounds {
    CGRect rect = [super clearButtonRectForBounds:bounds];
    return CGRectOffset(rect, self.clearButtonPositionAdjustment.horizontal, self.clearButtonPositionAdjustment.vertical);
}

@end
