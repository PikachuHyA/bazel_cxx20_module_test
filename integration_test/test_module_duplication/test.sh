cd $(dirname "$0")
case_name=`basename $(dirname "$0")`
bazel clean        >> test.log 2>&1
bazel build :A   >> test.log 2>&1
if test $? -eq 0
then
    echo -e "\033[31mFAIL\033[0m $case_name"
    echo "expect build failed, but build success"
    echo "================== build log =================="
    cat test.log
    exit 1
fi

# TODO: check duplication message
