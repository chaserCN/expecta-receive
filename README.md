Expecta-OCMock
==============

[Expecta](https://github.com/specta/expecta) matchers for [OCMock 3.x](https://github.com/erikdoe/ocmock).
Based on [Expecta+OCMock] (https://github.com/dblock/ocmock-expecta)

Differences from Expecta+OCMock:
- Does not call the method one more time at the end of the test. 
- Supports asynchronous methods.
- Does not need @mockify to be called on the object.

## Examples

```objc
// First check that a method is called
// Note: it will still call said method in the test. It's not stubbed.
// These never stub.

it(@"checks for a method", ^{
    expect(sut).method(setInteger:).to.beCalled();
    [sut setInteger:1];
});

it(@"checks for the argument", ^{
    expect(sut).method(setInteger:).with(17).to.beCalled();
    [sut setInteger:17];
});

it(@"checks for the returned value", ^{
    expect(sut).method(floatValue).returning(4.22).to.beCalled();
    [sut floatValue];
});

it(@"checks asynchronous methods", ^{
    dispatch_async(dispatch_get_main_queue(), ^{
        [sut doSomething];
    });
    expect(sut).method(doSomething).will.beCalled();
});

it(@"checks any() arguments", ^{
    expect(sut).method(methodWithIntArg:string:number:).with(any(), @"teststring", any()).to.beCalled();
    [sut methodWithIntArg:1919 string:@"teststring" number:@198];
});

it(@"checks only the first argument", ^{
    expect(sut).method(methodWithIntArg:string:number:).with(1919).to.beCalled();
    [sut methodWithIntArg:1919 string:@"teststring" number:@198];
});
```

### License

MIT, see [LICENSE](LICENSE.md)
