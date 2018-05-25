//
//  FKLog.h
//  FKLogger
//
//  Created by FlyKite on 2018/5/25.
//  Copyright © 2018年 Doge Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, FKLogLevel) {
    FKLogLevelVerbose,
    FKLogLevelDebug,
    FKLogLevelInfo,
    FKLogLevelWarning,
    FKLogLevelError
};

@interface FKLog : NSObject

+ (instancetype)logWithFilename:(NSString *)fileName
                     lineNumber:(NSInteger)lineNumber
                   functionName:(NSString *)functionName
                       logLevel:(FKLogLevel)level
                     logContent:(NSString *)logContent;

@property (readonly, strong) NSDate *currentDate;

@property (readonly, copy) NSString *fileName;

@property (readonly, copy) NSString *functionName;

@property (readonly) NSInteger lineNumber;

@property (readonly) FKLogLevel logLevel;

@property (readonly) NSString *logHeader;

@property (readonly, copy) NSString *logContent;

@end
