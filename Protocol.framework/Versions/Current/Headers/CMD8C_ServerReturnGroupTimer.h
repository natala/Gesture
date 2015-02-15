//
//  CMD8C_ServerReturnGroupTimer.h
//  ClientProtocol
//
//  Created by chendy on 13-12-13.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ServerCommand.h"

///服务器返回组中所有的定时器
@interface CMD8C_ServerReturnGroupTimer : ServerCommand

///组号
@property(nonatomic,strong) NSString* groupId;

///定时信息列表(TimerInfo的List)
@property(nonatomic,strong) NSArray* timerList;

-(id)initWithGroupId:(NSString*)groupId TimerList:(NSArray*)timerList;

@end
