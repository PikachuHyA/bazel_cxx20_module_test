cd $(dirname "$0")
case_name=`basename $(dirname "$0")`
bazel clean        >> test.log 2>&1
bazel build :all   >> test.log 2>&1

sed -i "s|foo|foo2|g" foo.cppm

restore_change() {
cat test.log.tmp >> test.log
rm -rf test.log.tmp
sed -i "s|foo2|foo|g" foo.cppm
}

bazel build :all -s >> test.log.tmp 2>&1
cat test.log.tmp | grep "ERROR: Module not found: foo" >> /dev/null


if test $? -eq 0
then
    restore_change
    echo -e "\033[32mPASS\033[0m $case_name"
    exit 0
else
    restore_change
    echo -e "\033[31mFAIL\033[0m $case_name"
    echo "message 'ERROR: Module not found: foo' not found"
    exit 1
fi
