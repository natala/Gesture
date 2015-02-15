//
//  Device.h
//  NewProtocol
//
//  Created by chendy on 13-9-14.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONObject.h"

@protocol Device

@end

//设备类，所有的设备类都继承此类
@interface Device : JSONObject

//类型[Integer]
@property(nonatomic,assign) int type;

//String[原类型7bytes数组]
@property(nonatomic,strong) NSString* id;

//String[父设备id,原类型7bytes数组]
@property(nonatomic,strong) NSString* pid;

//设备名称
@property(nonatomic,strong) NSString* name;

//设备摆放位置
@property(nonatomic,strong) NSString* place;

//版本[Integer]
@property(nonatomic,assign) int version;

//是否在线[Boolean]
@property(nonatomic,assign) BOOL onLine;

@end
