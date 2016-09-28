#!/bin/bash
set -u

usage() {
  echo "Usage : $0 [-w] [title_name] [author_name]" 1>&2
}

main () {
  cd $(cd $(dirname $0) && pwd)
  OPEN_EDITOR=0
  for ARG; do
    case "$ARG" in
      -*)
      while getopts w OPT "$ARG"; do
        case "$OPT" in
          w) OPEN_EDITOR=1;;
          *) usage; exit 1;;
        esac
      done
      ;;
    esac
  done

  shift $(expr $OPTIND - 1)
  [ $# -ne 2 ] && usage && exit 1

  slug="$1"
  author="$2"
  file_name="post/$(date +"%Y-%m-%d")-${slug}.md"
  file_path="content/$file_name"
  if [ ! -e "$file_path" ]; then
    hugo new "$file_name"
    sed -i '' -e 's/title = \".*\"/title = \"\"/g' "$file_path"
    sed -i '' -e "s/slug = \".*\"/slug = \"$slug\"/g" "$file_path"
    sed -i '' -e "s/author = \".*\"/author = \"$author\"/g" "$file_path"
  else
    echo "$file_name already exists."
  fi

  [ $OPEN_EDITOR -eq 1 ] && atom "$file_path"

}
main "$@"