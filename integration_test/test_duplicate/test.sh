cd $(dirname "$0")
case_name=`basename $(dirname "$0")`
bazel clean        >> test.log 2>&1
bazel build :all   >> test.log 2>&1
bazel run :duplicate >> test.log 2>&1
cat test.log | grep "From duplicate #1" >> /dev/null
if test $? -ne 0
then
    echo -e "\033[31mFAIL\033[0m $case_name"
    echo "message From duplicate #1 not found"
    exit 1
fi


bazel run :duplicate2 >> test.log 2>&1

cat test.log | grep "From duplicate #2" >> /dev/null
if test $? -eq 0
then
    echo -e "\033[32mPASS\033[0m $case_name"
    exit 0
else
    echo -e "\033[31mFAIL\033[0m $case_name"
    echo "message From duplicate #2 not found"
    exit 1
fi
