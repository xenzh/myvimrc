set verbose on

set auto-load safe-path /

set use-deprecated-index-sections on

set listsize 30
set confirm off

set print pretty on
set print object on
set print symbol on
set print static-members off
set print frame-arguments no
set print elements 0


# Clear the screen (on some systems Ctrl-L doesn't work)
define zz
    shell clear
end


# Print to file
define pdump
    if $argc == 0
        shell vim ./gdb.txt
        return
    else
        shell rm -f gdb.txt
        set pagination off
        set logging on
        if $argc == 2
            print/$arg0 $arg1
        end
        if $argc == 1
            print $arg0
        end
        set logging off
        set pagination on
    end
end


# When running google test binary, set filter for test cases to run
define gtt
    if $argc == 1
        set args --gtest_filter="*$arg0*"
    else
        set args
    end
end


python


# Override 'l' command shortcut to highlight current line
import re

class ColorList(gdb.Command):
    def __init__(self):
        gdb.Command.__init__(self, 'l', gdb.COMMAND_FILES, gdb.COMPLETE_FILENAME, False)

    def invoke(self, arg, from_tty):
        try:
            frame = gdb.execute('frame', True, True).splitlines()[0]
            thisLineNumber = int(re.search('[0-9]+$', frame).group(0))

            output = gdb.execute('list ' + arg, False, True).splitlines()
            for line in output:
                lineMatch = re.match(r'^ *([0-9]+)\t(.*)', line)
                number = lineMatch.group(1)
                code = lineMatch.group(2)

                if int(number) == thisLineNumber:
                    print('{s}{n} {a}\t{c}{e}'.format(s='\033[01;33m', e='\033[0m', a='->', n=number, c=code))
                else:
                    print(number + '\t' + code)
        except gdb.error as err:
            print(err)

ColorList()


# Recursively scan a folder for C++ sources, add matching folders to source search path
from os import path, walk, getenv

class ScanSources(gdb.Command):
    def __init__(self):
        gdb.Command.__init__(self, 'scan', gdb.COMMAND_FILES, gdb.COMPLETE_FILENAME, False)

    @staticmethod
    def _get_source_dirs(repo_dir):
        index = []
        for root, dirs, files in walk(repo_dir, topdown=True):
            dirs[:] = [d for d in dirs if not d.startswith('.') and not path.islink(d)]
            for f in files:
                if f.endswith('.h') or f.endswith('.cpp'):
                    index.append(root)
                    print('Found sources in {}'.format(root))
                    break
        return index

    def invoke(self, arg, from_tty):
        arg = arg if arg else '.'
        try:
            gdb.execute('set pagination off')
            print('Checking {}...'.format(path.realpath(arg)))
            dirs = ScanSources._get_source_dirs(arg)
            for d in dirs:
                gdb.execute('dir {}'.format(d))
            print('Added {} source dirs'.format(len(dirs)))
        except gdb.error as err:
            print(err)
        finally:
            gdb.execute('set pagination on')

ScanSources()


end
