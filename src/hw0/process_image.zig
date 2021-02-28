const uwimg_c = @cImport({
    @cInclude("image.h");
});

export fn get_pixel(img: uwimg_c.image, x: isize, y: isize, z: isize) f32 {
    return 0.0;
}

export fn set_pixel(img: uwimg_c.image, x: isize, y: isize, z: isize, v: f32)  void {

}

export fn copy_image(img: uwimg_c.image) uwimg_c.image {
    const copy = uwimg_c.make_image(img.w, img.h, img.c);
    return copy;
}

export fn rgb_to_grayscale(img: uwimg_c.image) uwimg_c.image {
    const gray = uwimg_c.make_image(img.w, img.h, img.c);
    return gray;
}

export fn shift_image(img: uwimg_c.image, c: isize, v: f32) void {

}

export fn clamp_image(img: uwimg_c.image) void {

}

export fn rgb_to_hsv(img: uwimg_c.image) void {

}

export fn hsv_to_rgb(img: uwimg_c.image) void {

}