
create()
{
    echo "create $1 <- from function"
}

match(){
    echo "/$1/ {print $2}" > awk.txt
    cmd=$(awk -f awk.txt input.txt)
    echo "cmd: >$cmd<"
    eval $cmd
}

declare -A patterns
declare -A actions
i=1

while read pattern;
do
    read action
    action="\"$action\""
    a1=`echo $action | sed 's/\$[[:digit:]]/\\"&\\"/g'`
    echo "a1 $a1"
    echo "$pattern -> $action"
    patterns[$i]=$pattern
    actions[$i]=$a1
    i=$((i+1))
done < cmd.txt

pattern_matching()
{
    k=1
    for i in "${!patterns[@]}"
    do
        echo "i: $i match ${patterns[$i]}: ${actions[$i]}"
        match "${patterns[$i]}" "${actions[$i]}"
        echo "^^"
    done
}

pattern_matching