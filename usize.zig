const expect = @import("std").testing.expect;

// usize is a pointer-sized unsigned integer
// It should have the same size and alignment as a pointer

// isize is a pointer-sized signed integer
// It should have the same alignment as a pointer

test "usize" {
    try expect(@sizeOf(usize) == @sizeOf(*u8));
    try expect(@sizeOf(isize) == @sizeOf(*u8));
}
