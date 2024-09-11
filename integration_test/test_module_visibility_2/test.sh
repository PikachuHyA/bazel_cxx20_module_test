cd $(dirname "$0")
case_name=`basename $(dirname "$0")`
bazel clean        >> test.log 2>&1
bazel build :A   >> test.log 2>&1

if test $? -ne 0
then
    echo -e "\033[31mFAIL\033[0m $case_name"
    cat test.log
    exit 1
fi

# maybe use a unit test?
echo -e "\033[32mPASS\033[0m $case_name"
exit 0
