//
//  FKLoggerConfiguration.m
//  FKLogger
//
//  Created by FlyKite on 2018/5/25.
//  Copyright © 2018年 Doge Studio. All rights reserved.
//

#import "FKLoggerConfiguration.h"

@implementation FKLoggerConfiguration

- (instancetype)init
{
    if (self = [super init]) {
#if DEBUG
        _minimumLogLevel = FKLogLevelVerbose;
#else
        _minimumLogLevel = FKLogLevelError;
#endif
        _printsLogPrefix = YES;
        _verbosePrefix = @"✉️";
        _debugPrefix = @"🌐";
        _infoPrefix = @"📟";
        _warningPrefix = @"⚠️";
        _errorPrefix = @"❌";
    }
    return self;
}

@end
