setup: install apple-ios

install:
	@rustup target add aarch64-apple-ios
	@rustup target add aarch64-apple-ios-sim
	@rustup target add x86_64-apple-ios

apple-ios:
	@mkdir -p libs
	@cargo build --release --lib --target aarch64-apple-ios
	@cargo build --release --lib --target aarch64-apple-ios-sim
	@cargo build --release --lib --target x86_64-apple-ios
	@$(RM) -rf libs/librust-ios.a
	@$(RM) -rf libs/librust-ios-sim.a
	@cp target/aarch64-apple-ios/release/librust.a \
		libs/librust-ios.a
	@lipo -create -output libs/librust-ios-sim.a \
		target/aarch64-apple-ios-sim/release/librust.a \
		target/x86_64-apple-ios/release/librust.a
	@$(RM) -rf rust.xcframework
	@$(RM) -rf bundle.zip
	@$(RM) -rf bundle.sha256
	@xcodebuild -create-xcframework \
		-library libs/librust-ios-sim.a -headers ./include/ \
		-library libs/librust-ios.a -headers ./include/ \
		-output rust.xcframework
	@zip -r bundle.zip rust.xcframework
	@openssl dgst -sha256 bundle.zip > bundle.sha256

clean:
	@$(RM) -rf libs/librust-ios.a
	@$(RM) -rf libs/librust-ios-sim.a
	@$(RM) -rf libs
	@$(RM) -rf rust.xcframework
	@$(RM) -rf bundle.zip
	@$(RM) -rf bundle.sha256
	@cargo clean
