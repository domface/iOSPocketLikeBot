//
// Created by Dominik Andrzejczuk on 6/30/14.
// Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface OAuth : NSObject
@property (strong, nonatomic) NSMutableString *theURL;
@property (strong, nonatomic) NSMutableArray *theList;
@property (nonatomic) NSUInteger picListCounter;
@property (nonatomic) NSUInteger global;
@property (nonatomic) NSUInteger accessTokenCounter;
@property (strong, nonatomic) NSString *strAccessToken;
@property (nonatomic) int currentToken;
@property (strong, nonatomic) NSMutableArray *accessTokenArray;
@property (strong, nonatomic) NSMutableArray *pictureArray;

- (void)request;

- (void)likeImagesInList;

@end