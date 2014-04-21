// TGRFetchedResultsTableViewController.m
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

#import "TGRFetchedResultsTableViewController.h"
#import "TGRFetchedResultsDataSource.h"

@interface TGRFetchedResultsTableViewController ()

@property (strong, nonatomic) NSMutableIndexSet *insertedSections;
@property (strong, nonatomic) NSMutableIndexSet *deletedSections;
@property (strong, nonatomic) NSMutableArray *insertedRows;
@property (strong, nonatomic) NSMutableArray *deletedRows;
@property (strong, nonatomic) NSMutableArray *updatedRows;

@end

@implementation TGRFetchedResultsTableViewController

#pragma mark - Properties

- (void)setDataSource:(TGRFetchedResultsDataSource *)dataSource {
    if (_dataSource != dataSource) {
        _dataSource.fetchedResultsController.delegate = nil;
        _dataSource = dataSource;
        _dataSource.fetchedResultsController.delegate = self;
        
        self.tableView.dataSource = dataSource;
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
    
    [self.tableView reloadData];
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
                [self.insertedRows addObject:newIndexPath];
            }
            break;

        case NSFetchedResultsChangeDelete:
            if (![self.deletedSections containsIndex:(NSUInteger)indexPath.section]) {
                [self.deletedRows addObject:indexPath];
            }
            break;

        case NSFetchedResultsChangeUpdate:
            [self.updatedRows addObject:indexPath];
            break;

        case NSFetchedResultsChangeMove:
            if (![self.insertedSections containsIndex:(NSUInteger)newIndexPath.section]) {
                [self.insertedRows addObject:newIndexPath];
            }
            if (![self.deletedSections containsIndex:(NSUInteger)indexPath.section]) {
                [self.deletedRows addObject:indexPath];
            }
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    NSUInteger changeCount = self.insertedSections.count +
        self.deletedSections.count +
        self.insertedRows.count +
        self.deletedRows.count +
        self.updatedRows.count;
    
    if (changeCount <= self.contentAnimationMaximumChangeCount) {
        [self.tableView beginUpdates];
        [self.tableView deleteSections:self.deletedSections withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView insertSections:self.insertedSections withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView deleteRowsAtIndexPaths:self.deletedRows withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView insertRowsAtIndexPaths:self.insertedRows withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView reloadRowsAtIndexPaths:self.updatedRows withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView endUpdates];
    }
    else {
        [self.tableView reloadData];
    }
    
    self.insertedSections = nil;
    self.deletedSections = nil;
    self.insertedRows = nil;
    self.deletedRows = nil;
    self.updatedRows = nil;
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

- (NSMutableArray *)insertedRows {
    if (!_insertedRows) {
        _insertedRows = [[NSMutableArray alloc] init];
    }
    return _insertedRows;
}

- (NSMutableArray *)deletedRows {
    if (!_deletedRows) {
        _deletedRows = [[NSMutableArray alloc] init];
    }
    return _deletedRows;
}

- (NSMutableArray *)updatedRows {
    if (!_updatedRows) {
        _updatedRows = [[NSMutableArray alloc] init];
    }
    return _updatedRows;
}

@end
