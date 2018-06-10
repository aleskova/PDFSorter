//
//  ViewController.m
//  PDFSorter
//
//  Created by Anna Leskova on 5/30/18.
//  Copyright © 2018 Anna Leskova. All rights reserved.
//

#import "ViewController.h"
#import <PDFKit/PDFKit.h>
#import "PDFCell.h"
#import "PDF.h"
#import "AdobeColors.h"
#import "PDFViewController.h"

@interface ViewController ()

@property (strong, nonatomic) NSMutableArray<PDF *> *pdfs;
@property (strong, nonatomic) NSArray<NSString *> *menuCellNames;
@property (strong, nonatomic) NSArray<NSString *> *sortByNames;

@end

@implementation ViewController

const NSArray<NSString *> *pdfLinks;
CGFloat topbarHeight;

/* Show's the menu options by inverting isHidden properties accordingly. */
- (void) showMenu {
    if (!self.sortByTable.isHidden) [self.sortByTable setHidden:YES];
    
    if (self.menuTable.isHidden) [self.menu setTitle:@"Local  ʌ" forState:UIControlStateNormal];
    else [self.menu setTitle:@"Local  v" forState:UIControlStateNormal];
    [self.menuTable setHidden:!self.menuTable.isHidden];
}

/* Creates a menu button view for the menu. */
- (void) setupMenu {
    self.menu = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.menu addTarget:self
               action:@selector(showMenu)
     forControlEvents:UIControlEventTouchUpInside];
    
    [self.menu setTitle:@"Local  v" forState:UIControlStateNormal];
    [self.menu.titleLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:16]];
    self.menu.tintColor = UIColor.AdobeBlue;
    self.menu.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
    self.navigationItem.titleView = self.menu;
}

/* Populates the list of pdfs that will be used for the tableView. */
- (void) setupPDFs {
    for (NSString *link in pdfLinks) {
        NSURL *url = [[NSURL alloc] initWithString:link];
        PDFDocument *doc = [[PDFDocument alloc] initWithURL:url];
        PDF *pdf = PDF.new;
        pdf.doc = doc;
        [self.pdfs addObject:pdf];
    }
}

/* Declares the titles for main menu, sorty by menu, and pdf url links. */
- (void) setupLables {
    self.pdfs = NSMutableArray.new;
    self.menuCellNames = NSMutableArray.new;
    self.sortByNames = NSMutableArray.new;
    
    self.menuCellNames = @[@"Sort By...",@"Recent", @"Local", @"More Locations..."];
    self.sortByNames = @[@"Name", @"Date Created", @"Size"];
    pdfLinks = @[@"http://kmmc.in/wp-content/uploads/2014/01/lesson2.pdf",
                 @"http://uhs.berkeley.edu/sites/default/files/lowbackpain.pdf",
                 @"http://unec.edu.az/application/uploads/2014/12/pdf-sample.pdf",
                 @"http://greatergood.berkeley.edu/images/application_uploads/Bartlett-Gratitude+ProsocialBehavior.pdf"];
   
    [self setupPDFs];
}

/* Sets up the main screen's tableView and anchors.*/
- (void) setupTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self.tableView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [self.tableView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    [self.tableView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
    
    self.tableView.backgroundColor = UIColor.whiteColor;
    [self.tableView registerClass:PDFCell.class forCellReuseIdentifier:@"Cell"];
    [self.tableView reloadData];
}

/* Sets up the menu's tableView and anchors.*/
- (void) setupMenuTableView {
    self.menuTable = [[UITableView alloc] initWithFrame:CGRectZero];
    self.menuTable.backgroundColor = [UIColor.grayColor colorWithAlphaComponent:0.75];
    [self.menuTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.menuTable setHidden:YES];
    
    [self.view addSubview: self.menuTable];
    self.menuTable.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view bringSubviewToFront:self.menuTable];
    
    [self.menuTable.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [self.menuTable.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    [self.menuTable.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:topbarHeight].active = YES;
    [self.menuTable.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
    
    self.menuTable.delegate = self;
    self.menuTable.dataSource = self;
    [self.menuTable setScrollEnabled:NO];
}

/* Sets up the sot by menu's tableView and anchors.*/
- (void) setupSortByTableView {
    self.sortByTable = [[UITableView alloc] initWithFrame:CGRectZero];
    self.sortByTable.backgroundColor = [UIColor.grayColor colorWithAlphaComponent:0.75];
    [self.sortByTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.sortByTable setHidden:YES];

    [self.view addSubview:self.sortByTable];
    self.sortByTable.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view bringSubviewToFront:self.sortByTable];
    
    [self.sortByTable.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [self.sortByTable.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    [self.sortByTable.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:topbarHeight].active = YES;
    [self.sortByTable.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
    
    self.sortByTable.delegate = self;
    self.sortByTable.dataSource = self;
    
    // Creates the ghost apperence of "Sort By..."
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(1, 50, 276, 30)];
    headerView.backgroundColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0f];
    
    UILabel *labelView = [[UILabel alloc] initWithFrame:CGRectMake(4, 5, 276, 24)];
    labelView.text = @"Sort By...";
    labelView.textColor = UIColor.grayColor;
    [labelView setFont:[UIFont fontWithName:@"Arial" size:14]];
    
    [headerView addSubview:labelView];
    self.sortByTable.tableHeaderView = headerView;
    
    [self.sortByTable setScrollEnabled:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.opaque = NO;
    [self setupLables];
    
    [self setupMenu];
    topbarHeight = ([UIApplication sharedApplication].statusBarFrame.size.height +
                    (self.navigationController.navigationBar.frame.size.height ?: 0.0));
    
    [self setupTableView];
    [self setupMenuTableView];
    [self setupSortByTableView];
}

- (double) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.tableView) return self.pdfs.count;
    else if (tableView == self.menuTable) return self.menuCellNames.count;
    else return self.sortByNames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.tableView) {
        PDFCell *cell = PDFCell.new;
        cell.backgroundColor = UIColor.whiteColor;
        PDF *pdf = [self.pdfs objectAtIndex:indexPath.row];
        [cell fillLabels:pdf];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if (tableView == self.menuTable) {
        UITableViewCell *menuCell = UITableViewCell.new;
        menuCell.textLabel.text = self.menuCellNames[indexPath.row];
        [menuCell.textLabel setFont:[UIFont fontWithName:@"Arial" size:14]];
        menuCell.backgroundColor = UIColor.whiteColor;
        menuCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return menuCell;
    } else {
        UITableViewCell *sortByCell = UITableViewCell.new;
        sortByCell.textLabel.text = self.sortByNames[indexPath.row];
        [sortByCell.textLabel setFont:[UIFont fontWithName:@"Arial" size:14]];
        sortByCell.backgroundColor = UIColor.whiteColor;
        sortByCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return sortByCell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.menuTable) {
        if (indexPath.row == 0) {
            [self.sortByTable setHidden:!self.sortByTable.isHidden];
            [self.menuTable setHidden:YES];
        }
    } else if (tableView == self.tableView) {
        PDFViewController *viewPDF = [[PDFViewController alloc] init];
        viewPDF.selctedPDF.document = [self.pdfs objectAtIndex:indexPath.row].doc;
        viewPDF.navigationItem.titleView = nil;
        [self.navigationController pushViewController:viewPDF animated:YES];
    } else {
        /* Sort function that reorganizes the main page's PDF's by name, date created,
         and document size in ascending order. */
         if (indexPath.row == 0) {
            [self.sortByTable setHidden:YES];
            [self.pdfs sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                NSString *name1 = [(PDF *) obj1 getName];
                NSString *name2 = [(PDF *) obj2 getName];
                return [name1 compare:name2];
            }];
        } else if (indexPath.row == 1) {
            [self.sortByTable setHidden:YES];
            [self.pdfs sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                NSDate *date1 = [(PDF *) obj1 getDate];
                NSDate *date2 = [(PDF *) obj2 getDate];
                return [date1 compare:date2];
            }];
        } else if (indexPath.row == 2) {
            [self.sortByTable setHidden:YES];
            [self.pdfs sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                NSUInteger size1 = [(PDF *) obj1 getSize];
                NSUInteger size2 = [(PDF *) obj2 getSize];
                return size1 - size2;
            }];
        }
        [self.menu setTitle:@"Local  v" forState:UIControlStateNormal];
        [self.tableView reloadData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
