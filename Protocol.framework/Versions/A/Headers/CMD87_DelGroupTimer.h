//
//  CMD87_DelGroupTimer.h
//  ClientProtocol
//
//  Created by chendy on 13-12-13.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ClientCommand.h"

///客户端发删除组定时器给服务器(删除组定时器)
@interface CMD87_DelGroupTimer : ClientCommand

///组号
@property(nonatomic,strong) NSString<expose>* groupId;

///计划任务id
@property(nonatomic,strong) NSString<expose>* schedid;

-(id)initWithGroupId:(NSString*)groupId Schedid:(NSString*)schedid;

@end
