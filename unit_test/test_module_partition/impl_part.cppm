module;
#include <iostream>
#include <string>
module M:impl_part;
import :interface_part;
std::string W = "World. ";

void World() {
  std::cout << W << std::endl;
}

