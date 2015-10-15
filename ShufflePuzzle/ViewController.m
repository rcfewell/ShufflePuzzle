//
//  ViewController.m
//  ShufflePuzzle
//
//  Created by Riley Fewell on 2/17/15.
//  Copyright (c) 2015 Riley Fewell. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    float difficultyLevel;
}

@property (weak, nonatomic) IBOutlet UIButton *tile1;
@property (weak, nonatomic) IBOutlet UIButton *tile2;
@property (weak, nonatomic) IBOutlet UIButton *tile3;
@property (weak, nonatomic) IBOutlet UIButton *tile4;
@property (weak, nonatomic) IBOutlet UIButton *tile5;
@property (weak, nonatomic) IBOutlet UIButton *tile6;
@property (weak, nonatomic) IBOutlet UIButton *tile7;
@property (weak, nonatomic) IBOutlet UIButton *tile8;
@property (weak, nonatomic) IBOutlet UIButton *tile9;
@property (weak, nonatomic) IBOutlet UIButton *tile10;
@property (weak, nonatomic) IBOutlet UIButton *tile11;
@property (weak, nonatomic) IBOutlet UIButton *tile12;
@property (weak, nonatomic) IBOutlet UIButton *tile13;
@property (weak, nonatomic) IBOutlet UIButton *tile14;
@property (weak, nonatomic) IBOutlet UIButton *tile15;
@property (weak, nonatomic) IBOutlet UIButton *blankTile;

@property (weak, nonatomic) IBOutlet UIButton *shuffleButton;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
@property (weak, nonatomic) IBOutlet UISlider *DifficultySlider;

@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipe;
@property (nonatomic, strong) UISwipeGestureRecognizer *leftSwipe;
@property (nonatomic, strong) UISwipeGestureRecognizer *upSwipe;
@property (nonatomic, strong) UISwipeGestureRecognizer *downSwipe;

@property (nonatomic, strong) ShuffleBrain *shuffleBrain;
@property (nonatomic, strong) NSMutableArray *solutionBoard;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setTileBorderWidth];
    [self setTileBorderColor];
    
    [self initializeSwipeObjects];
    
    [self setDifficultyLevel];
    
    [self.shuffleBrain createSolutionAndCurrentBoards:self.solutionBoard];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (ShuffleBrain *) shuffleBrain
{
    if( _shuffleBrain == nil )
        _shuffleBrain = [[ShuffleBrain alloc] init];
    
    return _shuffleBrain;
}

- (NSMutableArray *) solutionBoard
{
    if( _solutionBoard == nil )
    {
        _solutionBoard = [[NSMutableArray alloc] initWithObjects:self.tile1, self.tile2, self.tile3, self.tile4, self.tile5,
                          self.tile6, self.tile7, self.tile8, self.tile9, self.tile10, self.tile11, self.tile12,
                          self.tile13, self.tile14, self.tile15, self.blankTile, nil];
    }
    
    return _solutionBoard;
}


- (IBAction)didPressShuffleButton:(UIButton *)sender
{
    NSLog(@"Did Press shuffle button" );
    float sliderValue = [self.DifficultySlider value];
    int difficulty = sliderValue * 50;
    [self.shuffleBrain shuffleTiles:difficulty];
}

- (IBAction)didPressResetButton:(UIButton *)sender
{
    NSLog( @"Did Press Reset Button" );
    [self.shuffleBrain resetCurrentBoard:15];
    
}


- (IBAction)didSlideDifficultySlider:(UISlider *)sender
{
    NSLog(@"did Slide difficulty slider. Value is %@", @( [self.DifficultySlider value] ) );
    difficultyLevel = [self.DifficultySlider value];
    
}


- (UISwipeGestureRecognizer *) rightSwipe
{
    if( _rightSwipe == nil )
    {
        _rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeRight:)];
        [_rightSwipe setDirection:UISwipeGestureRecognizerDirectionRight];
    }
    
    return _rightSwipe;
}

- (UISwipeGestureRecognizer *) leftSwipe
{
    if( _leftSwipe == nil )
    {
        _leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeLeft:)];
        [_leftSwipe setDirection:UISwipeGestureRecognizerDirectionLeft];
    }
    
    return _leftSwipe;
}

- (UISwipeGestureRecognizer *) upSwipe
{
    if( _upSwipe == nil )
    {
        _upSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeUp:)];
        [_upSwipe setDirection:UISwipeGestureRecognizerDirectionUp];
    }
    
    return _upSwipe;
}

- (UISwipeGestureRecognizer *) downSwipe
{
    if( _downSwipe == nil )
    {
        _downSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeDown:)];
        [_downSwipe setDirection:UISwipeGestureRecognizerDirectionDown];
    }
    
    return _downSwipe;
}

- (void) initializeSwipeObjects
{
    [self.view addGestureRecognizer:self.rightSwipe];
    [self.view addGestureRecognizer:self.leftSwipe];
    [self.view addGestureRecognizer:self.upSwipe];
    [self.view addGestureRecognizer:self.downSwipe];
}

- (void) didSwipeRight: (UISwipeGestureRecognizer *) swipeObject
{
    NSLog(@"Did swipe right" );
    [self.shuffleBrain moveTileRight];
}

- (void) didSwipeLeft: (UISwipeGestureRecognizer *) swipeObject
{
    NSLog(@"Did Swipe Left" );
    [self.shuffleBrain moveTileLeft];
}

- (void) didSwipeUp: (UISwipeGestureRecognizer *) swipeObject
{
    NSLog(@"Did swipe up" );
    [self.shuffleBrain moveTileUp];
}

- (void) didSwipeDown: (UISwipeGestureRecognizer *) swipeObject
{
    NSLog(@"Did Swipe Down" );
    [self.shuffleBrain moveTileDown];
}

- (void) setDifficultyLevel
{
    difficultyLevel = [self.DifficultySlider value];
}


- (void) setTileBorderWidth
{
    self.tile1.layer.borderWidth = 2;
    self.tile2.layer.borderWidth = 2;
    self.tile3.layer.borderWidth = 2;
    self.tile4.layer.borderWidth = 2;
    self.tile5.layer.borderWidth = 2;
    self.tile6.layer.borderWidth = 2;
    self.tile7.layer.borderWidth = 2;
    self.tile8.layer.borderWidth = 2;
    self.tile9.layer.borderWidth = 2;
    self.tile10.layer.borderWidth = 2;
    self.tile11.layer.borderWidth = 2;
    self.tile12.layer.borderWidth = 2;
    self.tile13.layer.borderWidth = 2;
    self.tile14.layer.borderWidth = 2;
    self.tile15.layer.borderWidth = 2;
    self.blankTile.layer.borderWidth = 2;
    
    self.shuffleButton.layer.borderWidth = 2;
    self.shuffleButton.layer.cornerRadius = 5;
    
}

- (void) setTileBorderColor
{
    self.tile1.layer.borderColor = [UIColor cyanColor].CGColor;
    self.tile2.layer.borderColor = [UIColor cyanColor].CGColor;
    self.tile3.layer.borderColor = [UIColor cyanColor].CGColor;
    self.tile4.layer.borderColor = [UIColor cyanColor].CGColor;
    self.tile5.layer.borderColor = [UIColor cyanColor].CGColor;
    self.tile6.layer.borderColor = [UIColor cyanColor].CGColor;
    self.tile7.layer.borderColor = [UIColor cyanColor].CGColor;
    self.tile8.layer.borderColor = [UIColor cyanColor].CGColor;
    self.tile9.layer.borderColor = [UIColor cyanColor].CGColor;
    self.tile10.layer.borderColor = [UIColor cyanColor].CGColor;
    self.tile11.layer.borderColor = [UIColor cyanColor].CGColor;
    self.tile12.layer.borderColor = [UIColor cyanColor].CGColor;
    self.tile13.layer.borderColor = [UIColor cyanColor].CGColor;
    self.tile14.layer.borderColor = [UIColor cyanColor].CGColor;
    self.tile15.layer.borderColor = [UIColor cyanColor].CGColor;
    self.blankTile.layer.borderColor = [UIColor cyanColor].CGColor;
    self.shuffleButton.layer.borderColor = [UIColor cyanColor].CGColor;
    
}

@end
