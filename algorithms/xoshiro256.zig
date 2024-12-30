// xoshiro256**

const std = @import("std");

fn readDevURandom() ![32]u8 {
    const urandom_file = try std.fs.cwd().openFile("/dev/urandom", .{});
    defer urandom_file.close();

    var buffer: [32]u8 = undefined;
    _ = try urandom_file.read(&buffer);

    return buffer;
}

const Random = struct {
    state: [4]u64,

    pub fn init() !Random {
        var bytes = try readDevURandom();

        var state: [4]u64 = undefined;
        inline for (0..4) |i| {
            state[i] = std.mem.readInt(u64, bytes[i * 8 .. (i + 1) * 8], .little);
        }

        return Random{ .state = state };
    }

    pub fn next(self: *Random) u64 {
        const result_1 = @mulWithOverflow(self.state[1], 5); // Multiply state[1] by 5 with overflow detection
        const rotated = std.math.rotl(u64, result_1[0], 7); // Rotate the result left by 7 bits
        const result = @mulWithOverflow(rotated, 9)[0]; // Multiply the rotated value by 9 with overflow detection

        const t = self.state[1] << 17; // Shift state[1] left by 17 bits

        self.state[2] ^= self.state[0]; // XOR state[2] with state[0]
        self.state[3] ^= self.state[1]; // XOR state[3] with state[1]
        self.state[1] ^= self.state[2]; // XOR state[1] with state[2]
        self.state[0] ^= self.state[3]; // XOR state[0] with state[3]

        self.state[2] ^= t; // XOR state[2] with the shifted value t
        self.state[3] = std.math.rotl(u64, self.state[3], 45); // Rotate state[3] left by 45 bits

        return result;
    }
};

pub fn main() !void {
    var stdout = std.io.getStdOut().writer();
    var rng = try Random.init();

    for (0..5) |_| {
        try stdout.print("Random number: {d}\n", .{rng.next()});
    }
}
