const expect = @import("std").testing.expect;

test "switch statement" {
    var x: i8 = 10;
    switch (x) {
        // range pattern betwen -1 to 1 inclusive
        -1...1 => {
            x = -x;
        },
        // multiple specific values of 10, 100 separated by comma
        10, 100 => {
            x = @divExact(x, 10);
        },
        else => {},
    }
    try expect(x == 1);
}
