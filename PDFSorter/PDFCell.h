//
//  PDFCell.h
//  PDFSorter
//
//  Created by Anna Leskova on 5/30/18.
//  Copyright © 2018 Anna Leskova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PDFKit/PDFKit.h>
#import "PDF.h"

@interface PDFCell : UITableViewCell

/* PDFCell TableViewCell that does the setup for the main screen's table view.
 Calls funtions form PDF.h to populate the cells accordingly.*/
@property (strong, nonatomic) UIView *thumbnail;
@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UILabel *size;
@property (strong, nonatomic) UILabel *date;
- (void) fillLabels : (PDF *) pdf;

@end
