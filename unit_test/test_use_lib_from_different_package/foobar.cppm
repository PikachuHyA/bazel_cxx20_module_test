module;
#include "foo.h"
#include "bar.h"
export module foobar;
export namespace foo {
    using foo::foo;
}
export namespace bar {
    using bar::bar;
}