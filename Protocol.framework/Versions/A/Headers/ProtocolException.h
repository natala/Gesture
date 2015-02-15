//
//  ProtocolException.h
//  NewProtocol
//
//  Created by chendy on 13-9-10.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "JSONObject.h"

//异常信息
@interface ProtocolException : JSONObject

///错误码
@property(nonatomic,assign) int code;

///发生错误的指令编号
@property(nonatomic,assign) int CMDCode;

///错误信息
@property(nonatomic,strong) NSString* info;

-(id)initWithCode:(int)code CommandCode:(int)cmdCode Info:(NSString*) info;

@end
