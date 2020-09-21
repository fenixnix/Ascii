const std = @import("std");
const warn = @import("std").debug.warn;

pub fn main() !void{
    const stdout = std.io.getStdOut().outStream();
    try stdout.print("Hello, {}!\n",.{"world"});
    warn("Hello, world!\n",.{});
}