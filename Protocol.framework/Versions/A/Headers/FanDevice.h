//
//  FanDevice.h
//  ClientProtocol
//
//  Created by chendy on 13-10-23.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "Device.h"

typedef enum {
    //低速
    SPEED_LOW = 0,
    //中速
    SPEED_MID = 1,
    //高速
    SPEED_HI = 2,
}Speed;

//设备信息（电风扇）
@interface FanDevice : Device

//电源状态,true:开,false:关
@property(nonatomic,assign) BOOL power;

//温度
@property(nonatomic,assign) int temperature;

//风速0:低速,1:中速,2:高速
@property(nonatomic,assign) int speed;

//摆头,true:打开,false:关闭
@property(nonatomic,assign) BOOL osc;

//负离子，true：打开，false：关闭
@property(nonatomic,assign) BOOL ion;

//定时器，1：定时1小时，2：定时2小时,...
@property(nonatomic,assign) int time;

-(id)initWithId:(NSString*)id_ Pid:(NSString*)pid Name:(NSString*)name Place:(NSString*)place Online:(BOOL)onLine Power:(BOOL)power Temp:(int)temperature Speed:(int)speed Osc:(BOOL)osc Ion:(BOOL)ion Time:(int)time;

-(id)initWithPower:(BOOL)power Temp:(int)temperature Speed:(int)speed Osc:(BOOL)osc Ion:(BOOL)ion Time:(int)time;

@end
