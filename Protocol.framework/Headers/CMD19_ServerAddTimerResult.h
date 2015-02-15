//
//  CMD19_ServerAddTimerResult.h
//  NewProtocol
//
//  Created by chendy on 13-9-13.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ServerCommand.h"
#import "TimerTask.h"
#import "Device.h"

///服务器返回添加定时任务结果
@interface CMD19_ServerAddTimerResult : ServerCommand

///操作结果
@property(nonatomic,assign) BOOL result;

///任务信息
@property(nonatomic,strong) TimerTask* schedinfo;

///设备信息
@property(nonatomic,strong) Device* ctrlinfo;

-(id)initWithResult:(BOOL)result Schedinfo:(TimerTask*)schedinfo Ctrlinfo:(Device*)ctrlinfo;

@end
