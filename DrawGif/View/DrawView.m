//
//  DrawView.m
//  DrawGif
//
//  Created by ibokan on 15/9/1.
//  Copyright (c) 2015年 rick. All rights reserved.
//

#import "DrawView.h"
#import "EditViewController.h"

@implementation DrawView
@synthesize lines = lines ;

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
        self.userInteractionEnabled = YES;
        self.multipleTouchEnabled = YES ;
        lines = [NSMutableArray array];
        //注册通知接受者
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(colorChangeNotiofcationAction:) name:ColorChangeNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(repealNotificationAction:) name:RepealNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(lineWidthChangeNotificationAction:) name:LineWithChangeNotification object:nil];
        
    }
    return self ;
}
//-(void)setBackgroundImage:(UIImage *)backgroundImage{
//    self->_backgroundImage = backgroundImage;
//    self.backgroundColor = [UIColor colorWithPatternImage:self->_backgroundImage];
//    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.bounds];
//    imageView.image = self->_backgroundImage;
//    imageView.alpha = 0;
//    [self addSubview:imageView];
//}
- (void)drawRect:(CGRect)rect {
    
    
    [self.backgroundImage drawInRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    for (int i = 0 ; i < lines.count; i++)
    {
        NSMutableArray *points = [lines[i] objectForKey:@"points"];
        
        UIColor *strokeColor = [[lines objectAtIndex:i] objectForKey:@"lineColor"];
        CGContextSetStrokeColorWithColor(context,strokeColor.CGColor);
        
        CGContextSetLineWidth(context, [[lines[i] objectForKey:@"lineWidth"] floatValue]);

        CGContextMoveToPoint(context, [points[0] CGPointValue].x, [points[0] CGPointValue].y);
        
        for (int j = 1 ; j < points.count; j++)
        {
            CGContextAddLineToPoint(context, [points[j] CGPointValue].x, [points[j] CGPointValue].y);
        }
        CGContextStrokePath(context);
    }  
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSMutableArray *points = [NSMutableArray array];
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    [points addObject:[NSValue valueWithCGPoint:point]];
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    [dictionary setObject:points forKey:@"points"];
    if (lineColor == nil)
    {
        lineColor = [UIColor blackColor];
        [dictionary setObject:lineColor forKey:@"lineColor"];
    }
    else
    {
    [dictionary setObject:lineColor forKey:@"lineColor"];
    }
    if (lineWidth == nil)
    {
        lineWidth = @(2);
        [dictionary setObject:lineWidth forKey:@"lineWidth"];
    }
    else
    {
        [dictionary setObject:lineWidth forKey:@"lineWidth"];
    }
    [lines addObject:dictionary];
    
    [EditViewController new].titleView.hidden = YES ;
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSMutableArray *points = [[lines lastObject] objectForKey:@"points"];
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    [points addObject:[NSValue valueWithCGPoint:point]];
    
    //调用drawRect方法
    [self setNeedsDisplay];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

#pragma mark -------通知------------------
-(void)colorChangeNotiofcationAction:(NSNotification *)sender
{
    lineColor = [UIColor colorWithRed:[sender.userInfo[@"R"] floatValue] green:[sender.userInfo[@"G"] floatValue] blue:[sender.userInfo[@"B"] floatValue] alpha:1] ;
}

-(void)repealNotificationAction:(NSNotification *)sender
{
//    [lines removeLastObject];
    [self setNeedsDisplay];
}

-(void)lineWidthChangeNotificationAction:(NSNotification *)sender
{
    lineWidth = [[sender userInfo]objectForKey:@"lineWidth"] ;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ColorChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:RepealNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:LineWithChangeNotification object:nil];
}
@end








