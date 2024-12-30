const expect = @import("std").testing.expect;

// defer in zig is a bit different than in go. In zig, defer is a statement that
// takes a block of code and runs it when the current scope is exited. This is
// useful for cleanup code that needs to run regardless of how the scope is exited.

// defer is similiar to the "finally" block in other languages like C# or Java.

test "defer" {
    var x: i16 = 5;
    {
        // when this scope ends, add 2 to x
        defer x += 2;
        // this assertion verifies that x is 5 at this point, before the defer block hasn't run yet
        try expect(x == 5);
    }
    // when the scope ends, the defer block runs and adds 2 to x
    try expect(x == 7);
}

// defer blocks are run in reverse order, so the last defer block added is the first to run
// this is useful for cleanup code that needs to run in the reverse order of initialization
test "multi defer" {
    var x: f32 = 5;
    {
        defer x += 2;
        defer x /= 2;
    }
    // the defer blocks run in reverse order, so the division by 2 runs first
    // then the addition by 2 runs
    try expect(x == 4.5);
}
