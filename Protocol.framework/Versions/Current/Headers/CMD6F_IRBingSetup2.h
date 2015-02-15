//
//  CMD71_IRBingSetup2.h
//  ClientProtocol
//
//  Created by chendy on 13-10-12.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ClientCommand.h"

///客户端发送绑定红外按键指令(配对第二步)
@interface CMD6F_IRBingSetup2 : ClientCommand

///SN
@property(nonatomic,strong) NSString<expose>* sn;

///红外按键1~9
@property(nonatomic,strong) NSNumber<expose>* button;

-(id)initWithSN:(NSString*)sn Button:(int)button;

@end
