//
//  FKLogger.h
//  FKLogger
//
//  Created by FlyKite on 2018/5/24.
//  Copyright © 2018年 Doge Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FKLog.h"
#import "FKLoggerConfiguration.h"

#define FKLogV(format, ...) [[FKLogger sharedLogger] logFilename:__FILE__ lineNumber:__LINE__ functionName:__func__ logLevel:FKLogLevelVerbose logFormat:format, ##__VA_ARGS__]
#define FKLogD(format, ...) [[FKLogger sharedLogger] logFilename:__FILE__ lineNumber:__LINE__ functionName:__func__ logLevel:FKLogLevelDebug logFormat:format, ##__VA_ARGS__]
#define FKLogI(format, ...) [[FKLogger sharedLogger] logFilename:__FILE__ lineNumber:__LINE__ functionName:__func__ logLevel:FKLogLevelInfo logFormat:format, ##__VA_ARGS__]
#define FKLogW(format, ...) [[FKLogger sharedLogger] logFilename:__FILE__ lineNumber:__LINE__ functionName:__func__ logLevel:FKLogLevelWarning logFormat:format, ##__VA_ARGS__]
#define FKLogE(format, ...) [[FKLogger sharedLogger] logFilename:__FILE__ lineNumber:__LINE__ functionName:__func__ logLevel:FKLogLevelError logFormat:format, ##__VA_ARGS__]

/**
 A simple UncaughtExceptionHandler to catch uncaught exception and log to FKLogger
 Uncaught exeption won't be printed in console of XCode, because XCode will print it automatically
 Use `NSSetUncaughtExceptionHandler(&fkUncaughtExceptionHandler);` to enable this handler
 */
void fkUncaughtExceptionHandler(NSException *exception);

@protocol FKLoggerHandler
- (void)handleLog:(FKLog *)log;
@end

@interface FKLogger : NSObject

+ (instancetype)sharedLogger;

/**
 Enable log output, defaults to YES(Debut)/NO(Release).
 */
@property (assign) BOOL isEnabled;

/**
 Configurations of FKLogger. (eg. minimumLogLevel)
 */
@property (readonly, strong) FKLoggerConfiguration *configuration;

@property (readonly, copy) NSSet<id<FKLoggerHandler>> *handlers;

/**
 Add a new log handler.

 @param handler A new log handler
 */
- (void)addLogHandler:(nonnull id<FKLoggerHandler>)handler;

/**
 Remove an existed log handler.

 @param handler an existed log handler
 */
- (void)removeLogHandler:(nonnull id<FKLoggerHandler>)handler;

/**
 Create FKLog object and output this log.

 @param file file path
 @param line number of line in file
 @param func function name
 @param level log level
 @param format format of NSString
 */
- (void)logFilename:(const char *)file
         lineNumber:(int)line
       functionName:(const char *)func
           logLevel:(FKLogLevel)level
          logFormat:(NSString *)format, ...;

/**
 Print log in console of XCode and other log handlers.

 @param log a FKLog object
 */
- (void)printLog:(FKLog *)log;

@end
