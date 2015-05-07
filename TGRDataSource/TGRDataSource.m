// TGRDataSource.m
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
#import "NSObject+Abstract.h"

@interface TGRDataSource ()

@property (copy, nonatomic) NSString *cellReuseIdentifier;
@property (copy, nonatomic) TGRDataSourceCellBlock configureCellBlock;

@end

@implementation TGRDataSource

- (id)initWithCellReuseIdentifier:(NSString *)reuseIdentifier
               configureCellBlock:(TGRDataSourceCellBlock)configureCellBlock
{
    self = [super init];
    
    if (self) {
        self.cellReuseIdentifier = reuseIdentifier;
        self.configureCellBlock = configureCellBlock;
    }
    
    return self;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath {
    [self subclassResponsibility:_cmd];
    return nil;
}

- (NSIndexPath *)indexPathForItem:(id)item {
    [self subclassResponsibility:_cmd];
    return nil;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    [self subclassResponsibility:_cmd];
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id item = [self itemAtIndexPath:indexPath];
    NSString * reuseIdentifier = self.cellReuseIdentifier;
    if (!reuseIdentifier)
        reuseIdentifier = [self.delegate dataSource:self reuseIdentifierForItem:item];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier
                                                            forIndexPath:indexPath];
    
    if (self.configureCellBlock) {
        self.configureCellBlock(cell, item);
    }
    
    return cell;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    [self subclassResponsibility:_cmd];
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    id item = [self itemAtIndexPath:indexPath];
    NSString * reuseIdentifier = self.cellReuseIdentifier;
    if (!reuseIdentifier)
        reuseIdentifier = [self.delegate dataSource:self reuseIdentifierForItem:item];
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                                                           forIndexPath:indexPath];
    
    if (self.configureCellBlock) {
        self.configureCellBlock(cell, item);
    }
    
    return cell;
}

@end
