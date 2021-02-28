const Builder = @import("std").build.Builder;

pub fn build(b: *Builder) void {
    const target = b.standardTargetOptions(.{});
    const mode = b.standardReleaseOptions();

    const c_source_files = [_][]const u8 {
        "./src/args.c",
        "./src/data.c",
        "./src/list.c",
        "./src/load_image.c",
        "./src/matrix.c",
        "./src/test.c",


        // These should be converted to zig eventually
        "./src/hw0/process_image.c",
        "./src/hw1/resize_image.c",
        "./src/hw2/filter_image.c",
        "./src/hw3/harris_image.c",
        "./src/hw3/panorama_image.c",
        "./src/hw4/flow_image.c",
        "./src/hw5/classifier.c",
    };

    const zig_source_files = [_][]const u8 {
        "./src/hw0/process_image.zig",
    };

    const exe = b.addExecutable("uwimg", "./src/main.c");

    const cflags = [_][]const u8 {
        "-fPIC",
        "-Wall",
        "-Iinclude/",
        "-Isrc/",
    };

    for (c_source_files) |source_file| {
        exe.addCSourceFile(source_file, &cflags);
    }

    //for (zig_source_files) |source_file| {
    //    exe.addExecutableSource(source_file);
    //}

    //exe.setOutputPath("./uwimg");
    exe.setTarget(target);
    exe.setBuildMode(mode);
    exe.setOutputDir("./");
    exe.linkLibC();
    exe.install();

    b.default_step.dependOn(&exe.step);
}