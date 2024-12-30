const expect = @import("std").testing.expect;

// normal pointers cannot have 0 or null as value
// the syntax is *T, where T is the child type

// Referencing is done with &T, and dereferencing is done with T.*

fn increment(num: *u8) void {
    num.* += 1;
}

// & gets the address of a variable
// .* dereferences a pointer
// [*]T is a many-pointer (allows pointer arithmetic)
// *T is a single-item pointer (does not allow arithmetic)

test "pointers" {
    var x: u8 = 1;
    increment(&x);
    try expect(x == 2);
}

test "const pointers" {
    // const pointers cannot be modified
    var x: u8 = 1;
    const y = &x;
    y.* += 1;
}

// many-pointers
test "pointers arithmetic" {
    var array = [_]i32{ 1, 2, 3, 4, 5 };
    const ptr: [*]i32 = &array;

    try expect(ptr[0] == 1);
    try expect(ptr[1] == 2);

    const second_element = ptr + 1;
    try expect(second_element[0] == 2);
}

// zig encourages the use of slices instead of raw pointer arithmetic
test "slices" {
    var array = [_]i32{ 1, 2, 3, 4, 5 };
    const slice = array[0..];

    try expect(slice[0] == 1);
    try expect(slice[1] == 2);
}
