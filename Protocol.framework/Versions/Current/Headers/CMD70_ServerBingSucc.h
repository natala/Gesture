//
//  CMD72_ServerBingSucc.h
//  ClientProtocol
//
//  Created by chendy on 13-10-12.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ServerCommand.h"

///服务器返回绑定红外按钮指令成功(配对第三步)
@interface CMD70_ServerBingSucc : ServerCommand

///SN
@property(nonatomic,strong) NSString<expose>* sn;

///红外按键1~9
@property(nonatomic,strong) NSNumber<expose>* button;

-(id)initWithSN:(NSString*)sn Button:(int)button;

@end
