//
//  main.m
//  FKLoggerDemo
//
//  Created by 风筝 on 2018/5/25.
//  Copyright © 2018年 Doge Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FKLogger.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // verbose
        FKLogV(@"This is a verbose log.");
        // debug
        FKLogD(@"This is a debug log.");
        // info
        FKLogI(@"This is an info log.");
        // warning
        FKLogW(@"This is a warning log.");
        // error
        FKLogE(@"This is an error log.");
        // Enable uncaught exeption handler
        NSSetUncaughtExceptionHandler(&fkUncaughtExceptionHandler);
        // Make a crash
        NSArray *array = @[@1, @2, @3];
        NSLog(@"%@", array[3]);
    }
    return 0;
}
