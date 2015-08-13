#!/bin/bash

# Copyright 2015 Remi Even
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

old_ifs=$IFS

# You can modify the following variables
offset=2

author="{{author}}"
year="{{year}}"
project_name="This program"

ext="java"

comment_start='/*'
comment_middle=' *'
comment_end=' */'

license='{{file_name}}
Copyright (C) {{author}} {{year}}

This file is part of {{project_name}}.

{{project_name}} is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

{{project_name}} is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with {{project_name}}. If not, see <http://www.gnu.org/licenses/>.'

# End of modifiable variables

cwd=$(pwd)

verbose=false

function generate_header_content {
file_name=$1
    echo -e "$license" \
    | sed -e "s/{{author}}/$author/g" \
    | sed -e "s/{{year}}/$year/g" \
    | sed -e "s/{{project_name}}/$project_name/g" \
    | sed -e "s/{{file_name}}/$file_name/g" \
    | sed -e "s/\(.*\)/$comment_middle \1/" \
    >> .licensifytmp
}

function add_header {
    goal=$1
    file_name=$(basename $goal)
    i=0
    echo -n '' > .licensifytmp
    while IFS='' read -r line || [[ -n $line ]]; do
        if [[ $i -eq $offset ]]; then
            echo "$comment_start" >> .licensifytmp
            generate_header_content $file_name
            echo -e "$comment_end\n" >> .licensifytmp
            if [[ $verbose = true ]]
            then
                echo "Added header to $(basename $goal)"
            fi
        fi
        i=$(($i + 1))
        echo "$line" >> .licensifytmp
    done < $goal
    cat .licensifytmp > $goal
}

if [[ $1 = '-v' ]]
then
    verbose=true
    shift
fi

if [[ $# -eq 0 ]]
then
    goals=$(find $cwd -name *.$ext)
else
    goals=$*
fi

for goal in $goals; do
    add_header $goal
done

rm .licensifytmp
IFS=$old_ifs
