//
//  CMD86_ServerAddGroupTimerSucc.h
//  ClientProtocol
//
//  Created by chendy on 13-12-13.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ServerCommand.h"
#import "TimerTask.h"
#import "Device.h"

///服务器返回添加组定时器成功
@interface CMD86_ServerAddGroupTimerSucc : ServerCommand

///组号
@property(nonatomic,strong) NSString* groupId;

///定时信息
@property(nonatomic,strong) TimerTask* schedinfo;

///设备信息
@property(nonatomic,strong) Device* ctrlinfo;

-(id)initWithGroupId:(NSString*)groupId Schedinfo:(TimerTask*)schedinfo Ctrlinfo:(Device*)ctrlinfo;

@end
