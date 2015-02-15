//
//  TimerInfo.h
//  NewProtocol
//
//  Created by chendy on 13-9-10.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "JSONObject.h"
#import "TimerTask.h"
#import "Device.h"

@protocol TimerInfo

@end

//定时任务信息
@interface TimerInfo : JSONObject

//任务信息
@property(nonatomic,strong) TimerTask* schedinfo;

//设备信息
@property(nonatomic,strong) Device* ctrlinfo;

-(id)initWithSchedInfo:(TimerTask*)schedinfo_ CtrlInfo:(Device*)ctrlinfo_;

@end
