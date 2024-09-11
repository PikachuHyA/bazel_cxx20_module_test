cd $(dirname "$0")
case_name=`basename $(dirname "$0")`
bazel clean        >> test.log 2>&1
bazel build :all   >> test.log 2>&1

cat test.log | grep "ERROR: Module not found: foo" >> /dev/null

if test $? -eq 0
then
    echo -e "\033[32mPASS\033[0m $case_name"
    exit 0
else
    echo -e "\033[31mFAIL\033[0m $case_name"
    echo "message 'ERROR: Module not found: foo' not found"
    echo "================== build log =================="
    cat test.log
    exit 1
fi
