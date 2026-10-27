#!/bin/sh
# tagpr.command から呼ばれ、Chart.yaml の version / appVersion と README のバッジをリリース予定のバージョンに更新する
set -eu

chart_dir=chart/k8s-socat
version=${TAGPR_NEXT_VERSION#v}

update() {
  file=$1
  shift
  sed -E "$@" "$file" > "$file.tmp"
  mv "$file.tmp" "$file"
}

update "$chart_dir/Chart.yaml" \
  -e "s/^version: .*/version: ${version}/" \
  -e "s/^appVersion: .*/appVersion: \"${version}\"/"

update "$chart_dir/README.md" \
  -e "s/(Version: )[^]]+(\]\(https:\/\/img\.shields\.io\/badge\/Version-)[^-]+-/\1${version}\2${version}-/" \
  -e "s/(AppVersion: )[^]]+(\]\(https:\/\/img\.shields\.io\/badge\/AppVersion-)[^-]+-/\1${version}\2${version}-/"
