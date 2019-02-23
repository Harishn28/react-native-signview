//
//  SignView.m
//  ReactNativeSignView
//
//  Created by Harish on 20/02/19.
//  Copyright © 2019 Tekion. All rights reserved.
//

#import "SignView.h"
#include <math.h>

@implementation SignView{
    UIBezierPath* currentPath;
    CAShapeLayer* pathLayer;
}
@synthesize delegate;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void) commonInit{
    self.backgroundColor = nil;
    pathLayer = [[CAShapeLayer alloc] init];
    currentPath = [[UIBezierPath alloc] init];
    pathLayer.path = [currentPath CGPath];
    pathLayer.strokeColor = [UIColor blackColor].CGColor;
    pathLayer.lineWidth = 2;
    [self.layer addSublayer:pathLayer];
    
    UIGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
    [self addGestureRecognizer:tap];
}

- (void)onTap:(UITapGestureRecognizer*)sender {
    CGPoint location = [sender locationInView:self];
    [currentPath moveToPoint:location];
    [currentPath addArcWithCenter:location radius:1 startAngle:0 endAngle:(M_PI * 2) clockwise:true];
    [self drawPaths];
    [self onSignatureChange];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:touch.view];
    [currentPath moveToPoint:location];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:touch.view];
    
    CGFloat width = [self bounds].size.width;
    CGFloat height = [self bounds].size.height;
    
    if(location.x > 0 && location.x < width &&
       location.y > 0 && location.y < height){
        [currentPath addLineToPoint:location];
        [currentPath moveToPoint:location];
        [self drawPaths];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:touch.view];
    [currentPath moveToPoint:location];
    [self drawPaths];
    [self onSignatureChange];
}

-(void)drawPaths{
    pathLayer.path = [currentPath CGPath];
}

-(UIImage*) rotateImage:(UIImage *)image : (CGFloat) rotation{
    CGAffineTransform t = CGAffineTransformMakeRotation(rotation);
    CGRect sizeRect = (CGRect) {.size = image.size};
    CGRect destRect = CGRectApplyAffineTransform(sizeRect, t);
    CGSize destinationSize = destRect.size;
    
    UIGraphicsBeginImageContext(destinationSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, destinationSize.width / 2.0f, destinationSize.height / 2.0f);
    CGContextRotateCTM(context, rotation);
    [image drawInRect:CGRectMake(-image.size.width / 2.0f, -image.size.height / 2.0f, image.size.width, image.size.height)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


-(UIImage *)getSignatureImage{
    if(currentPath.isEmpty) return nil;
    else{
        CGRect signBounds = currentPath.bounds;
        CGFloat width = signBounds.origin.x + signBounds.size.width;
        CGFloat height = signBounds.origin.y + signBounds.size.height;
        
        UIGraphicsBeginImageContext(CGSizeMake(width, height));
        [pathLayer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage* signatureImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        CGRect signatureBoundingRect = [currentPath bounds];
        CGImageRef imageRef = CGImageCreateWithImageInRect(signatureImage.CGImage, signatureBoundingRect);
        UIImage *croppedImage   = [UIImage imageWithCGImage:imageRef];
        CGImageRelease(imageRef);
        
        return croppedImage;
    }
}

-(NSString *)getBase64StringOfImage:(UIImage *)image{
    NSData* nsDataOfImage = UIImagePNGRepresentation(image);
    NSString * base64StringOfImage = [nsDataOfImage base64EncodedStringWithOptions:0];
    return base64StringOfImage;
}

-(void)onSignatureChange{
    if([self delegate] != nil){
        UIImage* image = [self getSignatureImage];
        NSString * base64StringOfImage = [self getBase64StringOfImage:image];
        [self.delegate onSignatureChangesCb:base64StringOfImage];
    }
}

- (void)setSignatureColor: (UIColor*) signColor{
    pathLayer.strokeColor = signColor.CGColor;
}

- (void)clearSignature{
    [currentPath removeAllPoints];
    [self drawPaths];
}

@end
