#!/usr/bin/env bash

die() { printf $'Error: %s\n' "$*" >&2; exit 1; }

root=$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)
build=${root:?}/build
stage=${root:?}/stage

_env=${root:?}/${ENV:+${ENV}.}env.sh
[ -f "$_env" ] && . "$_env"

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
	export LD_LIBRARY_PATH=${LD_LIBRARY_PATH:+${LD_LIBRARY_PATH:?}:}${stage:?}/lib
	exec "$@"
}

go-"$@"
