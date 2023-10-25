export module M:bar;
import :foo;

class Bar {
    ~Bar() {
        foo.f();
    }
private:
    Foo<void> foo;
};