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
  // try expect(asciiToUpper('1') == '1'); cause panic
}

fn increment(num: *u8) void {
  num.* += 1;
}

test "pointers" {
  var x: u8 = 1;
  increment(&x);
  try expect(x == 2);
}

test "naughty pointer" {
  // var x: u16 = 0;
  // var y: *u8 = @intToPtr(*u8, x);
  // _ = y;
  // null pointer will be detected
}

test "const pointers" {
  const x: u8 = 1;
  var y = &x;
  // y.* += 1;
  // y is a const pointer and cannot be assigned
  _ = y;
}

test "usize" {
  try expect(@sizeOf(usize) == @sizeOf(*u8));
  try expect(@sizeOf(isize) == @sizeOf(*u32));
}

fn total(values: []const u8) usize {
  var sum: usize = 0;
  for(values) |v| {
    sum += v;
  }
  return sum;
}

test "slices" {
  const array = [_]u8{1, 2, 3, 4, 5};
  const slice = array[0..3];
  try expect(total(slice) == 6);
}

test "slices 2" {
  const array = [_]u8{1, 2, 3, 4, 5};
  const slice = array[0..3];
  try expect(@TypeOf(slice) == *const [3]u8);
}

const Direction = enum {north, south, east, west};

// four will be too large for u2
const Value = enum(u2) {zero, one, two, three};

test "enum oridnal value" {
  try expect(@enumToInt(Value.zero) == 0);
  try expect(@enumToInt(Value.one) == 1);
  try expect(@enumToInt(Value.two) == 2);
  try expect(@enumToInt(Value.three) == 3);
}

const Value2 = enum(u32) {
  hundred = 100,
  thousand = 1000,
  million = 1000000,
  next,
};

test "set enum ordinal value" {
  try expect(@enumToInt(Value2.hundred) == 100);
  try expect(@enumToInt(Value2.thousand) == 1000);
  try expect(@enumToInt(Value2.million) == 1000000);
  try expect(@enumToInt(Value2.next) == 1000001);
}

const Suit = enum {
  clubs,
  spades,
  diamonds,
  hearts,
  pub fn isClubs(self: Suit) bool {
    return self == Suit.clubs;
  }
};

test "enum method" {
  try expect(Suit.isClubs(Suit.clubs));
}

const Mode = enum {
  var count: u32 = 0;
  on,
  off,
};

test "hmm" {
  Mode.count += 1;
  try expect(Mode.count == 1);
}

const Vec3 = struct {
  x: f32, y: f32, z: f32,
};

test "struct useage" {
  const my_vector = Vec3{
    .x = 0,
    .y = 100,
    .z = 50,
  };
  _ = my_vector;
}

test "missing struct field" {
  // const my_vector = Vec3 {
  //   .x = 0,
  //   .z = 50,
  // };
  // _ = my_vector;
}

const Vec4 = struct {
  x: f32, y: f32, z: f32 = 0, w: f32 = undefined,
};

test "struct defaults" {
  const my_vector = Vec4 {
    .x = 1,
    .y = 2,
  };
  _ = my_vector;
}

const Stuff = struct {
  x: i32,
  y: i32,
  pub fn swap(self: *Stuff) void {
    // struct pointer automatically deference one level
    const temp = self.x;
    self.x = self.y;
    self.y = temp;
  }
};

test "automatic dereference" {
  var thing = Stuff{.x = 1, .y = 2};
  thing.swap();
  try expect(thing.x == 2);
  try expect(thing.y == 1);
}

const Result = union {
  int: i64,
  float: f64,
  bool: bool,
};

test "simple union" {
  // cannot access to an inactive union field
  // var result = Result{.int = 1234};
  // result.float = 12.34;
}

const tag = enum {a, b, c};

const Tagged = union(tag) {a: u8, b: f32, c: bool};

test "switch on tagged union" {
  var value = Tagged{ .b = 1.5 };
  switch (value) {
    .a => |*byte| byte.* += 1,
    .b => |*float| float.* *= 2,
    .c => |*b| b.* = !b.*,
  }
  try expect(value.b == 3);
}

test "integer widening" {
  const a: u8 = 250;
  const b: u16 = a;
  const c: u32 = b;
  try expect(c == a);
}

test "@intCast" {
  const x: u64 = 200;
  const y = @intCast(u8, x);
  try expect(@TypeOf(y) == u8);
  try expect(y == 200);
}

test "well defined overflow" {
  var a: u8 = 255;
  a +%= 1;
  try expect(a == 0);
}

test "float widening" {
  const a: f16 = 0;
  const b: f32 = a;
  const c: f128 = b;
  try expect(c == a);
}

test "labelled blocks" {
  const count = blk: {
    var sum: u32 = 0;
    var i: u32 = 0;
    while (i < 10) : (i += 1) sum += i;
    break :blk sum;
  };
  try expect(count == 45);
  try expect(@TypeOf(count) == u32);
}
