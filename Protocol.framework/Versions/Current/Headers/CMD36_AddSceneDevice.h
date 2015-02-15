//
//  CMD36_AddSceneDevice.h
//  NewProtocol
//
//  Created by chendy on 13-9-14.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ClientCommand.h"
#import "SceneDevice.h"
#import "Device.h"

///客户端发送添加单个情景设备指令
@interface CMD36_AddSceneDevice : ClientCommand

///情景设备
@property(nonatomic,strong) SceneDevice* scenedev;

///设备信息
@property(nonatomic,strong) Device* ctrlinfo;

-(id)initWithScenedev:(SceneDevice*)scenedev Ctrlinfo:(Device*)ctrlinfo;

@end
