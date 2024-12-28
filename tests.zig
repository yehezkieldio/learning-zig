const std = @import("std");
const expect = std.testing.expect;

test "always true" {
    try expect(true);
}
