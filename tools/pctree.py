"""Print out dependency tree for a given pkg-config package in JSON format. Omit duplicates.
Prepend with PKG_CONFIG_PATH=<your-custom-pc-files-dir>:<another-one> if needed.
pipe output to jq to get nice formatting / colors.
Usage: pctree.py <package-name>
"""

from subprocess import check_output as call
import argparse


def print_deps(indent_cnt, package, visited, last):
    was_visited = package in visited
    indent = " " * 2 * indent_cnt

    print("{indent}\"{package}\": {contents}".format(
        indent = indent,
        package = package,
        contents = "{" if not was_visited else "\"...\""
    ))

    out = None
    if not was_visited:
        out = call(["pkg-config", "--print-requires-private", package]).decode("utf-8")

    visited.add(package)

    if out :
        lines = out.split("\n")
        for i, dep in enumerate(lines):
            if dep:
                print_deps(indent_cnt + 1, dep, visited, i == len(lines) - 2)

    close = "}" if not was_visited else ""
    print("{indent}{close}{last}".format(
        indent = indent,
        close = close,
        last = "" if last else ","
    ))


def main():
    p = argparse.ArgumentParser()
    p.add_argument("name")

    args = p.parse_args()
    visited = set()
    print("{")
    print_deps(1, args.name, visited, True)
    print("}")


if __name__ == "__main__":
    main()
