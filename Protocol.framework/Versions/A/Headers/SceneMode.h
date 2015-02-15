//
//  SceneMode.h
//  NewProtocol
//
//  Created by chendy on 13-9-10.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "JSONObject.h"

//情景模式
@interface SceneMode : JSONObject

//String[原类型16bytes GUID]
@property(nonatomic,strong) NSString* id;

//图片编号
@property(nonatomic,assign) int imageno;

//名称
@property(nonatomic,strong) NSString* name;

-(id)initWithId:(NSString*)id_ ImageNo:(int)imageno_ Name:(NSString*)name_;

@end
