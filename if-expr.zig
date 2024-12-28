const expect = @import("std").testing.expect;

// Ternary conditional operators (cond ? a : b) do not exist in zig.

test "if statement" {
    const a = true;
    var x: i16 = 0;

    if (a) {
        x += 1;
    } else {
        x += 2;
    }

    try expect(x == 1);
}