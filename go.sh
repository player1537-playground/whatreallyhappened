#!/usr/bin/env bash

die() { printf $'Error: %s\n' "$*" >&2; exit 1; }

root=$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)
build=${root:?}/build
stage=${root:?}/stage
venv=${root:?}/venv
python=python3.8

_env=${root:?}/${ENV:+${ENV}.}env.sh
[ -f "$_env" ] && . "$_env"

go-venv() {
    if ! [ -d ${venv:?} ]; then
        if ! ${python:?} -c 'import virtualenv' &>/dev/null; then
            if ! ${python:?} -c 'import pip' &>/dev/null; then
                if ! ${python:?} -c 'import ensurepip' &>/dev/null; then
                    die "Cannot import ensurepip"
                fi
                ${python:?} -m ensurepip || die "Cannot ensurepip"
            fi
            ${python:?} -m pip install --user virtualenv || die "Cannot install virtualenv"
        fi
        ${python:?} -m virtualenv -p ${python:?} ${venv:?} || die "Cannot setup virtualenv"
    fi
    if [ $# -gt 0 ]; then
        ${venv:?}/bin/"$@"
    fi
}

go-cmake() {
	# [ -z "${SPACK_ENV:-}" ] && die "Not in a spack environment"

	cmake -H"${root:?}" -B"${build:?}" \
		-DCMAKE_INSTALL_PREFIX:PATH="${stage:?}" \
        "$@"
}

go-make() {
	make -C "${build:?}" \
		VERBOSE=1 \
		"$@"
}

go-exec() {
	export LD_LIBRARY_PATH=${LD_LIBRARY_PATH:+${LD_LIBRARY_PATH:?}:}${build:?}
	export LD_LIBRARY_PATH=${LD_LIBRARY_PATH:+${LD_LIBRARY_PATH:?}:}${stage:?}/lib
	exec "$@"
}

go-"$@"
