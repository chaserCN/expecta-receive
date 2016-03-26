
@interface ORObject : NSObject
@property (nonatomic, assign) CGRect rect;
@property (nonatomic, assign) SEL selector;
@property (nonatomic, assign) NSInteger integer;
@property (nonatomic, assign) float floatValue;
@property (nonatomic, strong) NSString *string;

@property (nonatomic, assign) NSInteger counter;

@end

@implementation ORObject

- (void)methodVoid {};

- (CGRect)rect {
    return CGRectMake(1, 11, 111, 1111);
}

- (void)setRect:(CGRect)rect {}

- (SEL)selector {
    return @selector(methodVoid);
};

- (void)setSelector:(SEL)selector {}

- (NSInteger)integer {
    return 12;
}

- (float)floatValue {
    return 4.22;
}

- (void)setFloatValue:(float)floatValue {}

- (NSString *)string {
    return @"text";
}

- (NSString *)string2 {
    return @"text";
}

- (void)setString:(NSString *)string {}

- (void)methodWithString:(NSString *)aString number:(NSNumber *)aNumber {}
- (void)methodWithIntArg:(NSInteger)anInt string:(NSString *)aString number:(NSNumber *)aNumber {}

- (id)methodReturningNil {
    return nil;
}

- (NSInteger)increasedCounter {
    return ++self.counter;
}

- (BOOL)methodWithInt:(NSInteger)anInt {
    return true;
}

@end

SpecBegin(ExpectaOCMockMatchers)

__block ORObject *sut;

before(^{
    sut = [[ORObject alloc] init];
});

context(@"tests that should succeed", ^{
    it(@"method call", ^{
        expect(sut).method(methodVoid).to.beCalled();
        [sut methodVoid];
    });
    
    fit(@"checks for arguments and return value", ^{
        expect(sut).method(methodWithInt:).with(1).returning(YES).to.beCalled();
        [sut methodWithInt:1];
    });
    
    context(@"getters/setters", ^{
        it(@"check for a rect return", ^{
            expect(sut).method(rect).returning(CGRectMake(1, 11, 111, 1111)).to.beCalled();
            [sut rect];
        });
        
        it(@"check for a rect argument", ^{
            expect(sut).method(setRect:).with(CGRectMake(11, 34, 15, 1001)).to.beCalled();
            [sut setRect:CGRectMake(11, 34, 15, 1001)];
        });
        
        it(@"check for a selector return", ^{
            expect(sut).method(selector).returning(@selector(methodVoid)).to.beCalled();
            [sut selector];
        });
        
        it(@"check for a selector argument", ^{
            expect(sut).method(setSelector:).with(@selector(date)).to.beCalled();
            [sut setSelector:@selector(date)];
        });
        
        it(@"check for an int return", ^{
            expect(sut).method(integer).returning(12).to.beCalled();
            [sut integer];
        });
        
        it(@"check for an int argument", ^{
            expect(sut).method(setInteger:).with(17).to.beCalled();
            [sut setInteger:17];
        });
        
        it(@"check for a float return", ^{
            expect(sut).method(floatValue).returning(4.22).to.beCalled();
            [sut floatValue];
        });
        
        it(@"check for a float argument", ^{
            expect(sut).method(setFloatValue:).with(11.98).to.beCalled();
            [sut setFloatValue:11.98];
        });
        
        it(@"check for a string return", ^{
            expect(sut).method(string).returning(@"text").to.beCalled();
            [sut string];
        });
        
        it(@"check for a string argument", ^{
            expect(sut).method(setString:).with(@"some string").to.beCalled();
            [sut setString:@"some string"];
        });
    });
    
    context(@"nil values", ^{
        it(@"checks for nil arguments", ^{
            expect(sut).method(setString:).with(nil).to.beCalled();
            [sut setString:nil];
        });
        
        it(@"checks for nil return", ^{
            expect(sut).method(methodReturningNil).returning(nil).to.beCalled();
            [sut methodReturningNil];
        });
    });
    
    context(@"any values", ^{
        it(@"checks for any() arguments", ^{
            expect(sut).method(methodWithIntArg:string:number:).with(any(), any(), any()).to.beCalled();
            [sut methodWithIntArg:1919 string:@"teststring" number:@198];
        });
    });
    
    context(@"skipped arguments", ^{
        it(@"skips with()", ^{
            expect(sut).method(methodWithIntArg:string:number:).to.beCalled();
            [sut methodWithIntArg:1919 string:@"teststring" number:@198];
        });

        it(@"skips returning()", ^{
            expect(sut).method(string2).to.beCalled();
            [sut string2];
        });

        it(@"skips arguments", ^{
            expect(sut).method(methodWithIntArg:string:number:).with(1919).to.beCalled();
            [sut methodWithIntArg:1919 string:@"teststring" number:@198];
        });
    });
    
    context(@"check for not()", ^{
        it(@"skips returning()", ^{
            expect(sut).method(string2).notTo.beCalled();
            [sut string];
        });
    });
    
    context(@"check will()", ^{
        it(@"async", ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [sut string2];
            });
            expect(sut).method(string2).will.beCalled();
        });
    });
    
    it(@"state", ^{
        expect(sut).method(increasedCounter).returning(1).to.beCalled();
        expect(sut).method(increasedCounter).returning(2).to.beCalled();
        expect(sut).method(increasedCounter).returning(3).to.beCalled();

        [sut increasedCounter];
        [sut increasedCounter];
        [sut increasedCounter];
    });
    
    it(@"2 mocks", ^{
        ORObject *a = [[ORObject alloc] init];
        ORObject *b = [[ORObject alloc] init];
        
        expect(a).method(setString:).with(@"a").to.beCalled();
        expect(b).method(setString:).with(@"b").to.beCalled();
        
        [a setString:@"a"];
        [b setString:@"b"];
    });

});

pending(@"It is expected that these tests will fail. That means they work properly-2", ^{
    it(@"check for a rect return", ^{
        expect(sut).method(rect).returning(CGRectMake(1, 12, 111, 1111)).to.beCalled();
        [sut rect];
    });
    
    it(@"check for a wrong rect argument", ^{
        expect(sut).method(setRect:).with(CGRectMake(11, 34, 15, 1001)).to.beCalled();
        [sut setRect:CGRectMake(10, 34, 13, 15)];
    });
    
    it(@"check for a selector return", ^{
        expect(sut).method(selector).returning(@selector(dateByAddingTimeInterval:)).to.beCalled();
        [sut selector];
    });
    
    it(@"check for a selector argument", ^{
        expect(sut).method(setSelector:).with(@selector(dateByAddingTimeInterval:)).to.beCalled();
        [sut setSelector:@selector(date)];
    });

    it(@"wrong arguments", ^{
        expect(sut).method(methodWithIntArg:string:number:).with(1919).to.beCalled();
        [sut methodWithIntArg:2020 string:@"teststring" number:@198];
    });
    
    it(@"check for missing call", ^{
        expect(sut).method(setSelector:).with(@selector(dateByAddingTimeInterval:)).to.beCalled();
    });
    
    it(@"checks for missing", ^{
        expect(sut).method(methodWithIntArg:string:number:).with(any(), any(), any()).to.beCalled();
    });

    it(@"check for missing return", ^{
        expect(sut).method(selector).returning(@selector(dateByAddingTimeInterval:)).to.beCalled();
    });

    it(@"check for a missing return", ^{
        expect(sut).method(string).returning(@"text").to.beCalled();
        [sut string2];
    });
    
    it(@"check for a string argument", ^{
        expect(sut).method(string).to.beCalled();
        [sut string2];
    });
    
    it(@"skips returning()", ^{
        expect(sut).method(string2).notTo.beCalled();
        [sut string2];
    });
    
    it(@"skips returning()", ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [sut string];
        });
        expect(sut).method(string2).will.beCalled();
    });
    
    it(@"state", ^{
        expect(sut).method(increasedCounter).returning(1).to.beCalled();
        expect(sut).method(increasedCounter).returning(2).to.beCalled();
        expect(sut).method(increasedCounter).returning(3).to.beCalled();
        
        [sut increasedCounter];
        [sut increasedCounter];
    });
    
    it(@"fails with the wrong arguments order", ^{
        expect(sut).method(methodWithString:number:).with(@3, @"thingy").to.beCalled();
        [sut methodWithString:@"thingy" number:@3];
    });
    
    it(@"fails if receives a value instead of nil", ^{
        expect(sut).method(methodWithString:number:).with(nil, @1).to.beCalled();
        [sut methodWithString:@"test" number:@1];
    });
    
    it(@"fails if receives nil instead of the value", ^{
        expect(sut).method(methodWithString:number:).with(@"test", @1).to.beCalled();
        [sut methodWithString:nil number:@1];
    });
    
    /// xode bug:
    
    it(@"check for a wrong rect argument", ^{
        expect(sut)
        .method(setRect:)
        .with(CGRectMake(11, 34, 15, 1001))
        .to.beCalled();
        
        [sut setRect:CGRectMake(10, 34, 13, 15)];
    });
});

/*

it(@"CGSize", ^{
    expect(sut)
        .method(method14:selector:)
        .with(CGSizeMake(11, 34), @selector(method))
        .to.beCalled();
    
    [sut method14:CGSizeMake(11, 34) selector:@selector(method)];
});

it(@"CGRect", ^{
    expect(sut).method(method15:).with(CGRectMake(11, 34, 15, 57)).to.beCalled();
    [sut method15:CGRectMake(11, 34, 15, 57)];
});

it(@"selector", ^{
    expect(sut).method(method17i1).returning(@selector(method1)).to.beCalled();
    [sut method17i1];
});

it(@"selector", ^{
    expect(sut).method(method19).returning(nil).to.beCalled();
    [sut method19];
});

it(@"checks for a method", ^{
    expect(sut).method(method1).to.beCalled();
    [sut method1];
});

it(@"checks for a async method", ^{
    dispatch_async(dispatch_get_main_queue(), ^{
        [sut method1];
    });
    
    expect(sut).method(method1).will.beCalled();
});

it(@"checks for a return object", ^{
    expect(sut).method(method22).returning(5.1).to.beCalled();
    [sut method22];
});

fit(@"checks for a returned bool", ^{
    expect(sut).method(methodBool).returning(YES).to.beCalled();
    [sut methodBool];
});

it(@"checks for a return value bridged to an object", ^{
    expect(sut).method(method4).returning(23).to.beCalled();
    [sut method4];
});

it(@"checks for an argument to the method", ^{
    expect(sut).method(method3:).with(@"thing").to.beCalled();
    [sut method3:@"thing"];
});

__block ORObject *a;
__block ORObject *b;

beforeEach(^{
    a = [[ORObject alloc] init];
    b = [[ORObject alloc] init];
});

it(@"supports multiple invocations of @mockify", ^{
    expect(a).method(method3:).with(@"a").to.beCalled();
    expect(b).method(method3:).with(@"b").to.beCalled();

    [a method3:@"a"];
    [b method3:@"b"];
});

it(@"supports multiple invocations of @mockify", ^{
    expect(a).method(method5:arg2:).with(@"a", @1).to.beCalled();
    expect(b).method(method5:arg2:).with(@"b", @2).to.beCalled();
    
    [a method5:@"a" arg2:@1];
    [b method5:@"b" arg2:@2];
});

it(@"supports primitives", ^{
    expect(a).method(method11:arg2:).with(@"a", 1).to.beCalled();
    [a method11:@"a" arg2:1];
});

it(@"notto", ^{
    expect(a).method(method11:arg2:).with(@"a", 1).notTo.beCalled();
    [a method11:@"a" arg2:2];
});

it(@"supports nils", ^{
    expect(a).method(method11:arg2:).with(nil, 1).to.beCalled();
    [a method11:nil arg2:1];
});

it(@"supports any()", ^{
    expect(a).method(method11:arg2:).with(any(), any()).to.beCalled();
    [a method11:nil arg2:1];
});

it(@"succeeds if arguments are not important", ^{
    expect(a).method(method11:arg2:).to.beCalled();
    [a method11:nil arg2:1];
});

it(@"succeeds if arguments are skipped", ^{
    expect(a).method(method11:arg2:).with(@"test").to.beCalled();
    [a method11:@"test" arg2:1];
});

it(@"2 expects in one block", ^{
    expect(a).method(method12:arg2:arg3:arg4:).with(@"test", 1).to.beCalled();
    expect(a).method(method1).with(1, 2).to.beCalled();
    [a method12:@"test" arg2:1 arg3:2 arg4:3];
    [a method1];
});

context(@"It is expected that these tests will fail. That means they work properly", ^{
    it(@"fails when method is not called", ^{
        expect(sut).method(method2).to.beCalled();
        [sut method1];
    });
    
    it(@"fails when async method is not called", ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [sut method1];
        });
        
        expect(sut).method(method2).will.beCalled();
    });
    
    it(@"fails with the wrong return value", ^{
        expect(sut).method(method2).returning(@3).to.beCalled();
        [sut method2];
    });
    
    it(@"fails with the wrong argument value", ^{
        expect(sut).method(method3:).with(@"thingy").to.beCalled();
        [sut method3:@"thing"];
    });

    it(@"fails with the wrong arguments order", ^{
        expect(sut).method(method5:arg2:).with(@1, @"thingy").to.beCalled();
        [sut method5:@"thing" arg2:@1];
    });
    
    it(@"fails if receives a value instead of nil", ^{
        expect(a).method(method11:arg2:).with(nil, @1).to.beCalled();
        [a method11:@"test" arg2:1];
    });
    
    it(@"fails if receives nil instead of the value", ^{
        expect(a).method(method11:arg2:).with(@"test", @1).to.beCalled();
        [a method11:nil arg2:1];
    });

    it(@"fails if not called", ^{
        expect(a).method(method11:arg2:).with(@"test", @1).to.beCalled();
        [a method1];
    });

    it(@"fail if arguments are not important and not called", ^{
        expect(a).method(method11:arg2:).to.beCalled();
        [a method1];
    });

});
*/
 
SpecEnd

