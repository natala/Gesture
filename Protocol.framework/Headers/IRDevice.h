//
//  IRDevice.h
//  ClientProtocol
//
//  Created by chendy on 13-10-15.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "Device.h"
#import "Power.h"

//设备信息（红外）
@interface IRDevice : Device

//电源状态,多路
@property(nonatomic,strong) NSArray<Power,ConvertOnDemand>* power;

//模式，1红外学习模式 0正常模式
@property(nonatomic,strong) NSString* mode;

//button值
@property(nonatomic,strong) NSString* key;

//设置第一路开关的状态
-(void)setOneWayPower:(BOOL)on;

//获得第一路开关的状态
-(BOOL)getOneWayPower;

-(id)initWithId:(NSString*)id_ Pid:(NSString*)pid Name:(NSString*)name Place:(NSString*)place Online:(BOOL)onLine Power:(NSArray*)powers Mode:(NSString*)mode Key:(NSString*)key;

-(id)initWithMode:(NSString*)mode Key:(NSString*)key;

@end
