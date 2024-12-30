const expect = @import("std").testing.expect;

// Act similarly to their single-item counterparts, using the syntax [*]T instead of *T.

// Multi-item pointers are not dereferenceable, so they can't be used to access the value they point to.
// They are indexible.
// They support arithmetic operations, but only with other multi-item pointers of the same type.
// Item size must be known.
// Can coerces from an array pointer.

// single-item pointer to an array of bytes coerces into a many-item pointer of bytes
fn doubleAllManyPointer(buffer: [*]u8, byte_count: usize) void {
    var i: usize = 0;
    while (i < byte_count) : (i += 1) buffer[i] *= 2;
}

test "many-item-pointers" {
    var buffer: [100]u8 = [_]u8{1} ** 100;
    const buffer_ptr: *[100]u8 = &buffer;

    const buffer_many_ptr: [*]u8 = buffer_ptr;
    doubleAllManyPointer(buffer_many_ptr, buffer.len);
    for (buffer) |byte| try expect(byte == 2);

    const first_elem_ptr: *u8 = &buffer_many_ptr[0];
    const first_elem_ptr_2: *u8 = @ptrCast(buffer_many_ptr);
    try expect(first_elem_ptr == first_elem_ptr_2);
}
