#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "GGTextField.h"
#import "GGTextFieldDelegateProxy.h"
#import "NSString+GGTextField.h"

FOUNDATION_EXPORT double GGTextFieldVersionNumber;
FOUNDATION_EXPORT const unsigned char GGTextFieldVersionString[];

