const std = @import("std");

pub fn main() !void {
    // Arrays are denoted by [N]T, where N is the number of elements in the array and T is the type of those elements (i.e., the array's child type).
    // Array ditandai dengan [N]T, di mana N adalah jumlah elemen dalam array dan T adalah tipe elemen-elemen tersebut (yaitu, tipe anak array).

    const a: [5]u8 = [5]u8{ 1, 2, 3, 4, 5 };

    std.debug.print("Array A Length is {}\n", .{a.len});

    for (a) |elem| {
        std.debug.print("Element: {}\n", .{elem + 1});
    }
}
