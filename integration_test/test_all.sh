IGNORE_LIST="test_module_duplication"
count=0
pass=0
ignore=0
for file in `ls`
do 
    if [ -d "`pwd`/$file" ]
    then
        count=`expr $count + 1`
        if [[ " ${IGNORE_LIST[*]} " =~ " $file " ]]
        then
            ignore=`expr $ignore + 1`
            continue
        fi
        rm -rf $file/test.log
        bash "$file/test.sh"
        if test $? -eq 0
        then
            pass=`expr $pass + 1`
        else
            cat $file/test.log
        fi
    fi
done
if test $count -eq $(($pass+$ignore))
then
    if test $count -eq $pass
    then
        echo "ALL TEST PASSED [$pass/$count]"
    else
        echo "PASSED  $pass"
        echo "IGNORED $ignore"
        echo "TOTAL   $count"
    fi
    exit 0
else
    echo "TEST FAIELD [$pass/$count]"
    echo "IGNORED      $ignore"
    exit 1
fi
