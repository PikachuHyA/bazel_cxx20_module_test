cd $(dirname "$0")
case_name=`basename $(dirname "$0")`
bazel clean        >> test.log 2>&1
bazel build :all   >> test.log 2>&1

sed -i "s|change_here|change_here2|g" foo.cppm

restore_change() {
cat test.log.tmp >> test.log
rm -rf test.log.tmp
sed -i "s|change_here2|change_here|g" foo.cppm
}

bazel build :all -s >> test.log.tmp 2>&1
cat test.log.tmp | grep "Compiling integration_test/$case_name/bar.cppm" >> /dev/null

if test $? -ne 0
then
    restore_change
    echo -e "\033[31mFAIL\033[0m $case_name"
    echo "message Compiling integration_test/$case_name/bar.cppm not found"
    exit 1
fi

cat test.log.tmp | grep "Compiling integration_test/$case_name/main.cc" >> /dev/null


if test $? -eq 0
then
    restore_change
    echo -e "\033[32mPASS\033[0m $case_name"
    exit 0
else
    restore_change
    echo -e "\033[31mFAIL\033[0m $case_name"
    echo "message Compiling integration_test/$case_name/main.cc not found"
    exit 1
fi
