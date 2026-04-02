//
//  NSString+GGTextField.m
//  Seventeena
//
//  Created by WeiGuanghui on 2018/8/12.
//  Copyright © 2018年 zyy. All rights reserved.
//

#import "NSString+GGTextField.h"

@implementation NSString (GGTextField)

+ (BOOL)gg_checkIsPhoneNumber:(NSString *)mobile
{
    if (mobile.length != 11)
    {
        return NO;
    }
    else
    {
        /**
         * 移动号段正则表达式
         */
        NSString *regex = @"^1[3-9]\\d{9}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        BOOL isMatch = [pred evaluateWithObject:mobile];
        
        return isMatch;
    }
}

+ (BOOL)gg_checkIsIDCardNumber:(NSString *)identityString
{
    if (identityString.length != 18) return NO;
    
    identityString = [identityString stringByReplacingOccurrencesOfString:@"x" withString:@"X"];
    
    // 正则表达式判断基本 身份证号是否满足格式
    NSString *regex = @"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X)$";
  //  NSString *regex = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityStringPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    //如果通过该验证，说明身份证格式正确，但准确性还需计算
    if(![identityStringPredicate evaluateWithObject:identityString]) return NO;
    
    //** 开始进行校验 *//
    
    //将前17位加权因子保存在数组里
    NSArray *idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
    
    //这是除以11后，可能产生的11位余数、验证码，也保存成数组
    NSArray *idCardYArray = @[@"1", @"0", @"X", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    
    //用来保存前17位各自乖以加权因子后的总和
    NSInteger idCardWiSum = 0;
    for(int i = 0;i < 17;i++) {
        NSInteger subStrIndex = [[identityString substringWithRange:NSMakeRange(i, 1)] integerValue];
        NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
        idCardWiSum+= subStrIndex * idCardWiIndex;
    }
    
    //计算出校验码所在数组的位置
    NSInteger idCardMod=idCardWiSum%11;
    //得到最后一位身份证号码
    NSString *idCardLast= [identityString substringWithRange:NSMakeRange(17, 1)];
    //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
    if(idCardMod==2) {
        if(![idCardLast isEqualToString:@"X"] && ![idCardLast isEqualToString:@"x"]) {
            return NO;
        }
    }
    else{
        //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
        if(![idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]) {
            return NO;
        }
    }
    return YES;
}

#pragma mark 检验银行卡号
+ (BOOL)gg_IsBankCard:(NSString *)cardNumber
{
    /// 这里不过多校验了
    return cardNumber.length;
//    if (!cardNumber || cardNumber.length < 13 || cardNumber.length > 19) {
//        return NO;
//    }
//    
//    NSCharacterSet *nonDigitSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
//    if ([cardNumber rangeOfCharacterFromSet:nonDigitSet].location != NSNotFound) {
//        return NO;
//    }
//    
//    NSInteger sum = 0;
//    BOOL isEven = (cardNumber.length % 2 == 0);
//    
//    for (NSInteger i = 0; i < cardNumber.length; i++) {
//        unichar c = [cardNumber characterAtIndex:i];
//        if (!isdigit(c)) return NO;
//        NSInteger digit = c - '0';
//        
//        if ((isEven && i % 2 == 0) || (!isEven && i % 2 == 1)) {
//            digit *= 2;
//            if (digit > 9) digit -= 9;
//        }
//        sum += digit;
//    }
//    
//    return (sum % 10 == 0);
}

#pragma mark 密码是否正确
+ (BOOL)gg_checkIsRightPassword:(NSString *)password
{
    if (password.length < 8 || password.length > 16)//密码位数在8~16之间
    {
        NSLog(@"密码长度小于8位或大于16位");
        return NO;
    }
    else
    {
        NSCharacterSet *numSet = [NSCharacterSet decimalDigitCharacterSet];
        NSCharacterSet *lowerSet = [NSCharacterSet lowercaseLetterCharacterSet];
        NSCharacterSet *upperSet = [NSCharacterSet uppercaseLetterCharacterSet];

        BOOL hasNum = ([password rangeOfCharacterFromSet:numSet].location != NSNotFound);
        BOOL hasLower = ([password rangeOfCharacterFromSet:lowerSet].location != NSNotFound);
        BOOL hasUpper = ([password rangeOfCharacterFromSet:upperSet].location != NSNotFound);

        if (password.length >= 8 && password.length <= 16 && hasNum && hasLower && hasUpper) {
            return YES;
        }
        return NO;
    }
}

+ (BOOL)gg_isValidMoney:(NSString *)text {
    if (text.length == 0) return YES; // 空时视为“未完成输入”，合法（由 UI 决定是否禁用提交）
    
    NSString *regex = @"^\\d+(\\.\\d{1,2})?$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:text];
}

+ (BOOL)gg_isDigitString:(NSString *)str {
    for (NSUInteger i = 0; i < str.length; i++) {
        if (!isdigit([str characterAtIndex:i])) return NO;
    }
    return YES;
}

+ (BOOL)gg_isMoneyString:(NSString *)str {
    BOOL isDigit = [self gg_isDigitString:str];
    
    BOOL isPoint = [str isEqual:@"."];
    
    return isDigit || isPoint;
}

+ (BOOL)gg_isValidIDCardChar:(NSString *)str {
    for (NSUInteger i = 0; i < str.length; i++) {
        unichar c = [str characterAtIndex:i];
        if (!(isdigit(c) || c == 'x' || c == 'X')) return NO;
    }
    return YES;
}

//#pragma mark - 表情符号判断
////表情符号的判断
//+ (BOOL)gg_checkStringContainsEmoji:(NSString *)string {
//    
//    __block BOOL returnValue = NO;
//    
////    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
////                               options:NSStringEnumerationByComposedCharacterSequences
////                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
////                                const unichar hs = [substring characterAtIndex:0];
////                                if (0xd800 <= hs && hs <= 0xdbff) {
////                                    if (substring.length > 1) {
////                                        const unichar ls = [substring characterAtIndex:1];
////                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
////                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
////                                            returnValue = YES;
////                                        }
////                                    }
////                                } else if (substring.length > 1) {
////                                    const unichar ls = [substring characterAtIndex:1];
////                                    if (ls == 0x20e3) {
////                                        returnValue = YES;
////                                    }
////                                } else {
////                                    if (0x2100 <= hs && hs <= 0x27ff) {
////                                        returnValue = YES;
////                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
////                                        returnValue = YES;
////                                    } else if (0x2934 <= hs && hs <= 0x2935) {
////                                        returnValue = YES;
////                                    } else if (0x3297 <= hs && hs <= 0x3299) {
////                                        returnValue = YES;
////                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
////                                        returnValue = YES;
////                                    }
////                                }
////                            }];
//    
//    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
//    const unichar hs = [substring characterAtIndex:0];
//
//    // surrogate pair
//
//    if (0xd800 <= hs && hs <= 0xdbff) {
//    if (substring.length > 1) {
//    const unichar ls = [substring characterAtIndex:1];
//
//    const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
//
//    if (0x1d000 <= uc && uc <= 0x1f77f) {
//    returnValue = YES;
//
//    }
//
//    }
//
//    } else if (substring.length > 1) {
//    const unichar ls = [substring characterAtIndex:1];
//
//    if (ls == 0x20e3) {
//    returnValue = YES;
//
//    }
//
//    } else {
//    // non surrogate
//
//    if (0x2100 <= hs && hs <= 0x27ff) {
//    returnValue = YES;
//
//    } else if (0x2B05 <= hs && hs <= 0x2b07) {
//    returnValue = YES;
//
//    } else if (0x2934 <= hs && hs <= 0x2935) {
//    returnValue = YES;
//
//    } else if (0x3297 <= hs && hs <= 0x3299) {
//    returnValue = YES;
//
//    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
//    returnValue = YES;
//
//    }
//
//    }
//
//    }];
//    
//    return returnValue;
//}

@end
