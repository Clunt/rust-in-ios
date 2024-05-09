mod demo;

#[no_mangle]
pub extern "C" fn rust_start() {
    demo::run();
}
