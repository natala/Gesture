//
//  CMD31_ServerDelSceneResult.h
//  NewProtocol
//
//  Created by chendy on 13-9-14.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ServerCommand.h"

///服务器返回删除情景模式结果
@interface CMD31_ServerDelSceneResult : ServerCommand

///是否成功
@property(nonatomic,assign) BOOL result;

///情景模式ID
@property(nonatomic,strong) NSString* sceneid;

-(id)initWithResult:(BOOL)result Sceneid:(NSString*)sceneid;

@end
