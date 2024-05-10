//
//  TYLocalizedTool.m
//  will
//
//  Created by 王永刚 on 2023/7/5.
//  Copyright © 2023 maitang. All rights reserved.
//

#import "TYLocalizedTool.h"

@implementation TYLocalizedTool

+ (BOOL)TYIsRTL {
    NSLocale *locale = [NSLocale currentLocale];
    NSString *languageCode = [locale languageCode];
    if (!languageCode) {
        return NO;
    }
    
    NSLocaleLanguageDirection characterDirection = [NSLocale characterDirectionForLanguage:languageCode];
    return characterDirection == NSLocaleLanguageDirectionRightToLeft;
}

@end
