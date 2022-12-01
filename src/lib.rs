#[swift_bridge::bridge]
mod ffi {
    extern "Rust" {
        fn print_hello_rust();
        fn rust_add(left: usize, right: usize) -> usize;
    }
}

fn rust_add(left: usize, right: usize) -> usize {
    left + right
}

fn print_hello_rust() {
    println!("Hello from Rust")
}