//
//  FKLoggerConfiguration.h
//  FKLogger
//
//  Created by FlyKite on 2018/5/25.
//  Copyright © 2018年 Doge Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FKLog.h"

@interface FKLoggerConfiguration : NSObject

/**
 The minimun log level, logs below this level will not be printed.
 Defaults to FKLogLevelVerbose(Debug) and FKLogLevelError(Release).
 */
@property (assign) FKLogLevel minimumLogLevel;

/**
 This value determines whether to print a prefix for logs, defaults to YES.
 */
@property (assign) BOOL printsLogPrefix;

/**
 Prefix in console(XCode) of FKLogLevelVerbose, defaults to Emoji ✉️
 */
@property (copy) NSString *verbosePrefix;

/**
 Prefix in console(XCode) of FKLogLevelDebug, defaults to Emoji 🌐
 */
@property (copy) NSString *debugPrefix;

/**
 Prefix in console(XCode) of FKLogLevelInfo, defaults to Emoji 📟
 */
@property (copy) NSString *infoPrefix;

/**
 Prefix in console(XCode) of FKLogLevelWarning, defaults to Emoji ⚠️
 */
@property (copy) NSString *warningPrefix;

/**
 Prefix in console(XCode) of FKLogLevelError, defaults to Emoji ❌
 */
@property (copy) NSString *errorPrefix;

@end
