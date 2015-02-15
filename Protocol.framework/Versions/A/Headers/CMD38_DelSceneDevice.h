//
//  CMD38_DelSceneDevice.h
//  NewProtocol
//
//  Created by chendy on 13-9-14.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ClientCommand.h"

///客户端发送删除单个情景设备指令
@interface CMD38_DelSceneDevice : ClientCommand

///情景id
@property(nonatomic,strong) NSString<expose>* sceneid;

///设备id
@property(nonatomic,strong) NSString<expose>* devid;

-(id)initWithSceneid:(NSString*)sceneid Devid:(NSString*)devid;

@end
