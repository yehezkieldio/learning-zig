const std = @import("std");

pub fn main() !void {
    const number_one: i32 = 1;
    const number_two: u32 = 2;

    const sum = number_one + number_two;

    std.debug.print("The sum of {} and {} is {}\n", .{ number_one, number_two, sum });
}
