//
//  UserInteractionDescriptor.h
//  UserInteractionMultiplexer
//
//  Copyright © 2016. SAP. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 Flag to enable the 'Cancel' button in the toolbar when displaying the interaction view controller.
 <p>
 When using this flag the application must include the <code>UserInteractionMultiplexer.bundle</code> and should be built
 using the <code>-all_load</code> and <code>-ObjC</code> flags.
 </p>
 */
extern const NSUInteger UIM_VIEW_FEATURE_TOOLBAR_CANCEL;

/**
 Immutable value object containing the view controller and the corresponding flags. Objects of these type are processed by
 a multiplexer and are created by the <code>createInteractionForRequest:completion:</code> method of objects conforming to
 the <code>UserInteractionHandlerProtocol</code> protocol.
 */
@interface UserInteractionDescriptor : NSObject

/**
 User interaction view controller to be displayed in the window managed by the multiplexer.
 */
@property (nonatomic, readonly, strong) UIViewController* interactionViewController;

/**
 Bit mask representing the feature flags which controls how the interaction view controller is displayed. The
 corresponding flags and their meanings are defined by the <code>UIM_VIEW_FEATURE_*</code> constants.
 */
@property (nonatomic, readonly, assign) NSUInteger featureFlags;

-(instancetype)init UNAVAILABLE_ATTRIBUTE;

/**
 Initializes an object of this type using the specified view controller and feature flags.
 
 @param viewController the interaction view controller, must be non-nil
 @param flags the feature flags
 */
-(instancetype)initWithViewController:(UIViewController*)viewController andFlags:(NSUInteger)flags;

@end
