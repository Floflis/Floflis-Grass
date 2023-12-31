#!/bin/bash

flouser=$(jq -r '.name' /1/config/user.json)
export flouser
bash to-merge_firstlogonroot.sh
