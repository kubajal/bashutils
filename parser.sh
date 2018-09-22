parse_def()
{
	# declare global associative
	declare -Ag $1
	while read q;
		do
			if [ `echo $q | grep \;\;` ]; then
				break
			fi
			keys=${q%" -> "*}
			value=${q#*" -> "}
			ks=`echo $keys | sed 's/,/\n/g'`
			for key in $ks;
			do
				cmd=$1
				cmd="$1[\"$key\"]=$value"
				eval $cmd
			done
		done
}

parse_defs()
{
	while read p; do
		#echo "p $p"
		if [ "`echo $p | grep def`" = "" ]; then
			return 1
		fi
		name=${p#*"def "}
		parse_def $name
	done
}

rules=()

parse_input_mapping()
{
	
	while read p; do
		rules+=("$p")
	done
}


parse_config()
{
	eval parse_defs
	eval parse_input_mapping
}

parse_input()
{
	for arg in "{$rules[@]}";
	do
		for i in "$@"; do
			echo ""
		done
	done
}

#parse_config < app_config

testt()
{
	t="1"
	if [ $t = "1" ]; then
		echo "asdf"		
		#declare -g $var
		hhh="test<"
	fi
}

match_string()
{
	string_pattern=${1%"@{"*}
	string=${2#$string_pattern*}
	pattern=${1#$string_pattern*}
	if [ $string = $2 ]; then
		echo "nieudane"
		return 1
	else
		echo "udane"
	fi
}

match_variable()
{
	v=${1#"@{"}
	v=${v%"}@"*}
	arr=(`echo $v | tr ":" " "`)
	type=${arr[0]}
	name=${arr[1]}
}

pattern_matching()
{
	pattern=$1
	string=$2
	i=0
	match_string $pattern $string
	match_variable $pattern $string
}

pattern_matching "asdf@{type:name}@fds" "asdffghj"