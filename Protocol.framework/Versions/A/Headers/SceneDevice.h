//
//  SceneDevice.h
//  NewProtocol
//
//  Created by chendy on 13-9-10.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "JSONObject.h"

//情景设备
@interface SceneDevice : JSONObject

//String[原类型16bytes GUID]
@property(nonatomic,strong) NSString* sceneid;

//是否启用
@property(nonatomic,assign) BOOL enabled;

-(id)initWithSceneid:(NSString*)sceneid_ Enabled:(BOOL)enabled_;

@end
