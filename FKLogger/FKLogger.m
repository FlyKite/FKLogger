//
//  FKLogger.m
//  FKLogger
//
//  Created by FlyKite on 2018/5/24.
//  Copyright © 2018年 Doge Studio. All rights reserved.
//

#import "FKLogger.h"

#define ArgList(firstItem)\
va_list argList;\
va_start(argList, firstItem);

@interface FKLogger() {
    NSMutableSet<id<FKLoggerHandler>> *_handlers;
    NSSet<id<FKLoggerHandler>> *_copyHandlers;
}
- (void)handleLog:(FKLog *)log;
@end

void fkUncaughtExceptionHandler(NSException *exception) {
    NSArray *stackArray = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name = [exception name];
    
    NSString *outputFormat = @"*** Terminating app due to uncaught exception '%@', reason: '%@'\n*** First throw call stack:\n%@";
    NSString *exceptionInfo = [NSString stringWithFormat:outputFormat, name, reason, stackArray];
    
    FKLog *log = [FKLog logWithFilename:@"UncaughtExceptionHandler"
                             lineNumber:0
                           functionName:@""
                               logLevel:FKLogLevelError
                             logContent:exceptionInfo];
    [[FKLogger sharedLogger] handleLog:log];
}

@implementation FKLogger

+ (instancetype)sharedLogger {
    static FKLogger *logger;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        logger = [[super allocWithZone:NULL] init];
    });
    return logger;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    return [FKLogger sharedLogger];
}

- (id)copyWithZone:(struct _NSZone *)zone {
    return [FKLogger sharedLogger];
}

- (instancetype)init {
    if (self = [super init]) {
#if DEBUG
        _enabled = YES;
#else
        _enabled = NO;
#endif
        _handlers = [NSMutableSet setWithCapacity:5];
        _configuration = [[FKLoggerConfiguration alloc] init];
    }
    return self;
}

- (void)addLogHandler:(id<FKLoggerHandler>)handler {
    [_handlers addObject:handler];
    _copyHandlers = [_handlers copy];
}

- (void)removeLogHandler:(id<FKLoggerHandler>)handler {
    [_handlers removeObject:handler];
    _copyHandlers = [_handlers copy];
}

- (NSSet<id<FKLoggerHandler>> *)handlers {
    return _copyHandlers;
}

- (void)logFilename:(const char *)file
         lineNumber:(int)line
       functionName:(const char *)func
           logLevel:(FKLogLevel)level
          logFormat:(NSString *)format, ... {
    
    if (!self.enabled) {
        return;
    }
    
    // File name
    NSString *fileName = [NSString stringWithUTF8String:file];
    NSRange range = [fileName rangeOfString:@"/" options:NSBackwardsSearch];
    if (range.location != NSNotFound) {
        fileName = [fileName substringFromIndex:range.location + 1];
    }
    
    // Function name
    NSString *functionName = [NSString stringWithUTF8String:func];
    
    // Content
    ArgList(format);
    NSString *content = [[NSString alloc] initWithFormat:format arguments:argList];
    
    // Generate FKLog
    FKLog *log = [FKLog logWithFilename:fileName
                             lineNumber:line
                           functionName:functionName
                               logLevel:level
                             logContent:content];
    
    [self printLog:log];
}

- (void)printLog:(FKLog *)log {
    if (!self.enabled) {
        return;
    }
    if (log.logLevel < self.configuration.minimumLogLevel) {
        return;
    }
    
    NSString *description = [NSString stringWithFormat:@"%@%@", [self prefixOfLevel:log.logLevel], log.description];
    printf("%s\n", [description cStringUsingEncoding:NSUTF8StringEncoding]);
    [self handleLog:log];
}

- (NSString *)prefixOfLevel:(FKLogLevel)level {
    if (!self.configuration.printsLogPrefix) {
        return @"";
    }
    switch (level) {
        case FKLogLevelVerbose: return self.configuration.verbosePrefix;
        case FKLogLevelDebug:   return self.configuration.debugPrefix;
        case FKLogLevelInfo:    return self.configuration.infoPrefix;
        case FKLogLevelWarning: return self.configuration.warningPrefix;
        case FKLogLevelError:   return self.configuration.errorPrefix;
        default: return @"";
    }
}

- (void)handleLog:(FKLog *)log {
    [_handlers enumerateObjectsUsingBlock:^(id<FKLoggerHandler>  _Nonnull handler, BOOL * _Nonnull stop) {
        [handler handleLog:log];
    }];
}

@end
