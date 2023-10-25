
main: main.cpp.o a.cppm.o b.cppm.o c.cppm.o c.cpp.o d_interface.cppm.o d_implementation.cpp.o
	clang++ -std=c++20 main.cpp.o a.cppm.o b.cppm.o c.cppm.o c.cpp.o d_interface.cppm.o d_implementation.cpp.o -o main

main.cpp.o: a.cppm.o b.cppm.o c.cppm.o d_interface.cppm.o
	clang++ -std=c++20 -fprebuilt-module-path=. -c main.cpp -o main.cpp.o

a.cppm.o: a.pcm
	clang++ -std=c++20  -c a.pcm -o a.cppm.o

b.cppm.o: b.pcm c.pcm
	clang++ -std=c++20 -fprebuilt-module-path=. -c b.pcm -o b.cppm.o
c.cpp.o: c.pcm
	clang++ -std=c++20 -fprebuilt-module-path=. -c c.cpp -o c.cpp.o

c.cppm.o: c.pcm
	clang++ -std=c++20  -c c.pcm -o c.cppm.o

d_interface.cppm.o: d_interface.pcm
	clang++ -std=c++20  -c d.pcm -o d_interface.cppm.o

d_implementation.cpp.o: d_interface.pcm
	clang++ -std=c++20 -fprebuilt-module-path=. -c d_implementation.cpp -o d_implementation.cpp.o

a.pcm: b.pcm
	clang++ -std=c++20 -fprebuilt-module-path=. --precompile a.cppm -o a.pcm

b.pcm: c.pcm
	clang++ -std=c++20 -fprebuilt-module-path=. --precompile b.cppm -o b.pcm

c.pcm:
	clang++ -std=c++20 --precompile c.cppm -o c.pcm

d_interface.pcm:
	clang++ -std=c++20 --precompile d_interface.cppm -o d.pcm

clean:
	rm -rf *.pcm *.o
