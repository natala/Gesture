//
//  SceneDeviceInfo.h
//  NewProtocol
//
//  Created by chendy on 13-9-10.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "JSONObject.h"
#import "SceneDevice.h"
#import "Device.h"

//情景设备信息，包含情景设备和设备信息
@interface SceneDeviceInfo : JSONObject

//情景设备
@property(nonatomic,strong) SceneDevice* scenedev;

//设备信息
@property(nonatomic,strong) Device* ctrlinfo;

-(id)initWithSceneDev:(SceneDevice*)scenedev_ CtrlInfo:(Device*)ctrlinfo_;

@end
