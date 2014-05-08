// TGRDataSource.h
// 
// Copyright (c) 2014 Guillermo Gonzalez
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <UIKit/UIKit.h>

typedef void (^TGRDataSourceCellBlock)(id cell, id item);

/**
 Convenience class to encapsulate an `UITableView` or `UICollectionView` data source. 
 Inspired by http://www.objc.io/issue-1/lighter-view-controllers.html
 */
@interface TGRDataSource : NSObject <UITableViewDataSource, UICollectionViewDataSource>

/**
 The cell reuse identifier.
 */
@property (copy, nonatomic, readonly) NSString *cellReuseIdentifier;

/**
 A block that will be called when the view asks for a cell in a particular location.
 */
@property (copy, nonatomic, readonly) TGRDataSourceCellBlock configureCellBlock;

/**
 Initializes the data source.
 
 @param reuseIdentifier The cell reuse identifier.
 @param configureCellBlock A block that will be called when the view asks for a cell in a particular location.
 
 @return An initialized data source.
 */
- (id)initWithCellReuseIdentifier:(NSString *)reuseIdentifier
               configureCellBlock:(TGRDataSourceCellBlock)configureCellBlock;

/**
 Returns a data source item in a particular location.
 */
- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

/**
 Returns the location for the specified data source item.
 */
- (NSIndexPath *)indexPathForItem:(id)item;

@end
