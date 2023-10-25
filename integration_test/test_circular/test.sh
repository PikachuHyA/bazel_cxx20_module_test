cd $(dirname "$0")
case_name=`basename $(dirname "$0")`
bazel clean        >> test.log 2>&1
bazel build :demo  >> test.log 2>&1
cat test.log | grep "cycle in dependency graph" >> /dev/null

if test $? -eq 0
then
    echo -e "\033[32mPASS\033[0m $case_name"
    exit 0
else
    echo -e "\033[31mFAIL\033[0m $case_name"
    echo "message cycle in dependency graph not found"
    exit 1
fi