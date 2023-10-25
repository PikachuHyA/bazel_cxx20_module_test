module;

#include <iostream>

export module b;
import c;
export namespace b {

auto b() -> void { std::cout << "Hello from module B interface!" << std::endl; }

} // namespace b
