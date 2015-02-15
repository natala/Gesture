//
//  AirConditionDeviceStatus.h
//  NewProtocol
//
//  Created by chendy on 13-9-6.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "Device.h"
#import "Power.h"

typedef enum {
    //自动
    AUTO_MODE = 0,
    //制冷
    COOL_MODE,
    //除湿
    WET_MODE,
    //送风
    WIND_MODE,
    //制暖
    WARM_MODE
} AirMode;

typedef enum {
    //自动
    AUTO_SPEED = 0,
    //低速
    LOW_SPEED,
    //中速
    MID_SPEED,
    //高速
    HI_SPEED
} AirSpeed;

typedef enum {
    //自动摆放
    AUTO_DIRECTION = 0,
    //定向摆放
    VECT_DIRECTION,
    //上向摆放
    UP_DOWN_DIRECTION,
    //左右摆放
    LEFT_RIGHT_DIRECTION,
} AirDirection;

//空调信息
@interface AirConditionDeviceStatus : Device

//电源状态,多路
@property(nonatomic,strong) NSArray<Power,ConvertOnDemand>* power;

//(Integer[0自动，1制冷，2除湿，3送风，4制暖])
@property(nonatomic,assign) AirMode mode;
//(Integer[0自动，1低速，2中速，3高速])
@property(nonatomic,assign) AirSpeed speed;
//(Integer[0自动摆放，1定向摆放，2上下摆风，3左右摆风])
@property(nonatomic,assign) AirDirection direction;
//(Integer[设置温度：16-30])
@property(nonatomic,assign) int temperature;
//(Integer[环境温度：-64-64])
@property(nonatomic,assign) int envtemp;
//(Integer[厂商识别代码])
@property(nonatomic,assign) int manid;

-(id)initWithId:(NSString*)id_ Pid:(NSString*)pid Name:(NSString*)name Place:(NSString*)place Online:(BOOL)onLine Power:(NSArray*)powers Mode:(AirMode)mode Speed:(AirSpeed)speed Direction:(AirDirection)direction Temp:(int)temperature Envtemp:(int)envtemp;

//设置第一路开关的状态
-(void)setOneWayPower:(BOOL)on;

//获得第一路开关的状态
-(BOOL)getOneWayPower;

@end
