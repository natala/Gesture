//
//  CMD18_AddTimerTask.h
//  NewProtocol
//
//  Created by chendy on 13-9-13.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ClientCommand.h"
#import "TimerTask.h"
#import "Device.h"

///客户端发送添加单个定时任务指令
@interface CMD18_AddTimerTask : ClientCommand

///任务信息
@property(nonatomic,strong) TimerTask* schedinfo;

///设备信息
@property(nonatomic,strong) Device* ctrlinfo;

-(id)initWithSchedinfo:(TimerTask*)schedinfo Ctrlinfo:(Device*)ctrlinfo;

@end
