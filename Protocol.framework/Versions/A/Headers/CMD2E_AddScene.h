//
//  CMD2E_AddScene.h
//  NewProtocol
//
//  Created by chendy on 13-9-14.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ClientCommand.h"
#import "SceneMode.h"

///客户端发送添加单个情景模式指令
@interface CMD2E_AddScene : ClientCommand

///情景模式
@property(nonatomic,strong) SceneMode* scene;

-(id)initWithScene:(SceneMode*)scene;

@end
