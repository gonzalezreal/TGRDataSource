// TGRArrayDataSource.m
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

#import "TGRArrayDataSource.h"

@implementation TGRArrayDataSource

- (id)initWithItems:(NSArray *)items
cellReuseIdentifier:(NSString *)reuseIdentifier
 configureCellBlock:(TGRDataSourceCellBlock)configureCellBlock
{
    self = [super initWithCellReuseIdentifier:reuseIdentifier
                           configureCellBlock:configureCellBlock];
    
    if (self) {
        _items = [items copy];
    }
    
    return self;
}

-  (id)initWithItems:(NSArray *)items
reuseIdentifierBlock:(TGRDataSourceReuseIdentifierBlock)reuseIdentifierBlock
  configureCellBlock:(TGRDataSourceCellBlock)configureCellBlock
{
    self = [super initWithReuseIdentifierBlock:reuseIdentifierBlock
                            configureCellBlock:configureCellBlock];
    
    if (self) {
        _items = [items copy];
    }
    
    return self;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath {
    return self.items[(NSUInteger)indexPath.row];
}

- (NSIndexPath *)indexPathForItem:(id)item {
    NSIndexPath *indexPath = nil;
    NSUInteger index = [self.items indexOfObject:item];
    
    if (index != NSNotFound) {
        indexPath = [NSIndexPath indexPathForRow:(NSInteger)index inSection:0];
    }
    
    return indexPath;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.items count];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return [self.items count];
}

@end
