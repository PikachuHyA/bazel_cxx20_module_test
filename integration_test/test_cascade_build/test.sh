cd $(dirname "$0")
case_name=`basename $(dirname "$0")`
bazel clean       >> test.log 2>&1
bazel build :foo  >> test.log 2>&1

bazel_bin_path=`bazel info bazel-bin`
bar_o="$bazel_bin_path/integration_test/$case_name/_objs/bar/bar.pic.o"
if [ -f $bar_o ]
then
    echo -e "\033[32mPASS\033[0m $case_name"
    exit 0
else
    echo -e "\033[31mFAIL\033[0m $case_name"
    echo "object file bazel-bin/integration_test/$case_name/_objs/bar/bar.pic.o not found"
    exit 1
fi