//
//  YSLDevice.h
//  ClientProtocol
//
//  Created by chendy on 13-10-29.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "Device.h"

//设备信息（以色列设备，wifi设备)
@interface YSLDevice : Device

-(id)initWithId:(NSString*)id_ Pid:(NSString*)pid Name:(NSString*)name Place:(NSString*)place Online:(BOOL)onLine;

@end
