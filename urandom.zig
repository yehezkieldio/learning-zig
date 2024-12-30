const std = @import("std");

// ! indicates that the function can return an error
// !T is shorthand for ErrorUnion(anyerror, T)

// The actual type will be either:
//      The success value ([16]u8 array in this case)
//      OR an error value
fn readDevURandom() ![16]u8 {
    const urandom_file = try std.fs.cwd().openFile("/dev/urandom", .{});
    defer urandom_file.close();

    var buffer: [16]u8 = undefined;
    _ = try urandom_file.read(&buffer);

    return buffer;
}

pub fn main() !void {
    var stdout = std.io.getStdOut().writer();

    for (0..5) |_| {
        const buffer = readDevURandom();
        try stdout.print("Random bytes: {any}\n", .{buffer});
    }
}
