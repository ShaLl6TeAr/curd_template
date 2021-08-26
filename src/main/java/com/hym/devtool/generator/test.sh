#!/bin/bash

while getopts f:r:p:s:t: OPT; do

  case ${OPT} in
  f)
    fun=${OPTARG};;
  r)
    rpc=${OPTARG};;
  p)
    product_code=${OPTARG};;
  s)
    software_version=${OPTARG};;
  t)
    type=${OPTARG};;
  \?)
    printf "[Usage] $(date '+%F %T') -m -o -o
    ODUCT_CODE> -s -t \n" >&2
    exit 1;;
  esac

done

# check parameter

if [ -z "${fun}" -o -z "${rpc}" -o -z "${product_code}" -o -z "${software_version}" -o -z "${type}" ]; then

  printf "[ERROR] $(date '+%F %T') following parameters is empty:\n-m=${fun}\n-o=${rpc}\n-p=${product_code}\n-s=${software_version}\n-t=${type}\n"
  exit 1

fi

# block enc
