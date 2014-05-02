//  TGRFetchedResultsCollectionViewController.m
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

#import "TGRFetchedResultsCollectionViewController.h"
#import "TGRFetchedResultsDataSource.h"

@interface TGRFetchedResultsCollectionViewController ()

@property (strong, nonatomic) NSMutableIndexSet *insertedSections;
@property (strong, nonatomic) NSMutableIndexSet *deletedSections;
@property (strong, nonatomic) NSMutableArray *insertedItems;
@property (strong, nonatomic) NSMutableArray *deletedItems;
@property (strong, nonatomic) NSMutableArray *updatedItems;

@end

@implementation TGRFetchedResultsCollectionViewController


#pragma mark - Properties

- (void)setDataSource:(TGRFetchedResultsDataSource *)dataSource {
    if (_dataSource != dataSource) {
        _dataSource.fetchedResultsController.delegate = nil;
        _dataSource = dataSource;
        _dataSource.fetchedResultsController.delegate = self;
        
        self.collectionView.dataSource = dataSource;
        [self performFetch];
    }
}

#pragma mark - Lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        _contentAnimationMaximumChangeCount = 100;
    }
    
    return self;
}

- (void)performFetch {
    if (self.dataSource) {
        NSError *error = nil;
        [self.dataSource.fetchedResultsController performFetch:&error];
        NSAssert(error == nil, @"%@ performFetch: %@", self, error);
    }
    
    [self.collectionView reloadData];
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)  controller:(NSFetchedResultsController *)controller
    didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
             atIndex:(NSUInteger)sectionIndex
       forChangeType:(NSFetchedResultsChangeType)type {
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.insertedSections addIndex:sectionIndex];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.deletedSections addIndex:sectionIndex];
            break;
            
        default:
            break;
    }
}

- (void) controller:(NSFetchedResultsController *)controller
    didChangeObject:(id)anObject
        atIndexPath:(NSIndexPath *)indexPath
      forChangeType:(NSFetchedResultsChangeType)type
       newIndexPath:(NSIndexPath *)newIndexPath {
    switch (type) {
        case NSFetchedResultsChangeInsert:
            if (![self.insertedSections containsIndex:(NSUInteger)newIndexPath.section]) {
                [self.insertedItems addObject:newIndexPath];
            }
            break;
            
        case NSFetchedResultsChangeDelete:
            if (![self.deletedSections containsIndex:(NSUInteger)indexPath.section]) {
                [self.deletedItems addObject:indexPath];
            }
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self.updatedItems addObject:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            if (![self.insertedSections containsIndex:(NSUInteger)newIndexPath.section]) {
                [self.insertedItems addObject:newIndexPath];
            }
            if (![self.deletedSections containsIndex:(NSUInteger)indexPath.section]) {
                [self.deletedItems addObject:indexPath];
            }
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    NSUInteger changeCount = self.insertedSections.count +
    self.deletedSections.count +
    self.insertedItems.count +
    self.deletedItems.count +
    self.updatedItems.count;
    
    if (changeCount <= self.contentAnimationMaximumChangeCount) {
        [self.collectionView performBatchUpdates:^{
            [self.collectionView deleteSections:self.deletedSections];
            [self.collectionView insertSections:self.insertedSections];
            [self.collectionView deleteItemsAtIndexPaths:self.deletedItems];
            [self.collectionView insertItemsAtIndexPaths:self.insertedItems];
            [self.collectionView reloadItemsAtIndexPaths:self.updatedItems];
        } completion:nil];
    }
    else {
        [self.collectionView reloadData];
    }
    
    self.insertedSections = nil;
    self.deletedSections = nil;
    self.insertedItems = nil;
    self.deletedItems = nil;
    self.updatedItems = nil;
}

#pragma mark - Private

- (NSMutableIndexSet *)insertedSections {
    if (!_insertedSections) {
        _insertedSections = [[NSMutableIndexSet alloc] init];
    }
    return _insertedSections;
}

- (NSMutableIndexSet *)deletedSections {
    if (!_deletedSections) {
        _deletedSections = [[NSMutableIndexSet alloc] init];
    }
    return _deletedSections;
}

- (NSMutableArray *)insertedItems {
    if (!_insertedItems) {
        _insertedItems = [[NSMutableArray alloc] init];
    }
    return _insertedItems;
}

- (NSMutableArray *)deletedItems {
    if (!_deletedItems) {
        _deletedItems = [[NSMutableArray alloc] init];
    }
    return _deletedItems;
}

- (NSMutableArray *)updatedItems {
    if (!_updatedItems) {
        _updatedItems = [[NSMutableArray alloc] init];
    }
    return _updatedItems;
}

@end
