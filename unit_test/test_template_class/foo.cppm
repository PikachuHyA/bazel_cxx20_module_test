export module M:foo;
template<typename T>
class Foo {
    public:
    void f() {
        flag = true;
    }
    private:
    bool flag;
};