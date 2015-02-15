//
//  CMDFF_ServerException.h
//  NewProtocol
//
//  Created by chendy on 13-9-14.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ServerCommand.h"

///服务器返回的异常包
@interface CMDFF_ServerException : ServerCommand

///错误码
@property(nonatomic,assign) int code;

///发生错误的指令编号
@property(nonatomic,assign) int CMDCode;

///错误信息
@property(nonatomic,strong) NSString* info;

-(id)initWithCode:(int)code CommandCode:(int)cmdCode Info:(NSString*) info;

@end
