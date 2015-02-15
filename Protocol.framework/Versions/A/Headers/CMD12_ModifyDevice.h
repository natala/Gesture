//
//  CMD12_ModifyDevice.h
//  NewProtocol
//
//  Created by chendy on 13-9-12.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ClientCommand.h"

///客户端发送修改某个设备信息指令
@interface CMD12_ModifyDevice : ClientCommand

///设备id
@property(nonatomic,strong) NSString* devid;

///名称
@property(nonatomic,strong) NSString* name;

///设备摆放位置
@property(nonatomic,strong) NSString* place;

-(id)initWithDevid:(NSString*)devid Name:(NSString*)name Place:(NSString*)place;

@end
