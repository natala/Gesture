//
//  CMD30_DelScene.h
//  NewProtocol
//
//  Created by chendy on 13-9-14.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ClientCommand.h"

///客户端发送删除单个情景模式指令
@interface CMD30_DelScene : ClientCommand

///情景模式的ID
@property(nonatomic,strong) NSString<expose>* sceneid;

-(id)initWithSceneid:(NSString*)sceneid;

@end
