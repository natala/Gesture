//
//  CMD6C_ControlIRDeviceMode.h
//  ClientProtocol
//
//  Created by chendy on 13-10-12.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ClientCommand.h"


///客户端发送控制设备的红外模式
@interface CMD6C_ControlIRDeviceMode : ClientCommand


///SN
@property(nonatomic,strong) NSString<expose>* sn;


/**
 *  模式
 *  0:正常模式,1:红外设置模式
 **/
@property(nonatomic,strong) NSNumber<expose>* mode;

-(id)initWithSN:(NSString*)sn Mode:(int)mode;

@end
