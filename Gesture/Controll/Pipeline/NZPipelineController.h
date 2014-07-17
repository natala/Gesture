//
//  NZPipelineController.h
//  Gesture
//
//  Created by Natalia Zarawska on 7/17/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NZPipelineControllerDelegate <NSObject>

@end


@interface NZPipelineController : NSObject

/**
 * Creates and returns the singleton instance of the pipeline controller.
 * @author  Natalia Zarawska
 * @return  The singleton instance of the pipeline controller.
 */
+ (NZPipelineController *)sharedManager;

@property (nonatomic, retain) id<NZPipelineControllerDelegate> delegate;


@end
