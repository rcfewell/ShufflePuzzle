//
//  ShuffleBrain.m
//  ShufflePuzzle
//
//  Created by Riley Fewell on 2/17/15.
//  Copyright (c) 2015 Riley Fewell. All rights reserved.
//

#import "ShuffleBrain.h"
#import <UIKit/UIKit.h>

@implementation ShuffleBrain{
    int previousMove;
}


- (NSMutableArray *) solutionBoard
{
    if( _solutionBoard == nil )
        _solutionBoard = [[NSMutableArray alloc] init];
    
    return _solutionBoard;
}

- (NSMutableArray *) currentBoard
{
    if( _currentBoard == nil )
        _currentBoard = [[NSMutableArray alloc] init];
    
    return _currentBoard;
}

- (void) createSolutionAndCurrentBoards: (NSMutableArray *) solutionBoard
{
    [self.solutionBoard setArray:solutionBoard];
    [self.currentBoard setArray:solutionBoard];

}

- (void) checkForWin
{
    if( [self.currentBoard isEqualToArray:self.solutionBoard] )
    {
        NSLog( @"We Have a winner" );
        [self performSelector:@selector(alertWinner) withObject:nil afterDelay:0.25];
//        [self alertWinner];
    }
}

- (void) alertWinner
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Genius" message:@"You solved the puzzle!!" delegate:self cancelButtonTitle:@"Play Again"
                                          otherButtonTitles:nil, nil];
    [alert show];
}

- (void) moveTileRight
{
    for( int i = 0; i < 16; i++)
    {
        if( [self.currentBoard objectAtIndex:i] == [self.solutionBoard objectAtIndex:15] && i % 4 != 0)
        {
            UIButton *firstTileToMove = [self.currentBoard objectAtIndex:i];
            UIButton *secondTileToMove = [self.currentBoard objectAtIndex:i - 1];
            
            CGPoint firstTileToMoveCenter = firstTileToMove.center;
            CGPoint secondTileToMoveCenter = secondTileToMove.center;
            
            [UIView animateWithDuration:0.25 animations:^{
                [[self.currentBoard objectAtIndex:i - 1]setCenter:firstTileToMoveCenter];
                [[self.currentBoard objectAtIndex:i]setCenter:secondTileToMoveCenter];
            }];
            
            [self.currentBoard exchangeObjectAtIndex:i withObjectAtIndex:i - 1];
            
            [self checkForWin];
            
            break;
        }
    }
}

- (void) moveTileLeft
{
    for( int i = 0; i < 16; i++ )
    {
        if( [self.currentBoard objectAtIndex:i] == [self.solutionBoard objectAtIndex:15] && i % 4 != 3 )
        {
            UIButton *firstTileToMove = [self.currentBoard objectAtIndex:i];
            UIButton *secondTileToMove = [self.currentBoard objectAtIndex:i + 1];
            
            CGPoint firstTileToMoveCenter = firstTileToMove.center;
            CGPoint secondTileToMoveCenter = secondTileToMove.center;
            
            [UIView animateWithDuration:0.25 animations:^{
                [[self.currentBoard objectAtIndex:i + 1]setCenter:firstTileToMoveCenter];
                [[self.currentBoard objectAtIndex:i]setCenter:secondTileToMoveCenter];
            }];
            
            [self.currentBoard exchangeObjectAtIndex:i withObjectAtIndex:i + 1];
            
            [self checkForWin];
            
            break;
            
            
        }
    }
    
}

- (void) moveTileUp
{
    for( int i = 0; i < 16; i++ )
    {
        if( [self.currentBoard objectAtIndex:i] == [self.solutionBoard objectAtIndex:15] && i < 12 )
        {
            UIButton *firstTileToMove = [self.currentBoard objectAtIndex:i];
            UIButton *secondTileToMove = [self.currentBoard objectAtIndex:i + 4];
            
            CGPoint firstTileToMoveCenter = firstTileToMove.center;
            CGPoint secondTileToMoveCenter = secondTileToMove.center;
            
            [UIView animateWithDuration:0.25 animations:^{
                [[self.currentBoard objectAtIndex:i + 4]setCenter:firstTileToMoveCenter];
                [[self.currentBoard objectAtIndex:i]setCenter:secondTileToMoveCenter];
            }];
            
            [self.currentBoard exchangeObjectAtIndex:i withObjectAtIndex:i + 4];
            
            [self checkForWin];
            
            break;
            
            
        }
    }
}

- (void) moveTileDown
{
    for( int i = 0; i < 16; i++ )
    {
        if( [self.currentBoard objectAtIndex:i] == [self.solutionBoard objectAtIndex:15] && i > 3 )
        {
            UIButton *firstTileToMove = [self.currentBoard objectAtIndex:i];
            UIButton *secondTileToMove = [self.currentBoard objectAtIndex:i - 4];
            
            CGPoint firstTileToMoveCenter = firstTileToMove.center;
            CGPoint secondTileToMoveCenter = secondTileToMove.center;
            
            [UIView animateWithDuration:0.25 animations:^{
                [[self.currentBoard objectAtIndex:i - 4]setCenter:firstTileToMoveCenter];
                [[self.currentBoard objectAtIndex:i]setCenter:secondTileToMoveCenter];
            }];
            
            [self.currentBoard exchangeObjectAtIndex:i withObjectAtIndex:i - 4];
            
            [self checkForWin];
            
            break;
            
            
        }
    }
    
}

- (void) shuffleTiles: (int) difficulty
{
    if( difficulty == 0 )
        return;
    
    
    [UIView animateWithDuration:0.25 animations:^{
        for( int i = 0; i < 16; i++ )
        {
            if( [self.currentBoard objectAtIndex:i] == [self.solutionBoard objectAtIndex:15] )
            {
                int randomDirection = arc4random() % 4;
                UIButton *firstTileToMove = [self.currentBoard objectAtIndex:i];
                
                NSLog( @"%d", randomDirection );
                
                if( ((randomDirection + 2) % 4) == previousMove )
                {
                    randomDirection += 1;
                    randomDirection %= 4;
                }
                
                previousMove = randomDirection;
                
                NSLog( @"After the comparison %d", randomDirection );
                
                if( randomDirection == 0 && i % 4 != 0 )
                {
                    UIButton *secondTileToMove = [self.currentBoard objectAtIndex:i - 1];
                    
                    CGPoint firstTileCenter = firstTileToMove.center;
                    CGPoint secondTileCenter = secondTileToMove.center;
                    
                    [[self.currentBoard objectAtIndex:i - 1]setCenter:firstTileCenter];
                    [[self.currentBoard objectAtIndex:i]setCenter:secondTileCenter];
                        
                    
                    [self.currentBoard exchangeObjectAtIndex:i withObjectAtIndex:i - 1];
                    break;
                }
                
                else if( randomDirection == 1 && i < 12 )
                {
                    UIButton *secondTileToMove = [self.currentBoard objectAtIndex:i + 4];
                    
                    CGPoint firstTileCenter = firstTileToMove.center;
                    CGPoint secondTileCenter = secondTileToMove.center;
                    
                    [[self.currentBoard objectAtIndex:i + 4]setCenter:firstTileCenter];
                    [[self.currentBoard objectAtIndex:i]setCenter:secondTileCenter];
                    
                    
                    [self.currentBoard exchangeObjectAtIndex:i withObjectAtIndex:i + 4];
                    
                    break;
                }
                
                else if( randomDirection == 2 && i % 4 != 3 )
                {
                    UIButton *secondTileToMove = [self.currentBoard objectAtIndex:i + 1];
                    
                    CGPoint firstTileCenter = firstTileToMove.center;
                    CGPoint secondTileCenter = secondTileToMove.center;
                    
                    [[self.currentBoard objectAtIndex:i + 1]setCenter:firstTileCenter];
                    [[self.currentBoard objectAtIndex:i]setCenter:secondTileCenter];
                        
                    
                    [self.currentBoard exchangeObjectAtIndex:i withObjectAtIndex:i + 1];
                    break;
                }
                
                
                else if( randomDirection == 3 && i > 3 )
                {
                    UIButton *secondTileToMove = [self.currentBoard objectAtIndex:i - 4];
                    
                    CGPoint firstTileCenter = firstTileToMove.center;
                    CGPoint secondTileCenter = secondTileToMove.center;
                    
                    [[self.currentBoard objectAtIndex:i - 4]setCenter:firstTileCenter];
                    [[self.currentBoard objectAtIndex:i]setCenter:secondTileCenter];
                        
                    
                    [self.currentBoard exchangeObjectAtIndex:i withObjectAtIndex:i - 4];
                    
                    break;
                }
//                previousMove = randomDirection;
            }
        }
    } completion:^(BOOL finished) {
        [self shuffleTiles:difficulty - 1];
    }];
    
}


- (void) resetCurrentBoard: (int) tile
{

    if( [self.currentBoard isEqualToArray:self.solutionBoard] )
        return;
    [UIView animateWithDuration:0.25 animations:^{
        for( int i = 0; i < 16; i++ )
        {
            if( [self.currentBoard objectAtIndex:tile] == [self.solutionBoard objectAtIndex:i] )
            {
                
                UIButton *firstTileToMove = [self.currentBoard objectAtIndex:tile];
                UIButton *secondTileToMove = [self.currentBoard objectAtIndex:i];
                
                CGPoint firstTileCenter = firstTileToMove.center;
                CGPoint secondTileCenter = secondTileToMove.center;
            
                [[self.currentBoard objectAtIndex:i]setCenter:firstTileCenter];
                [[self.currentBoard objectAtIndex:tile]setCenter:secondTileCenter];
                
                [self.currentBoard exchangeObjectAtIndex:tile withObjectAtIndex:i];
            }
            
        }
    } completion:^(BOOL finished) {
        [self resetCurrentBoard:arc4random() % 15];
    }];
    
    
    
}



@end
