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

test "while with break" {
    var sum: u8 = 0;
    var i: u8 = 0;
    while (i < 10) : (i += 1) {
        if (i == 5) break;
        sum += i;
    }
    try expect(sum == 10);
}

test "for" {
    const string = [_]u8{ 'a', 'b', 'c' };

    for (string) |char, index| {
        _ = char;
        _ = index;
    }

    for (string) |char| {
        _ = char;
    }

    for (string) |_, index| {
        _ = index;
    }

    for (string) |_| {}
}

fn addFive(x: u32) u32 {
    return x + 5;
}

test "function" {
    const y = addFive(0);
    try expect(@TypeOf(y) == u32);
    try expect(y == 5);
}

fn fib(n: u32) u32 {
    return if (n == 0 or n == 1)
        n
    else
        fib(n - 1) + fib(n - 2);
}

test "function recursion" {
    try expect(fib(10) == 55);
}

test "defer" {
    var x: i16 = 5;
    {
        defer x += 2;
        try expect(x == 5);
    }
    try expect(x == 7);
}

test "multi defer" {
    var x: f32 = 5;
    {
        defer x += 2;
        defer x /= 2;
    }
    try expect(x == 4.5);
}

const FileOpenError = error{
    AccessDenied,
    OutOfMemory,
    FileNotFound,
};

const AllocationError = error {
    OutOfMemory,
};

test "coerce error from a subset of a superset" {
    const err: FileOpenError = AllocationError.OutOfMemory;
    try expect(err == FileOpenError.OutOfMemory);
}

test "error union" {
  const maybe_error: AllocationError!u16 = 10;
  const no_error = maybe_error catch 0;

  try expect(@TypeOf(no_error) == u16);
  try expect(no_error == 10);
}

fn failingFun() error{Oops}!void {
  return error.Oops;
}

test "returning an error" {
  failingFun() catch |err| {
    try expect(err == error.Oops);
    return;
  };
}

fn failFn() error{Oops}!i32 {
  try failingFun();
  return 12;
}

test "try" {
  var v = failFn() catch |err| {
    try expect(err == error.Oops);
    return;
  };
  try expect(v == 12);
}

var problems: u32 = 98;

fn failFnCounter() error{Oops}!void {
  errdefer problems += 1;
  try failingFun();
}

test "errdefer" {
  failFnCounter() catch |err| {
    try expect(err == error.Oops);
    try expect(problems == 99);
    return;
  };
}

fn createFile() !void {
  return error.AccessDenied;
}

test "inffered error set" {
  const x: error{AccessDenied, OutOfMemory}!void = createFile();
  try expect(x == error.AccessDenied);
  x catch |err|{
    const y: anyerror = err;
    try expect(y == error.AccessDenied);
    return;
  };
}

test "switch statement" {
  var x: i8 = 10;
  switch (x) {
    -1...1 => {
      x = -x;
    },
    10, 100 => {
      x = @divExact(x, 10);
    },
    else => {},
  }
  try expect(x == 1);
}

test "switch expression" {
  var x:i8 = 10;
  x = switch(x) {
    -1...1 => -x,
    10, 100 => @divExact(x, 10),
    else => x,
  };
  try expect(x == 1);
}


test "out of bounds" {
  const a = [3]u8{1, 2, 3};
  var index: u8 = 2; // index = 5 will cause panic
  _ = a[index];
}

test "out of bounds, no safety" {
  @setRuntimeSafety(false);
  const a = [3]u8{1, 2, 3};
  var index: u8 = 5;
  _ = a[index];
}

test "unreachable" {
  const x: i32 = 1;
  // unreachable coerces to u32
  const y: u32 = if (x == 1) 5 else unreachable;
  _ = y;
}

fn asciiToUpper(x: u8) u8 {
  return switch(x) {
    'a'...'z' => x + 'A' - 'a',
    'A'...'Z' => x,
    else => unreachable,
  };
}

test "unreachable switch" {
  try expect(asciiToUpper('x') == 'X');
  try expect(asciiToUpper('X') == 'X');
  // try expect(asciiToUpper('1') == '1');
}
