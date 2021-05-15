#!/bin/sh

if_exists_cd_to () {
    if [ -d $1 ]; then
        cd $1
    else
        echo "$1 does not exist"
        return 1
    fi
}
test_if_runs () {
    case $1 in
    coefficients-of-eigenpolynomial.bin|example.bin)
        if (echo "n" | ./$1 > /dev/null); then 
            printf "$1: \033\n[32m%46s\033[m\n" "PASSED"
        else
            printf "$1: \033\n[32m%46s\033[m\n" "FAILED"
        fi
    ;;
    *)
        if (./$1 > /dev/null); then
            printf "$1: \033\n[32m%46s\033[m\n" "PASSED"
        else 
            printf "$1: \033\n[32m%46s\033[m\n" "FAILED"
        fi
    ;;
    esac
}
test_if_it_exists () {
    if [ ! -e $1 ]; then
        echo "$1 does not exist"
        return 1
    fi
}
make_executable_if_not () {
    if [ ! -x $1 ]; then
        printf "\033[31mWARNING\033[m: $1 WAS NOT EXECUTABLE\n"
        echo "Making $1 executable by $USER"
        chmod u+x $1
    fi
}

############################### MAIN #################################
echo "*********** BASIC CORRECTNESS TEST ***********"
if if_exists_cd_to bin; then
    continue
else
    exit 1
fi

for program in *.bin; do
    if test_if_it_exists $program; then
        make_executable_if_not $program
    fi
    test_if_runs $program
done
cd ..
echo "**********************************************"
