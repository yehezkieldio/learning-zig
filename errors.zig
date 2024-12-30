const expect = @import("std").testing.expect;

// there are no exceptions in Zig, errors are values

const FileOpenError = error{
    AccessDenied,
    OutOfMemory,
    FileNotFound,
};

const AllocationError = error{
    OutOfMemory,
};

// we try to transform an error from one type to another
test "coerce error from a subset to a superset" {
    const err: FileOpenError = AllocationError.OutOfMemory;
    try expect(err == FileOpenError.OutOfMemory);
}

// an error set type and another type can be combined with the ! operator to form an error union type
// values of these types may be an error value or a non-error value

test "error union" {
    const maybe_error: AllocationError!u16 = 10;
    const no_error = maybe_error catch 0;

    // this is like Option in Rust where there is a value or an error

    try expect(@TypeOf(no_error) == u16);
    try expect(no_error == 10);
}

// functions can return error values

// this function either returns an error or a value, the return type is an error union
fn failingFunction() error{Oops}!void {
    return error.Oops;
}

test "returning error" {
    // |err| is called a payload capturing
    failingFunction() catch |err| {
        try expect(err == error.Oops);
        return;
    };
}

// `try expect` is shorthand for if (err) return err;
// it's unrelated to the `try` keyword used in error handling in other languages

fn failFn() error{Oops}!i32 {
    try failingFunction();
    return 12;
}

test "try" {
    const v = failFn() catch |err| {
        try expect(err == error.Oops);
        return;
    };
    try expect(v == 12);
}

// errdefer works like defer, but only executing when the function is returned from with an error

var problems: u32 = 98;

fn failFnCounter() error{Oops}!void {
    errdefer problems += 1;
    try failingFunction();
}

test "errdefer" {
    failFnCounter() catch |err| {
        try expect(err == error.Oops);
        try expect(problems == 99);
        return;
    };
}

// error unions returned from a function can have their error sets inferred by not having an explicit error set.

fn createFile() !void {
    return error.AccessDenied;
}

test "inferred error set" {
    const x: error{AccessDenied}!void = createFile();

    // zig does not let us ignore error union values
    // we have to handle them or unwrap them with try, catch, or if by any means
    _ = x catch {};
}

// error sets can be merged

const A = error{ NotDir, PathNotFound };
const B = error{ OutOfMemory, PathNotFound };
const C = A || B;

test "error set union" {
    try expect(C == error{ NotDir, OutOfMemory, PathNotFound });
}
