//
//  MMViewNavigationController.h
//  Testtest
//
//  Created by Penny on 28/02/13.
//  Copyright (c) 2013 Penny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@class MMView;

@protocol MMViewGestureDelegate <NSObject>
- (void)viewDidPop:(MMView *)view;
@end

@interface MMViewNavigationController : UIView <MMViewGestureDelegate>
@property (nonatomic, readonly) MMView *rootView;
@property (nonatomic, readonly) NSMutableArray *views;

- (id)initWithRootView:(MMView*)rootView;

- (void)pushView:(UIView *)view animated:(BOOL)animated; // Uses a horizontal slide transition. Has no effect if the view controller is already in the stack.
- (void)popViewAnimated:(BOOL)animated;
@end


@interface MMView : UIView
@property (nonatomic, assign) id<MMViewGestureDelegate> delegate;
@property (nonatomic, assign) CGPoint animationEndPoint;
@property (nonatomic, retain) MMViewNavigationController *navigationController;

@property (nonatomic, readonly) MMView *presentView;    
//test
@property (nonatomic, retain) UILabel *textLabel;

// 
- (void)presentView:(MMView *)viewToPresent animated: (BOOL)flag completion:(void (^)(void))completion;
- (void)dismissViewAnimated:(BOOL)flag aompletion: (void (^)(void))completion;
@end