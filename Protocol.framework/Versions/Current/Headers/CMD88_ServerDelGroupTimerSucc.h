//
//  CMD88_ServerDelGroupTimerSucc.h
//  ClientProtocol
//
//  Created by chendy on 13-12-13.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ServerCommand.h"

///服务器返回删除组定时器成功
@interface CMD88_ServerDelGroupTimerSucc : ServerCommand

///组号
@property(nonatomic,strong) NSString<expose>* groupId;

///计划任务id
@property(nonatomic,strong) NSString<expose>* schedid;

-(id)initWithGroupId:(NSString*)groupId Schedid:(NSString*)schedid;

@end
