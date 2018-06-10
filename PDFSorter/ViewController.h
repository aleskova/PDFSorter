//
//  ViewController.h
//  PDFSorter
//
//  Created by Anna Leskova on 5/30/18.
//  Copyright © 2018 Anna Leskova. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UIButton *menu;
- (void) showMenu;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UITableView *menuTable;
@property (strong, nonatomic) UITableView *sortByTable;
@property (strong, nonatomic) UISegmentedControl *sortBy;

@end
