//
//  Power.h
//  NewProtocol
//
//  Created by chendy on 13-9-5.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONObject.h"
@protocol Power

@end

//电源状态
@interface Power : JSONObject

//哪一路
@property(nonatomic,assign) int way;

//开关
@property(nonatomic,assign) BOOL on;

-(id)initWithWay:(int)way_ On:(BOOL)on_;

@end
