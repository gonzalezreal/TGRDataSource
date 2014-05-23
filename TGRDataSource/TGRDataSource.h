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

typedef NSString *(^TGRDataSourceReuseIdentifierBlock)(NSIndexPath *indexPath, id item);
typedef void (^TGRDataSourceCellBlock)(id cell, id item);

/**
 Convenience class to encapsulate an `UITableView` or `UICollectionView` data source. 
 Inspired by http://www.objc.io/issue-1/lighter-view-controllers.html
 */
@interface TGRDataSource : NSObject <UITableViewDataSource, UICollectionViewDataSource>

/**
 A block that will be called when the view asks for the reuse identifier of cell in a 
 particular location.
 */
@property (copy, nonatomic, readonly) TGRDataSourceReuseIdentifierBlock reuseIdentifierBlock;

/**
 A block that will be called when the view asks for a cell in a particular location.
 */
@property (copy, nonatomic, readonly) TGRDataSourceCellBlock configureCellBlock;

/**
 Initializes the data source using a single reuse identifier. 
 
 @discussion This initializer internally creates a custom reuse identifier block 
 that will return the default reuse identifier for all cells. This is useful
 when a data source provide a single kind of cell, for homogeneous views.
 
 @param defaultReuseIdentifier The default cell reuse identifier.
 @param configureCellBlock A block that will be called when the view asks for a 
 cell in a particular location.
 
 @return An initialized data source.
 */
- (id)initWithCellReuseIdentifier:(NSString *)defaultReuseIdentifier
               configureCellBlock:(TGRDataSourceCellBlock)configureCellBlock;

/**
 Initializes the data source with a custom cell reuse identifier block.
 
 @discussion This is the designated initializer of this class. It creates
 a data source that provides multiple kinds of cell that can be used in
 the implementation of heterogeneous views.
 
 @param reuseIdentifierBlock A block that will be called when the view asks for
 the reuse identifier of cell in a particular location.
 @param configureCellBlock A block that will be called when the view asks for a
 cell in a particular location.
 
 @return An initialized data source.
 */
- (id)initWithReuseIdentifierBlock:(TGRDataSourceReuseIdentifierBlock)reuseIdentifierBlock
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
