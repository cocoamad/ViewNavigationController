//
//  MMViewNavigationController.m
//  Testtest
//
//  Created by Penny on 28/02/13.
//  Copyright (c) 2013 Penny. All rights reserved.
//

#import "MMViewNavigationController.h"
#define DISTANCE 160
@implementation MMViewNavigationController

- (id)init
{
    if (self = [super init]) {
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];

    }
    return self;
}


- (id)initWithRootView:(MMView*)rootView
{
    if (self = [super initWithFrame: rootView.bounds]) {
        [_rootView release];
        _rootView = [rootView retain];
        
        _rootView.navigationController = self;
        rootView.animationEndPoint = CGPointMake(rootView.center.x + DISTANCE, rootView.center.y);
        
        [self addSubview: _rootView];
        
        _views = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
    [_rootView release];
    [_views removeAllObjects];
}

- (void)pushView:(MMView *)view animated:(BOOL)animated
{
    if (animated) {
        view.navigationController = self;
        view.delegate = self;
        view.animationEndPoint = CGPointMake(self.center.x + view.bounds.size.width, self.center.y);
        [self.views addObject: view];
        CGRect frame = self.rootView.frame;
        CGRect newFrame = frame;
        newFrame.origin.x += newFrame.size.width;
        view.frame = newFrame;
        [self addSubview: view];
        [UIView animateWithDuration: .2f delay: .01f options: UIViewAnimationOptionCurveEaseInOut animations:^{
            view.frame = frame;
        } completion:^(BOOL finished) {
            
        }];
    } else {
        [self.views addObject: view];
        [self addSubview: view];
    }
}

- (void)popViewAnimated:(BOOL)animated
{
    MMView *view = [self.views lastObject];
    if (view) {
        if (animated) {
            [self.views removeObject: view];
            CGRect frame = view.frame;
            CGRect newFrame = frame;
            newFrame.origin.x += newFrame.size.width;
            
            [UIView animateWithDuration: .2f delay: .01f options: UIViewAnimationOptionCurveEaseInOut animations:^{
                view.frame = newFrame;
            } completion:^(BOOL finished) {
                view.frame = CGRectZero;
                [view removeFromSuperview];
            }];
        } else {
            [self.views removeObject: view];
            [view removeFromSuperview];
        }
    }
}

#pragma mark MMViewGestureDelegate
- (void)viewDidPop:(MMView *)view
{
    [self.views removeObject: view];
    [view removeFromSuperview];
}

@end

#pragma mark - MMView Class 
@interface MMView ()
@property (nonatomic, assign) BOOL needRemove;
@end
#define DISTANCE 160
@implementation MMView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self addShadow];
        [self addPanGesture];
        [self addTapGesture];
        _needRemove = NO;
        //test
        [self testLabel];
        [self testButton];
    }
    return self;
}

- (void)addPanGesture
{
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget: self action: @selector(_handlePanGesture:)];
    [self addGestureRecognizer: panGesture];
    [panGesture release];
}

- (void)addTapGesture
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(_handleTapGesture:)];
    [self addGestureRecognizer: tapGesture];
    [tapGesture release];
}

- (void)addShadow
{
    [self.layer setShadowOffset:CGSizeMake(10, 10)];
    [self.layer setShadowRadius: 20];
    [self.layer setShadowOpacity: 1];
    [self.layer setShadowColor: [UIColor blackColor].CGColor];
}

#pragma mark Test
- (void)testLabel
{
    self.backgroundColor = [UIColor colorWithRed: (random() % 255) * 1.0 / 255 green: (random() % 255) * 1.0 blue: (random() % 255) * 1.0 alpha: 1];
    self.textLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, 200, 20)];
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    self.textLabel.font = [UIFont boldSystemFontOfSize: 20];
    self.textLabel.backgroundColor = [UIColor clearColor];
    self.textLabel.text = @"home page";
    CGPoint center = self.center;
    center.y -= 50;
    self.textLabel.center = center;
    [self addSubview: self.textLabel];
}

- (void)testButton
{
    UIButton *btn = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    [btn setFrame: CGRectMake(100, 100, 80, 40)];
    [btn setTitle: @"next view" forState: UIControlStateNormal];
    [btn addTarget: self action: @selector(nextViewClick:) forControlEvents: UIControlEventTouchUpInside];
    [self addSubview: btn];
    
    UIButton *btn1 = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    [btn1 setFrame: CGRectMake(100, 160, 80, 40)];
    [btn1 setTitle: @"pop" forState: UIControlStateNormal];
    [btn1 addTarget: self action: @selector(pop:) forControlEvents: UIControlEventTouchUpInside];
    
    [self addSubview: btn1];
}

- (void)nextViewClick:(id)sender
{
    
    MMView *view = [[MMView alloc] initWithFrame: self.bounds];
    view.textLabel.text = [NSString stringWithFormat: @"%d", self.navigationController.views.count + 1];
    [self.navigationController pushView: view animated: YES];
}

- (void)pop:(id)sender
{
    [self.navigationController popViewAnimated: YES];
}

#pragma mark Push and Dismiss
- (void)presentView:(MMView *)viewToPresent animated: (BOOL)flag completion:(void (^)(void))completion
{
    [_presentView release];
    _presentView = [viewToPresent retain];
    
    if (flag) {
        CGRect frame = self.frame;
        CGRect newFrame = frame;
        frame.origin.y += frame.size.height;
        viewToPresent.frame = frame;
        
        [UIView animateWithDuration: .2f delay: .01f options: UIViewAnimationOptionCurveEaseInOut animations:^{
            _presentView.frame = newFrame;
        } completion:^(BOOL finished) {
            completion();
        }];
    } else {
        _presentView.frame = self.frame;
    }
}

- (void)dismissViewAnimated:(BOOL)flag aompletion: (void (^)(void))completion
{
    [_presentView release];
    CGRect frame = self.frame;
    frame.origin.y += frame.size.height;
    if (flag) {
        [UIView animateWithDuration: .2f delay: .01f options: UIViewAnimationOptionCurveEaseInOut animations:^{
            self.frame = frame;
        } completion:^(BOOL finished) {
            completion();
        }];
    } else {
        self.frame = frame;
    }
}

#pragma mark Gesture Event
- (void)_handlePanGesture:(UIPanGestureRecognizer *)recognizer
{
    CGPoint translation = [recognizer translationInView: self];
    float x = self.center.x + translation.x;
    if (x < self.navigationController.center.x) {
        x = self.navigationController.center.x;
    }
    self.center = CGPointMake(x, self.animationEndPoint.y);
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration: .2f delay: .01 options: UIViewAnimationOptionCurveEaseInOut animations:^{
            if (x > self.animationEndPoint.x - self.animationEndPoint.x / 3) {
                self.center = self.animationEndPoint;
                _needRemove = YES;
            } else {
                self.center = CGPointMake(self.navigationController.center.x, self.animationEndPoint.y);
            }
        } completion:^(BOOL finished) {
            if (_needRemove) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (self.delegate && [self.delegate respondsToSelector: @selector(viewDidPop:)]) {
                        [self.delegate viewDidPop: self];
                    }
                });
            }
        }];
        
    }
    [recognizer setTranslation: CGPointZero inView: self.navigationController];
}

- (void)_handleTapGesture:(UITapGestureRecognizer *)recognizer
{
    
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
