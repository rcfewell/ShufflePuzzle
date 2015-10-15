//
//  ShuffleBrain.h
//  ShufflePuzzle
//
//  Created by Riley Fewell on 2/17/15.
//  Copyright (c) 2015 Riley Fewell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShuffleBrain : NSObject

@property (nonatomic, strong) NSMutableArray *solutionBoard;
@property (nonatomic, strong) NSMutableArray *currentBoard;
@property (nonatomic) int tilesToShuffle;

- (void) createSolutionAndCurrentBoards: (NSMutableArray *) solutionBoard;
- (void) moveTileRight;
- (void) moveTileLeft;
- (void) moveTileUp;
- (void) moveTileDown;
- (void) shuffleTiles: (int) difficulty; 
- (void) resetCurrentBoard: (int) tile;
@end
