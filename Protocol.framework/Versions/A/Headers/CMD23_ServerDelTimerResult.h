//
//  CMD23_ServerDelTimerResult.h
//  NewProtocol
//
//  Created by chendy on 13-9-13.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ServerCommand.h"
#import "TimerTask.h"

///服务器返回删除定时任务结果
@interface CMD23_ServerDelTimerResult : ServerCommand

///操作结果
@property(nonatomic,assign) BOOL result;

///定时任务信息
@property(nonatomic,strong) TimerTask* schedinfo;

-(id)initWithResult:(BOOL)result Schedinfo:(TimerTask*)schedinfo;

@end
