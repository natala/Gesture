//
//  NormalDevice.h
//  NewProtocol
//
//  Created by chendy on 13-9-9.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "JSONObject.h"

@protocol NormalDevice

@end

// 常用设备信息
@interface NormalDevice : JSONObject

//设备id
@property(nonatomic,strong) NSString* devid;

//厂商识别代码
@property(nonatomic,assign) int order;

-(id)initWithDevid:(NSString*)devid_ Order:(int)order_;

@end
