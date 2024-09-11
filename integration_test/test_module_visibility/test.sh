cd $(dirname "$0")
case_name=`basename $(dirname "$0")`
bazel clean        >> test.log 2>&1
bazel build :C   >> test.log 2>&1

if test $? -ne 0
then
    echo -e "\033[31mFAIL\033[0m $case_name"
    cat test.log
    exit 1
fi
bazel build :A   >> test.log 2>&1
if test $? -eq 0
then
    echo -e "\033[31mFAIL\033[0m $case_name"
    echo "expect build failed, but build success"
    cat test.log
    exit 1
fi

cat test.log | grep "ERROR: Module not found: C" >> /dev/null

if test $? -eq 0
then
    echo -e "\033[32mPASS\033[0m $case_name"
    exit 0
else
    echo -e "\033[31mFAIL\033[0m $case_name"
    echo "message 'ERROR: Module not found: C' not found"
    exit 1
fi
