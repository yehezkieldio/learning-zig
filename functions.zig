const expect = @import("std").testing.expect;

// all functions are immutable by default that means they can't change the value of the arguments passed to them
// if you want to change the value of the argument you need to pass it as a pointer

// pure function, creates a new value and returns it
fn addFive(x: u32) u32 {
    return x + 5;
}

// mutates original value through a pointer
fn changeValue(x: *u32) void {
    x.* += 5;
}

fn fibonacci(n: u16) u16 {
    if (n == 0 or n == 1) return n;
    return fibonacci(n - 1) + fibonacci(n - 2);
}

test "addFive" {
    const x: u32 = 5;
    const y = addFive(x);
    const expected = 10;
    try expect(y == expected);
}

test "changeValue" {
    var x: u32 = 5;
    changeValue(&x);
    const expected = 10;
    try expect(x == expected);
}

test "fibonacci" {
    const n: u16 = 10;
    const expected = 55;
    try expect(fibonacci(n) == expected);
}
