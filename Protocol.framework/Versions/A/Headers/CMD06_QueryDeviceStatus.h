//
//  CMD06_QueryDeviceStatus.h
//  NewProtocol
//
//  Created by chendy on 13-9-11.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ClientCommand.h"

///客户端查询单个设备状态
@interface CMD06_QueryDeviceStatus : ClientCommand

///设备id
@property(nonatomic,strong) NSString* devid;

-(id)initWithDevid:(NSString*)devid;

@end
