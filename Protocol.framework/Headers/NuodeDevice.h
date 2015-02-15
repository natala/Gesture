//
//  NuodeDevice.h
//  ClientProtocol
//
//  Created by chendy on 13-10-10.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "Device.h"
#import "NuodeDeviceStatus.h"

typedef  enum {
    //开关机命令
    CODE_SWITCH = 0x0A,
    //RGB切换模式
    CODE_RGB = 0x0B,
    //亮度调节命令
    CODE_LIGHT = 0x0C,
    //直接调色模式
    CODE_RGB_CW = 0x0D,
    //冷暖光调节命令
    CODE_CW = 0x0E,
    //RGB自动模式速度控制命令
    CODE_SPEED = 0x0F,
    //场景模式
    CODE_SCENE = 0x10,
    //开或关状态查询
    CODE_QUERY = 0xA0,
    //WIFI主机向服务器请求下载灯列表
    CODE_QUERY_SN_LIST = 0xAA,
    //WIFI主机请求查询列表版本
    CODE_QUERY_SN_LIST_VERSION = 0xAB,
    //设置下挂设备的列表
    CODE_SN_LIST = 0xAC,
    
} NuodeDeviceControlType;

@interface NuodeDevice : Device

/*
 * 控制的类型 <br>
 * CODE_SWITCH = 0x0A; // 开关机命令 <br>
 * CODE_RGB = 0x0B; // RGB切换模式 <br>
 * CODE_LIGHT = 0x0C; // 亮度调节命令 <br>
 * CODE_RGB_CW = 0x0D; // 直接调色模式 <br>
 * CODE_CW = 0x0E; // 冷暖光调节命令 <br>
 * CODE_SPEED = 0x0F; // RGB自动模式速度控制命令 <br>
 * CODE_SCENE = 0x10; // 场景模式 <br>
 * CODE_QUERY = (byte) 0xA0; // 开或关状态查询 <br>
 * CODE_QUERY_SN_LIST = (byte) 0xAA; // WIFI主机向服务器请求下载灯列表 <br>
 * CODE_QUERY_SN_LIST_VERSION = (byte) 0xAB; // WIFI主机请求查询列表版本 <br>
 * CODE_SN_LIST = (byte) 0xAC; // 设置下挂设备的列表<br>
 */
@property(nonatomic,assign) NuodeDeviceControlType controlType;

//开关[开:true,关:false]
@property(nonatomic,assign) BOOL kg;

//RGB颜色的R值:0~255
@property(nonatomic,strong) NSString* r1;

//RGB颜色的G值:0~255
@property(nonatomic,strong) NSString* g1;

//RGB颜色的B值:0~255
@property(nonatomic,strong) NSString* b1;

//RGB分级功能的级数
@property(nonatomic,strong) NSString* rgb2;


//速度:0~6
@property(nonatomic,strong) NSString* speed;

//冷光值:0~100
@property(nonatomic,strong) NSString* c1;

//暖光值:0~100
@property(nonatomic,strong) NSString* w1;

//冷暖模式分级功能的级数
@property(nonatomic,strong) NSString* cw2;

//亮度:0~100
@property(nonatomic,strong) NSString* light;

//组号
@property(nonatomic,strong) NSString* groupNum;

/*
 * 场景模式的HexString <br>
 * <br>
 * 场景名称 定时 起床 睡眠 夜晚(无) 会议(无) 阅读(无) 娱乐(无)<br>
 * 场景号 （DATA[0]） 0X01 0X02 0X03 0X04 0X05 0X06 0X07 <br>
 * 根据scene长度判断是什么场景<br>
 * 定时开 01(场景) 02(group) 01(开机时间设定：0X01，关机时间设定：0X02) <br>
 * 00 00 00 (nowtimer: s,m,h) 00 00 00 (设定时间:s, m, h) <br>
 *
 * 定时开 01(场景) 02(group) 02(开机时间设定：0X01，关机时间设定：0X02) <br>
 * 00 00 00 (nowtimer: s,m,h) 00 00 00 (设定时间:s, m, h) <br>
 *
 * 删除定开 01(场景) 02(group) 01(开机时间：0X01，关机时间：0X02) <br>
 *
 * 删除定关 02(场景) 02(group) 02(开机时间：0X01，关机时间：0X02) <br>
 */
@property(nonatomic,strong)NSString* scene;

//产品编码，hexstring，三个字节的id号(idh,idm,idl)，长度为6个字节
@property(nonatomic,strong) NSString* productCode;

//产品的状态，通过mac.SwitcherValue3的json字符串转换而来的。
@property(nonatomic,strong) NuodeDeviceStatus* nuodeStatus;

@end
