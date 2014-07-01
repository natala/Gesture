//
//  KHColorConstants.h
//  KneeHapp
//
//  Created by Tim Haug on 14.05.14.
//  Copyright (c) 2014 Praxis. All rights reserved.
//

#define UIColorFromHex(hex) [UIColor colorWithRed : ((float)((hex & 0xFF0000) >> 16)) / 255.0 green : ((float)((hex & 0xFF00) >> 8)) / 255.0 blue : ((float)(hex & 0xFF)) / 255.0 alpha : 1.0]

#define kKHColorBlue           UIColorFromHex(0x007AFF)
//  [UIColor colorWithRed:0.0 / 255.0 green:122.0 / 255.0 blue:255.0 / 255.0 alpha:1]
#define kKHColorGreyBackground UIColorFromHex(0xD8D8D8)
//  [UIColor colorWithRed:247.0 / 255.0 green:247.0 / 255.0 blue:247.0 / 255.0 alpha:1]
#define kKHColorGreyIcon       UIColorFromHex(0x9B9B9B)
//  [UIColor colorWithRed:155.0 / 255.0 green:155.0 / 255.0 blue:155.0 / 255.0 alpha:1]
#define kKHColorGreyMenu       UIColorFromHex(0xE6E4E4)
//  [UIColor colorWithRed:(230.0 / 255.0) green:(228.0 / 255.0) blue:(228.0 / 255.0) alpha:1.0]
