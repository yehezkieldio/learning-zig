const std = @import("std");
const expect = std.testing.expect;

test "while" {
    var i: i32 = 2;
    while (i <= 200) {
        std.debug.print("i = {}\n", .{i});
        i *= 2;
    }
    try std.testing.expect(i == 256);
}

test "while with continue expression" {
    var sum: u8 = 0;
    var i: u8 = 1;
    // the continue expression specified after the : symbol is executed at the end of each iteration before the condition is checked again
    // ekspresi continue yang ditentukan setelah simbol : dieksekusi pada akhir setiap iterasi sebelum kondisi diperiksa lagi
    while (i <= 10) : (i += 1) {
        sum += i;
    }
    try expect(sum == 55);
}

test "while with continue" {
    var sum: u8 = 0;
    var i: u8 = 0;
    while (i <= 3) : (i += 1) {
        // continue skips the rest of the loop body and goes to the next iteration
        // continue melewati sisa tubuh loop dan melanjutkan ke iterasi berikutnya
        if (i == 2) continue;
        sum += i;
    }
    try expect(sum == 4);
}

test "while with break" {
    var sum: u8 = 0;
    var i: u8 = 0;
    while (i <= 3) : (i += 1) {
        // break exits the loop immediately
        // break keluar dari loop segera
        if (i == 2) break;
        sum += i;
    }
    try expect(sum == 1);
}
