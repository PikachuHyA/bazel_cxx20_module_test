cd $(dirname "$0")
case_name=`basename $(dirname "$0")`
bazel clean        >> test.log 2>&1
bazel build :all   >> test.log 2>&1
if test $? -ne 0
then
    echo -e "\033[31mFAIL\033[0m $case_name"
    echo "Build fail"
    exit 1
fi

sed -i "s|deps = [":foo"],|implementation_deps = [":foo"],|g" BUILD.bazel

bazel build :all   >> test.log.tmp 2>&1

bazel_bin_path=`bazel info bazel-bin`
pic_pcm_file="$bazel_bin_path/integration_test/$case_name/_objs/foo/foo.pic.pcm"
cat test.log.tmp | grep "fatal error: module file '$pic_pcm_file' not found" >> /dev/null

restore_change() {
cat test.log.tmp >> test.log
rm -rf test.log.tmp
sed -i "s|implementation_deps = [":foo"],|deps = [":foo"],|g" BUILD.bazel
}
if test $? -eq 0
then
    echo -e "\033[32mPASS\033[0m $case_name"
    exit 0
else
    echo -e "\033[31mFAIL\033[0m $case_name"
    echo "message fatal error: module file '$pic_pcm_file' not found not found"
    exit 1
fi
