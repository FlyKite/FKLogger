//
//  FKLog.m
//  FKLogger
//
//  Created by FlyKite on 2018/5/25.
//  Copyright © 2018年 Doge Studio. All rights reserved.
//

#import "FKLog.h"

@interface FKLog() {
    NSString *_description;
}
@end

@implementation FKLog

+ (instancetype)logWithFilename:(NSString *)fileName
                     lineNumber:(NSInteger)lineNumber
                   functionName:(NSString *)functionName
                       logLevel:(FKLogLevel)level
                     logContent:(NSString *)logContent {
    
    return [[FKLog alloc] initWithFileName:fileName
                                lineNumber:lineNumber
                              functionName:functionName
                                  logLevel:level
                                logContent:logContent];
}

+ (NSDateFormatter *)sharedDateFormatter {
    static NSDateFormatter *formatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss.SSS";
    });
    return formatter;
}

- (instancetype)initWithFileName:(NSString *)fileName
                      lineNumber:(NSInteger)lineNumber
                    functionName:(NSString *)functionName
                        logLevel:(FKLogLevel)level
                      logContent:(NSString *)logContent {
    
    if (self = [super init]) {
        _currentDate = [NSDate date];
        _fileName = fileName;
        _lineNumber = lineNumber;
        _functionName = functionName;
        _logLevel = level;
        _logContent = logContent;
        [self generateLogHeader];
        [self generateDescription];
    }
    return self;
}

- (void)generateLogHeader {
    
    // current date
    NSString *date = [[FKLog sharedDateFormatter] stringFromDate:self.currentDate];
    
    NSString *logHeader = [NSString stringWithFormat:@"%@ %@ (%@) [line %d]:", date, self.fileName, self.functionName, (int)self.lineNumber];
    
    _logHeader = logHeader;
}

- (void)generateDescription {
    _description = [NSString stringWithFormat:@"%@\n%@", _logHeader, _logContent];
}

- (NSString *)description {
    return _description;
}

@end
