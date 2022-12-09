const std = @import("std");
const expect = @import("std").testing.expect;

const constant: i32 = 5;
var variable: u32 = 10;

const unkonwn = undefined;

const hello = [_]u8{ 'h', 'e', 'l', 'l', 'o' };

test "if statement" {
    const a = true;
    var x: u16 = 0;

    if (a) {
        x += 1;
    } else {
        x += 2;
    }

    try expect(x == 1);
}

test "if statement expression" {
    const a = true;
    var x: u16 = 0;
    x += if (a) 1 else 2;
    try expect(x == 1);
}

test "while" {
    var i: u8 = 2;
    while (i < 100) {
        i *= 2;
    }
    try expect(i == 128);
}

test "while with continue expression" {
    var sum: u8 = 0;
    var i: u8 = 0;
    // continue expression will be executed at the end of each iteration
    while (i < 10) : (i += 1) {
        sum += i;
    }
    try expect(i == 10);
    try expect(sum == 45);
}

test "while with continue" {
    var sum: u8 = 0;
    var i: u8 = 0;
    while (i < 10) : (i += 1) {
        if (i == 5) continue;
        sum += i;
    }
    try expect(sum == 40);
}
