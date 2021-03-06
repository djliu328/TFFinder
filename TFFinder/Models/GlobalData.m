//
//  GlobalData.m
//  TFFinder
//
//  Created by teanfoo on 16/12/16.
//  Copyright © 2016 TeanFoo. All rights reserved.
//

#import "GlobalData.h"

static GlobalData *instance;

@implementation GlobalData

// 获取单例
+ (instancetype)Data {
    if (instance == nil) {
        instance = [[self alloc] init];
    }
    return instance;
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    if (instance == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            instance = [super allocWithZone:zone];
        });
    }
    return instance;
}
- (instancetype)copyWithZone:(struct _NSZone *)zone {
    return self;
}
// 非ARC环境 有效
#if !__has_feature(objc_arc)
-(id)retain{return self;}
-(unsigned)retainCount{return 1;}
-(void)release{}
-(id)autorelease{return self;}
-(void)dealloc{[super dealloc];}
#endif

#pragma mark - 保存数据
- (void)saveData {
    NSUserDefaults *ROM = [NSUserDefaults standardUserDefaults];
    
    [ROM setObject:self.serverIP forKey:k_SERVER_IP_KEY];
    [ROM setObject:self.serverPort forKey:k_SERVER_PORT_KEY];
    [ROM setObject:self.serverPath forKey:k_SERVER_PATH_KEY];
}

#pragma mark - 懒加载初始属性值
- (NSUInteger)encode {
    if (_encode == 0) {
        // 设置默认的编码方式
        _encode = NSUTF8StringEncoding;
    }
    return _encode;
}
- (NSString *)serverIP {
    if (_serverIP == nil) {
        NSString *ROM_SEVER_IP = [[NSUserDefaults standardUserDefaults] objectForKey:k_SERVER_IP_KEY];
        if (ROM_SEVER_IP == nil) _serverIP = @"";
        else _serverIP = ROM_SEVER_IP;
    }
    return _serverIP;
}
- (NSString *)serverPort {
    if (_serverPort == nil) {
        NSString *ROM_SEVER_PORT = [[NSUserDefaults standardUserDefaults] objectForKey:k_SERVER_PORT_KEY];
        if (ROM_SEVER_PORT == nil) _serverPort = @"";
        else _serverPort = ROM_SEVER_PORT;
    }
    return _serverPort;
}
- (NSString *)serverPath {
    if (_serverPath == nil) {
        NSString *ROM_SEVER_PATH = [[NSUserDefaults standardUserDefaults] objectForKey:k_SERVER_PATH_KEY];
        if (ROM_SEVER_PATH == nil) _serverPath = @"";
        else _serverPath = ROM_SEVER_PATH;
    }
    return _serverPath;
}

@end
