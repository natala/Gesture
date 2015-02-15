//
//  SNDeviceTypeObject.h
//  ClientProtocol
//
//  Created by chendy on 13-12-13.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "JSONObject.h"

@protocol SNDeviceTypeObject

@end

///下挂设备类型对象，用于唯一确定下挂设备的类型
@interface SNDeviceTypeObject : JSONObject

///下挂设备所属的wifi设备的主类型
@property(nonatomic,assign) int deviceType;

///下挂设备在所属wifi设备中的子类型
@property(nonatomic,assign) int subType;

-(id)initWithDeviceType:(int)deviceType SubType:(int)subType;

@end
