# This script takes care of testing your crate

set -ex

main() {
    if [ $TRAVIS_RUST_VERSION == nightly ]; then
        local flags="--target $TARGET --features const-fn"
    else
        local flags="--target $TARGET"
    fi

    cross build $flags
    cross build $flags --release

    if [ ! -z $DISABLE_TESTS ]; then
        return
    fi

    cross test $flags
    cross test $flags --release
}

# we don't run the "test phase" when doing deploys
if [ -z $TRAVIS_TAG ]; then
    main
fi
