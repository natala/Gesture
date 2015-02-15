//
//  CMD2F_ServerAddSceneResult.h
//  NewProtocol
//
//  Created by chendy on 13-9-14.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ServerCommand.h"
#import "SceneMode.h"

///服务器返回添加情景模式结果
@interface CMD2F_ServerAddSceneResult : ServerCommand

///是否成功
@property(nonatomic,assign) BOOL result;

///情景模式
@property(nonatomic,strong) SceneMode* scene;

-(id)initWithResult:(BOOL)result Scene:(SceneMode*)scene;

@end
