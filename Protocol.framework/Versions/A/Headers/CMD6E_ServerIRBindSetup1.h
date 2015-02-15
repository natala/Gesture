//
//  CMD70_ServerIRBindSetup1.h
//  ClientProtocol
//
//  Created by chendy on 13-10-12.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ServerCommand.h"

///服务器返回配原有设备端的红外按钮已按下(配对第一步)
@interface CMD6E_ServerIRBindSetup1 : ServerCommand

///SN
@property(nonatomic,strong) NSString<expose>* sn;

-(id)initWithSN:(NSString*)sn;

@end
