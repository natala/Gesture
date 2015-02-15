//
//  CMD78_ServerDelGroupSucc.h
//  ClientProtocol
//
//  Created by chendy on 13-12-12.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ServerCommand.h"

///服务器返回删除设备组成功
@interface CMD78_ServerDelGroupSucc : ServerCommand

///组号
@property(nonatomic,strong) NSString<expose>* groupId;

-(id)initWithGroupId:(NSString*)groupId;

@end
