const std = @import("std");

test "while" {
    var i: i32 = 2;
    while (i <= 200) {
        std.debug.print("i = {}\n", .{i});
        i *= 2;
    }
    try std.testing.expect(i == 256);
}
