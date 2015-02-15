//
//  UserInfo.h
//  NewProtocol
//
//  Created by chendy on 13-9-5.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONObject.h"

//用户信息
@interface UserInfo : JSONObject

//用户名
@property(nonatomic,strong) NSString* name;
//密码
@property(nonatomic,strong) NSString* pass;
//用户id
@property(nonatomic,strong) NSString* userid;
//电话
@property(nonatomic,strong) NSString* phone;
//e-mail
@property(nonatomic,strong) NSString* email;

//Integer[时区偏移，精确到分钟]
@property(nonatomic,assign) int offset;

//appid
@property(nonatomic,assign) int appid;

-(id)initWithName:(NSString*)name_ Pass:(NSString*)pass_ Userid:(NSString*)userid_ Phone:(NSString*)phone_ Email:(NSString*)email_ Offset:(int)offset_ Appid:(int)appid;

@end
