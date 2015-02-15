//
//  CMDHelper.h
//  ClientProtocol
//
//  Created by chendy on 13-9-15.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServerCommand.h"
#import "ClientCommand.h"

//通知接收到指令
#define kReceiveCMD @"kReceiveCMD"
//通知socket连接成功
#define kSocketConnect @"kSocketConnect"
//通知socket断开
#define kSocketClose @"socketClosed"
//通知socket发送数据成功
#define kSocketWriteSucc @"kSocketWriteSucc"

@protocol CMDHelperDelegate<NSObject>

@optional
//socket连接成功
-(void)socketConnected;
//socket断开
-(void)socketClosed;
//接收到信息
-(void)receiveCMD:(ServerCommand*)cmd;
//发送数据成功
-(void)socketWriteSucc;
@end


@interface CMDHelper : NSObject

//ip
@property(nonatomic,strong,readonly) NSString* ip;

//端口
@property(nonatomic,assign,readonly) int port;

//代理
@property(nonatomic,weak) id<CMDHelperDelegate> delegate;

//设置服务器的IP和端口，并连接到服务器
+(id)setupConnectionWithIp:(NSString*)ip Port:(int)port;

//设置服务器的IP和端口及超时时间，并连接到服务器
+(id)setupConnectionWithIp:(NSString*)ip Port:(int)port withTimeOut:(NSTimeInterval)timeout;

//得取实例
+(id)shareInstance;

//判断网络是否连接
-(BOOL)isConnected;
//建立连接
-(NSError *)connect;
//建立连接,带超时
-(NSError *)connect:(NSTimeInterval)timeout;
//关闭连接
-(void)close;
//发送命令
-(void)sendCMD:(ClientCommand*)cmd;

@end
