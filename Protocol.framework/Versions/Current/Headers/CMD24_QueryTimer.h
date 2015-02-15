//
//  CMD24_QueryTimer.h
//  NewProtocol
//
//  Created by chendy on 13-9-13.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ClientCommand.h"

///客户端发送查询某个设备所有定时任务指令
@interface CMD24_QueryTimer : ClientCommand

///设备id
@property(nonatomic,strong) NSString* devid;

-(id)initWithDevid:(NSString*)devid;

@end
