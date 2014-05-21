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
 The default cell reuse identifier.
 */
@property (copy, nonatomic, readonly) NSString *cellReuseIdentifier;

/**
 A block that will be called when the view asks for a cell in a particular location.
 */
@property (copy, nonatomic, readonly) TGRDataSourceCellBlock configureCellBlock;

/**
 Initializes the data source.
 
 @discussion This initializer considers the implementation of a data source that 
 provides homogeneous cells, which means that all cells are dequeued using the 
 default reuse identifier.
 
 @param reuseIdentifier The default cell reuse identifier.
 @param configureCellBlock A block that will be called when the view asks for a 
 cell in a particular location.
 
 @return An initialized data source.
 */
- (id)initWithCellReuseIdentifier:(NSString *)reuseIdentifier
               configureCellBlock:(TGRDataSourceCellBlock)configureCellBlock;

/**
 Initializes the data source without a default cell reuse identifier.
 
 @discussion This initializer considers the implementation of a table view or
 collection view data source that provides heterogeneous cells. This implies 
 that the `cellReuseIdentifier` property will be ignored and the method 
 `reuseIdentifierForCellAtIndexPath:` must be overriden.
 
 @param configureCellBlock A block that will be called when the view asks for a
 cell in a particular location.
 
 @return An initialized data source.
 */
- (id)initWithConfigureCellBlock:(TGRDataSourceCellBlock)configureCellBlock;

/**
 Returns a reuse identifier used to dequeue a cell that will be placed
 on a given location.
 
 @discussion The default implementation of this method simply returns
 the value of the `cellReuseIdentifier` property. Overriding this method allows
 a subclass to use multiple reuse identifiers, which allows the creation
 of table views and collection views composed by heterogeneous cell types.
 
 @param indexPath The index path specifying the location of the cell.
 
 @return A reuse identifier specific for that cell
 */
- (NSString *)reuseIdentifierForCellAtIndexPath:(NSIndexPath *)indexPath;

/**
 Returns a data source item in a particular location.
 */
- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

/**
 Returns the location for the specified data source item.
 */
- (NSIndexPath *)indexPathForItem:(id)item;

@end
