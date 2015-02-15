//
//  CMD2B_ServerSortNormalDeviceResult.h
//  NewProtocol
//
//  Created by chendy on 13-9-14.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ServerCommand.h"

///服务器返回修改常用设备排序结果
@interface CMD2B_ServerSortNormalDeviceResult : ServerCommand

///是否成功
@property(nonatomic,assign) BOOL result;

///常用设备列表
@property(nonatomic,strong) NSArray* devices;

-(id)initWithResult:(BOOL)result Devices:(NSArray*) devices;

@end
