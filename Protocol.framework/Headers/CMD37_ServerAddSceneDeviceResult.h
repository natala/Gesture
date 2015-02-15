//
//  CMD37_ServerAddSceneDeviceResult.h
//  NewProtocol
//
//  Created by chendy on 13-9-14.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ServerCommand.h"
#import "SceneDevice.h"
#import "Device.h"

///服务器返回添加情景设备结果
@interface CMD37_ServerAddSceneDeviceResult : ServerCommand

///是否成功
@property(nonatomic,assign) BOOL result;

///情景设备
@property(nonatomic,strong) SceneDevice* scenedev;

///设备信息
@property(nonatomic,strong) Device* ctrlinfo;

-(id)initWithResult:(BOOL)result Scenedev:(SceneDevice*)scenedev Ctrlinfo:(Device*)ctrlinfo;

@end
