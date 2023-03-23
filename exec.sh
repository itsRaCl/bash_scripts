#!/bin/bash 

cmd="ls | grep $1"
file=$1
if eval $cmd; then 
    if [[ "$file" == *.cpp ]]; then
        suffix=".cpp"
        file_name=${file%"$suffix"}
        echo "Compiling C++ file $file"
        c++ -o ${file_name} $file
    else
        if [[ "$file" == *.c ]]; then 
        suffix=".c"
        file_name=${file%"$suffix"}
        echo "Compiling C file $file"
        gcc -o ${file_name} $file -lm
        else
            echo "File is not a .c or a .c++ file"
        fi

    fi
    
    echo -e "Compiling completed, executing!\n\n===========EXECUTION==========="

    ./${file_name}
else
    echo "File does not exist, do you want to create it?(y/n)"
    read x
    if [ $x == "y" ]; then
        if [[ "$file" == *.cpp ]]; then
            echo -e '#include "std_lib_facilities.h"\n\n\nint main(){\n\t\n\treturn 0;\n}' > $file
        else
            if [[ "$file" == *.c ]]; then
                echo -e "#include <stdio.h>\n#include <ctype.h>\n#include <math.h>\n int main(){\n\nreturn 0;\n}" > $file
            else
                echo "File is not a .c or a .c++ file"
            fi
        fi
    fi
fi