module;
#include <iostream>
export module foo;
typedef void* fcontext_t;
struct transfer_t {
    fcontext_t fctx;
    void* data;
};
extern "C" __attribute__((__visibility__("default"))) transfer_t
_fl_jump_fcontext(fcontext_t const to, void* vp);
extern "C" __attribute__((__visibility__("default"))) fcontext_t
_fl_make_fcontext(void* sp, size_t size, void (*fn)(transfer_t));
