// TGRArrayDataSource.h
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

#import "TGRDataSource.h"

/**
 An array data source for table and collection views.
 */
@interface TGRArrayDataSource : TGRDataSource

/**
 The items managed by this data source.
 */
@property (copy, nonatomic, readonly) NSArray *items;

/**
 Initializes the data source.
 
 @param items The items managed by the data source.
 @param reuseIdentifier The cell reuse identifier.
 @param configureCellBlock A block that will be called when the view asks for a cell in a particular location.
 
 @return An initialized data source.
 */
- (id)initWithItems:(NSArray *)items
cellReuseIdentifier:(NSString *)reuseIdentifier
 configureCellBlock:(TGRDataSourceCellBlock)configureCellBlock;


@end
