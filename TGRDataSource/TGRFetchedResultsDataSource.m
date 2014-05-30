// TGRFetchedResultsDataSource.m
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

#import "TGRFetchedResultsDataSource.h"

@implementation TGRFetchedResultsDataSource

- (id)initWithFetchedResultsController:(NSFetchedResultsController *)controller
                   cellReuseIdentifier:(NSString *)reuseIdentifier
                    configureCellBlock:(TGRDataSourceCellBlock)configureCellBlock
{
    self = [super initWithCellReuseIdentifier:reuseIdentifier configureCellBlock:configureCellBlock];
    
    if (self) {
        _fetchedResultsController = controller;
    }
    
    return self;
}

- (id)initWithFetchedResultsController:(NSFetchedResultsController *)controller
                  reuseIdentifierBlock:(TGRDataSourceReuseIdentifierBlock)reuseIdentifierBlock
                    configureCellBlock:(TGRDataSourceCellBlock)configureCellBlock
{
    self = [super initWithReuseIdentifierBlock:reuseIdentifierBlock
                            configureCellBlock:configureCellBlock];
    
    if (self) {
        _fetchedResultsController = controller;
    }
    
    return self;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath {
    return [self.fetchedResultsController objectAtIndexPath:indexPath];
}

- (NSIndexPath *)indexPathForItem:(id)item {
    return [self.fetchedResultsController indexPathForObject:item];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.fetchedResultsController.sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id<NSFetchedResultsSectionInfo> sectionInfo = self.fetchedResultsController.sections[section];
    return [sectionInfo numberOfObjects];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.fetchedResultsController.sections count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    id<NSFetchedResultsSectionInfo> sectionInfo = self.fetchedResultsController.sections[section];
    return [sectionInfo numberOfObjects];
}

@end
