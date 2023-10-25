count=0
pass=0
for file in `ls`
do 
    if [ -d "`pwd`/$file" ]
    then
        count=`expr $count + 1`
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
if test $count -eq $pass
then
    echo "ALL TEST PASSED [$pass/$count]"
    exit 0
else
    echo "TEST FAIELD [$pass/$count]"
    exit 1
fi
