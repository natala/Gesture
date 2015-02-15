//
//  CMD35_ServerQuerySceneListResult.h
//  NewProtocol
//
//  Created by chendy on 13-9-14.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ServerCommand.h"

///服务器返回查询情景模式列表指令
@interface CMD35_ServerQuerySceneListResult : ServerCommand

///情景列表
@property(nonatomic,strong) NSArray* sceneList;

-(id)initWithSceneList:(NSArray*)sceneList;

@end
