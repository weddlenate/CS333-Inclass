#!/bin/bash


# Prints usage information
function usage() {
	echo "Usage: $0"
	exit 1
}

# Pingsweep command for the Onyx nodes
function pingsweep_cmd() {
	local base="onyxnode"
	local found=0
	local total=0
	echo "Pinging nodes... TBD"
	for i in {1..10}; do
		local node="${base}${i}"
		ping -c 1 -W 1 "${node}" &> /dev/null
		if [ $? -eq 0 ]; then
			echo "Node ${node} is reachable."
			found=$((found + 1))
		else
			echo "Node ${node} is not reachable."
		fi
		total=$((total + 1))
	done

}

function main() {
	while getopts ":hp" opt; do
		case ${opt} in
		h) usage ;;
		p) pingsweep_cmd ;;
		\?)
			echo "Invalid option: -$OPTARG" >&2
			usage
			;;
		esac
	done
	shift $((OPTIND -1))
}

##  Script entry point
if [ $# -eq 0 ]; then
	usage
else
	main "$@"
fi