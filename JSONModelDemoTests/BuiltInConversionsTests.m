//
//  BuiltInConversionsTests.m
//  JSONModelDemo
//
//  Created by Marin Todorov on 02/12/2012.
//  Copyright (c) 2012 Underplot ltd. All rights reserved.
//

#import "BuiltInConversionsTests.h"
#import "BuiltInConversionsModel.h"

@implementation BuiltInConversionsTests
{
    BuiltInConversionsModel* b;
}

-(void)setUp
{
    [super setUp];
    
    NSString* filePath = [[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:@"converts.json"];
    NSString* jsonContents = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    NSAssert(jsonContents, @"Can't fetch test data file contents.");
    
    @try {
        b = [[BuiltInConversionsModel alloc] initWithString: jsonContents];
    }
    @catch (NSException* e1) {
        NSAssert1(NO, @"%@", [e1 debugDescription]);
    }
    
    
    NSAssert(b, @"Could not load the test data file.");
}

-(void)testConversions
{
    NSAssert(b.isItYesOrNo==YES, @"isItYesOrNo value is not YES");
    
    NSAssert([b.unorderedList isKindOfClass:[NSSet class]], @"unorderedList is not an NSSet object");
    NSAssert([b.unorderedList anyObject], @"unorderedList don't have any objects");
    
    NSAssert([b.dynamicUnorderedList isKindOfClass:[NSMutableSet class]], @"dynamicUnorderedList is not an NSMutableSet object");
    NSAssert([b.dynamicUnorderedList anyObject], @"dynamicUnorderedList don't have any objects");
    
    int nrOfObjects = [b.dynamicUnorderedList allObjects].count;
    [b.dynamicUnorderedList addObject:@"ADDED"];
    NSAssert(nrOfObjects + 1 == [b.dynamicUnorderedList allObjects].count, @"dynamicUnorderedList didn't add an object");
    
    NSAssert([b.stringFromNumber isKindOfClass:[NSString class]], @"stringFromNumber is not an NSString");
    NSAssert([b.stringFromNumber isEqualToString:@"19.95"], @"stringFromNumber's value is not 19.95");
    
    NSAssert([b.numberFromString isKindOfClass:[NSNumber class]], @"numberFromString is not an NSNumber");
    
    //TODO: I had to hardcode the float epsilon below, bcz actually [NSNumber floatValue] was returning a bigger deviation than FLT_EPSILON
    // IDEAS?
    NSAssert(fabsf([b.numberFromString floatValue]-1230.99)<0.001, @"numberFromString's value is not 1230.99");
    
    NSAssert([b.importantEvent isKindOfClass:[NSDate class]], @"importantEvent is not an NSDate");
    NSAssert((long)[b.importantEvent timeIntervalSince1970] == 1353916801, @"importantEvent value was not read properly");
    
}

@end
