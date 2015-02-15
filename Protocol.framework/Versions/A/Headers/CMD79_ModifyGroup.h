//
//  CMD79_ModifyGroup.h
//  ClientProtocol
//
//  Created by chendy on 13-12-12.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ClientCommand.h"

///客户端发送修改设备组给服务器(添加组)
@interface CMD79_ModifyGroup : ClientCommand

///组号
@property(nonatomic,strong) NSString<expose>* groupId;

///组名
@property(nonatomic,strong) NSString<expose>* groupName;

-(id)initWithGroupId:(NSString*)groupId GroupName:(NSString*)groupName;

@end
