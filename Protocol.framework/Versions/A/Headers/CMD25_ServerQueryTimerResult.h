//
//  CMD25_ServerQueryTimerResult.h
//  NewProtocol
//
//  Created by chendy on 13-9-13.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ServerCommand.h"
#import "TimerInfo.h"

///服务器返回查询某个设备定时任务等指令
@interface CMD25_ServerQueryTimerResult : ServerCommand

///设备id
@property(nonatomic,strong) NSString* devid;

///定时任务列表
@property(nonatomic,strong) NSArray<TimerInfo>* timerList;

-(id)initWithDevid:(NSString*)devid TimerList:(NSArray*)timerList;

@end
