set -x
CXX=/opt/acc/bin/clang++
file1=Queue
file2=ThreadPool
file1_module_name=async_simple:util.Queue
file1=foo
file2=bar
file1_module_name=M:foo
project_root=/Users/shuoshu.yh/code/bazel_cxx20_module_test/tests/test_template_class
sandbox_path=/Users/shuoshu.yh/code/bazel_cxx20_module_test/tests/test_template_class/sandbox1
rm -rf *.pcm
rm -rf sandbox*
mkdir sandbox1
pushd sandbox1
cp ../$file1.cppm .
PWD=/proc/self/cwd $CXX --precompile -std=c++20 -c $file1.cppm -o $file1.pcm\
 -fmodule-source-path-write-time-map=$sandbox_path=$project_root
cp $file1.pcm ..
rm $file1.cppm
popd
echo "sandbox1 OK"
mkdir sandbox2
pushd sandbox2
cp ../$file2.cppm .
cp ../$file1.pcm .
PWD=/proc/self/cwd $CXX --precompile -std=c++20 -c $file2.cppm -o $file2.pcm -fmodule-file=$file1_module_name=$file1.pcm
popd