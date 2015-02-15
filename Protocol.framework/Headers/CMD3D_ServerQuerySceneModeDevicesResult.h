//
//  CMD3D_ServerQuerySceneModeDevicesResult.h
//  NewProtocol
//
//  Created by chendy on 13-9-14.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ServerCommand.h"

///服务器返回查询情景设备指令
@interface CMD3D_ServerQuerySceneModeDevicesResult : ServerCommand

///情景设备列表
@property(nonatomic,strong) NSArray* sceneDevices;

-(id)initWithSceneDevices:(NSArray*)sceneDevices;

@end
