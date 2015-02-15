//
//  CMD22_DelTimer.h
//  NewProtocol
//
//  Created by chendy on 13-9-13.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ClientCommand.h"

///客户端发送删除单个定时任务指令
@interface CMD22_DelTimer : ClientCommand

///计划任务的guid
@property(nonatomic,strong) NSString* schedid;

-(id)initWithSchedid:(NSString*)schedid;

@end
