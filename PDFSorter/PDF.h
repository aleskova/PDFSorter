//
//  NSObject+PDF.h
//  PDFSorter
//
//  Created by Anna Leskova on 5/31/18.
//  Copyright © 2018 Anna Leskova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <PDFKit/PDFKit.h>

@interface PDF:NSObject

/* PDF object that contains all the information needed in a PDFCell. */
@property (strong, nonatomic) PDFDocument *doc;
- (PDFView *) getThumbnail;
-(NSString *) getName;
-(NSDate *) getDate;
-(NSUInteger) getSize;
-(NSString *) getDateString;
-(NSString *) getSizeString;

@end
