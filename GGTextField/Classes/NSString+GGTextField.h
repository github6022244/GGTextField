//
//  NSString+GGTextField.h
//  Seventeena
//
//  Created by WeiGuanghui on 2018/8/12.
//  Copyright © 2018年 zyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (GGTextField)

/**
 *  检查手机号格式是否正确
 */
+ (BOOL)gg_checkIsPhoneNumber:(NSString *)mobile;

/**
 *  检查身份证格式是否正确
 */
+ (BOOL)gg_checkIsIDCardNumber:(NSString *)IDNumber;

/**
 *  校验银行卡
 */
+ (BOOL)gg_IsBankCard:(NSString *)cardNumber;

/**
 *  检查密码格式是否正确
 *  正确返回 ture
 *  错误返回 错误信息
 */
+ (BOOL)gg_checkIsRightPassword:(NSString *)password;


/// 价格校验
/// - Parameter text: text
+ (BOOL)gg_isValidMoney:(NSString *)text;


/// 单个字符是否是数字
/// - Parameter str: 单个字符
/// @warning 单个字符判断!
+ (BOOL)gg_isDigitString:(NSString *)str;

/// 单个字符是否是价格字符
/// - Parameter str: 单个字符
/// @warning 单个字符判断!
+ (BOOL)gg_isMoneyString:(NSString *)str;


/// 单个字符是否是身份证格式
/// - Parameter str: 单个字符
/// @warning 单个字符判断!
+ (BOOL)gg_isValidIDCardChar:(NSString *)str;

///**
// 是否包含表情符号判断
// */
//+ (BOOL)gg_checkStringContainsEmoji:(NSString *)string;

@end
