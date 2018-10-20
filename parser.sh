declare -A patterns
declare -A actions

create()
{
    echo "create $1 <- from function"
}

listall()
{
    echo "->>>>listall"
}

match(){
    echo "/$1/ {print $2}" > awk.txt
    cmd=$(awk -f awk.txt input.txt)
#    echo "cmd: >$cmd<"
    eval $cmd
}

i=1
while read pattern;
do
    read action
    # add quotes to literals to print in awk
    # & is the matched string
    {

        action="\"$action\""
        action=`echo $action | sed 's/\$[[:digit:]]/\\"&\\"/g'`
        patterns[$i]=$pattern
        actions[$i]=$action
    }
    i=$((i+1))
done < cmd.txt

pattern_matching()
{
    k=1
    for i in "${!patterns[@]}"
    do
#        echo "i: $i match ${patterns[$i]}: ${actions[$i]}"
        match "${patterns[$i]}" "${actions[$i]}"
#        echo "^^"
    done
}

pattern_matching