//
//  CMD2A_SortNormalDevice.h
//  NewProtocol
//
//  Created by chendy on 13-9-14.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ClientCommand.h"

///客户端发送修改常用设备排序指令
@interface CMD2A_SortNormalDevice : ClientCommand

///常用设备列表
@property(nonatomic,strong) NSArray* devices;

-(id)initWithDevices:(NSArray*)devices;

@end
