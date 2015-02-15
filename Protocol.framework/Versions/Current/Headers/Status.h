//
//  Status.h
//  ClientProtocol
//
//  Created by chendy on 13-10-15.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "JSONObject.h"

@protocol Status

@end

//诺德下挂信息的类
@interface Status : JSONObject

//名称
@property(nonatomic,strong) NSString* name;

//产品编码
@property(nonatomic,strong) NSString* productCode;

//组号
@property(nonatomic,strong) NSString* group;

//组名
@property(nonatomic,strong) NSString* groupName;

//状态，开或关
@property(nonatomic,strong) NSString* status;

-(id)initWithName:(NSString*)name ProductCode:(NSString*)productCode Group:(NSString*)groupNum GroupName:(NSString*)groupName Status:(NSString*)status;

@end
