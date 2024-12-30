const expect = @import("std").testing.expect;

// runtime safety protects you from out of bound indices
// out of bound indices is when you try to access an index that is not in the array

test "out of bounds" {
    // you can disable runtime safety
    @setRuntimeSafety(false);
    const a = [3]u8{ 1, 2, 3 };
    var index: u8 = 5;
    const b = a[index];

    _ = b;
    index = index;
}

// unreachable is an assertion to the compiler that this statement will never be reached
// reaching an unreachable statement is a detectable illegal behavior
// an assertion is a statement that is assumed to be true and is used to indicate that the programmer believes that the statement is always true at that point in the program

test "unreachable" {
    const x: i32 = 1;
    const y: u32 = if (x == 2) 5 else unreachable;
    _ = y;
}

fn asciiToUpper(x: u8) u8 {
    return switch (x) {
        "a"..."z" => x + 'A' - 'a',
        "A"..."Z" => x,
        else => unreachable,
    };
}

test "unreachable in function" {
    try expect(asciiToUpper('a') == 'A');
    try expect(asciiToUpper('A') == 'A');
}
