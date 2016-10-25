#![feature(lang_items)]
#![no_std]

extern crate rlibc;

#[no_mangle]
pub extern fn rust_main() {
    // ATTENTION: we have a very small stack and no guard page

    let hello = b"test2!";

    let color_byte = 0x1f; // white foreground, blue background

    let mut hello_colored = [color_byte; 24];
    for (i, char_byte) in hello.into_iter().enumerate() {
        hello_colored[i*2] = *char_byte;
    }

    // write `Hello World!` to the center of the VGA text buffer
    let buffer_ptr = (0xb8000 + 1988) as *mut _;
    unsafe { *buffer_ptr = hello_colored };

    loop{}
}

#[lang = "eh_personality"] extern fn eh_personality() {}
#[lang = "panic_fmt"] extern fn panic_fmt() -> ! {loop{}}

// #! defines an attribute of the current module. Since we are at the root module, they apply to the crate itself.
// The feature attribute is used to allow the specified feature-gated attributes in this crate. You can’t do that in a stable/beta compiler, so this is one reason we need a Rust nighly.
// The no_std attribute prevents the automatic linking of the standard library. We can’t use std because it relies on operating system features like files, system calls, and various device drivers. Remember that currently the only “feature” of our OS is printing OKAY :).
// A # without a ! afterwards defines an attribute for the following item (a function in our case).
// The no_mangle attribute disables the automatic name mangling that Rust uses to get unique function names. We want to do a call rust_main from our assembly code, so this function name must stay as it is.
// We mark our main function as extern to make it compatible to the standard C calling convention.
// The lang attribute defines a Rust language item.
// The eh_personality function is used for Rust’s unwinding on panic!. We can leave it empty since we don’t have any unwinding support in our OS yet.
// The panic_fmt function is the entry point on panic. Right now we can’t do anything useful, so we just make sure that it doesn’t return (required by the ! return type).

#[allow(non_snake_case)]
#[no_mangle]
pub extern "C" fn _Unwind_Resume() -> ! {
    loop {}
}
