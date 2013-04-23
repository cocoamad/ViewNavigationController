//
//  ViewController.h
//  testst
//
//  Created by Penny on 28/02/13.
//  Copyright (c) 2013 Penny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMViewNavigationController.h"
@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, retain) UITableView *tableView;
@end
