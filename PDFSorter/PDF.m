//
//  NSObject+PDF.m
//  PDFSorter
//
//  Created by Anna Leskova on 5/31/18.
//  Copyright © 2018 Anna Leskova. All rights reserved.
//

#import "PDF.h"
#import <PDFKit/PDFKit.h>

@implementation PDF

- (PDFView *) getThumbnail {
    PDFView *pdf = PDFView.new;
    pdf.document = self.doc;
    return pdf;
}

-(NSString *) getName {
    return [[self.doc documentAttributes] objectForKey:PDFDocumentTitleAttribute];
}

-(NSDate *) getDate {
    return [[self.doc documentAttributes] objectForKey:PDFDocumentCreationDateAttribute];
}

-(NSUInteger) getSize {
    return self.doc.dataRepresentation.length;
}

-(NSString *) getDateString {
    NSDate *date = [self getDate];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    return [formatter stringFromDate:date];
}

-(NSString *) getSizeString {
    NSUInteger size = [self getSize];
    return [NSString stringWithFormat:@"%.2f MB", (float) size / 1048576.0f]; //2^20
}

@end
