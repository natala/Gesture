//
//  Command.h
//  NewProtocol
//
//  Created by chendy on 13-9-10.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONObject.h"

///命令基类，所有的命令都继承至此类
@interface Command : JSONObject {
    @public
    //指令编号
    Byte CommandNo;
    //协议版本
    Byte protocolVer;
}

//流水号
@property(nonatomic,assign) short SerNum;

//根据bytes生成命令，不重新创建对象
-(id)fromBytes:(NSData*)data;

//将命令转换成bytes
-(NSData*)getBytes;

//本指令的对应的编号
+(Byte)commandConst;

@end
