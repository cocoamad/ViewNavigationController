//
//  ViewController.m
//  testst
//
//  Created by Penny on 28/02/13.
//  Copyright (c) 2013 Penny. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface ViewController ()
@property (nonatomic, retain) NSMutableArray *dataSource;
@property (nonatomic, retain) MMView *selectedView;

@end

@implementation ViewController
@synthesize tableView = _tableView;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.tableView = [[[UITableView alloc] initWithFrame: CGRectMake(0, 0, 160, self.view.frame.size.height) style: UITableViewStylePlain] autorelease];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview: self.tableView];
    [self.view setBackgroundColor: [UIColor whiteColor]];
    self.dataSource = [NSMutableArray arrayWithObjects: @"首页", @"热门", @"图库", @"新闻", @"文艺", @"时尚", @"生活", @"往期",@"收藏",@"注册",@"设置",  nil];
    [self.tableView reloadData];
    
    [self.tableView selectRowAtIndexPath: [NSIndexPath indexPathForRow: 0 inSection: 0] animated: NO scrollPosition: UITableViewScrollPositionNone];
    
//    [self buildContentView: [NSIndexPath indexPathForRow: 0 inSection: 0]];

    MMView *homePageRootView = [[[MMView alloc] initWithFrame: self.view.frame] autorelease];
    MMViewNavigationController *vnc = [[MMViewNavigationController alloc] initWithRootView: homePageRootView];
    
    
    [self.view addSubview: vnc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  30;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indef = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: indef];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: indef] autorelease];
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
