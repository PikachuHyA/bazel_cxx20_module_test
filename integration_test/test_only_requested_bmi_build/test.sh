cd $(dirname "$0")
case_name=`basename $(dirname "$0")`
bazel clean       >> test.log 2>&1
bazel build :foo  >> test.log 2>&1

bazel_bin_path=`bazel info bazel-bin`
pic_pcm_file="$bazel_bin_path/integration_test/$case_name/_objs/foo/foo.pic.pcm"
if [ ! -f $pcm_file ]
then
    echo -e "\033[31mFAIL\033[0m $case_name"
    echo "the BMI file bazel-bin/integration_test/$case_name/_objs/foo/foo.pic.pcm is not build"
    exit 1
fi
pcm_file="$bazel_bin_path/integration_test/$case_name/_objs/foo/foo.pcm"
if [ ! -f $pcm_file ]
then
    echo -e "\033[32mPASS\033[0m $case_name"
    exit 0
else
    echo -e "\033[31mFAIL\033[0m $case_name"
    echo "the BMI file bazel-bin/integration_test/$case_name/_objs/foo/foo.pcm should not be built"
    exit 1
fi