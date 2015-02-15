//
//  CMD77_DelGroup.h
//  ClientProtocol
//
//  Created by chendy on 13-12-12.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ClientCommand.h"

///客户端发送删除设备组给服务器(删除组)
@interface CMD77_DelGroup : ClientCommand

///组号
@property(nonatomic,strong) NSString<expose>* groupId;

-(id)initWithGroupId:(NSString*)groupId;

@end
