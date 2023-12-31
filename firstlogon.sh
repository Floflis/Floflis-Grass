#!/bin/bash

export FLOPREFIX
export flofmach && export flofdistro && export flofarch && export osfullname && export osname && export osversion && export osbuild && export osbuildcodename && export updatepatch && export year && export layer && export nxtlayer && export distrobase && export user && export specialbuildattempt

flouser=$(jq -r '.name' /1/config/user.json)
export flouser

bash to-merge_firstlogon.sh
