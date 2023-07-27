#!/usr/bin/python3
#

'''
Simplify our deps.make file so each target does not repeat sub-dependencies.
This is useful to then create a clean .dot file.

Usage: simplify-dependencies.py < deps.make > dependencies.dot

This script probably uses several features of Python 3.x.
'''

import argparse
import os

class UnexpectedInput(Exception):
    pass

class NotFound(Exception):
    pass

class Project(object):

    def __init__(self, name, deps):
        self._name = name
        self._dependencies = deps
        #print ("name: ", self._name, " <- ", self._dependencies)

    def get_name(self):
        return self._name

    def get_deps(self):
        return self._dependencies

    def remove_dep(self, d):
        if d in self._dependencies:
            self._dependencies.remove(d)

def safe_name(name):
  if '-' in name:
    return '"' + name + '"'
  return name

def load_projects(path):
    projects = []
    with open(path + '/deps.make') as f:
        for line in f:
            line = line.strip()
            if len(line) == 0:
                continue
            if line[0] == '#':
                continue
            target_deps = line.split(':')
            if len(target_deps) > 2:
                raise UnexpectedInput
            deps = []
            if len(target_deps) > 1:
                deps = target_deps[1].split()
            projects.append(Project(target_deps[0], deps))

    return projects

def find_project(projects, name):
    for p in projects:
        if p.get_name() == name:
            return p
    raise NotFound

def simplify_projects(projects):
    for p in projects:
        deps = p.get_deps().copy()
        idx = 0
        while idx < len(deps):
            q = find_project(projects, deps[idx])
            subs = q.get_deps()
            for s in subs:
                p.remove_dep(s)
                if s not in deps:
                    deps.append(s)
            idx += 1

def output_dot(projects):
    output = ''
    output += 'digraph dependencies {\n'
    for p in projects:
        output += '    '
        output += safe_name(p.get_name())
        if len(p.get_deps()) > 0:
            output += ' [shape=box];\n'
        else:
            output += ' [shape=ellipse];\n'
    for p in projects:
        deps = p.get_deps()
        for d in deps:
            output += '    '
            output += safe_name(p.get_name())
            output += ' -> '
            output += safe_name(d)
            output += ';\n'
    output += '}\n'
    return output

def main():
    for description in __doc__.splitlines():
        if description:
            break
    parser = argparse.ArgumentParser(description=description)
    parser.add_argument('workdir', metavar='<working directory>', nargs='*', help='location of the deps.make and were we save the output')
    options = parser.parse_args()
    if len(options.workdir) != 1:
        raise NotFound
    output_path = options.workdir[0]

    projects = load_projects(output_path)
    print('Found ' + str(len(projects)) + ' projects in dependency graph.')
    simplify_projects(projects)
    output = output_dot(projects)

    with open(output_path + '/clean-dependencies.dot', 'w') as f:
        f.write(output)

    os.system('dot -Tsvg <' + output_path + '/clean-dependencies.dot >' + output_path + '/clean-dependencies.svg')
    print('Dependency graph generated in "' + output_path + '/clean-dependencies.svg".')

if __name__ == '__main__':
    main()

# vim: ts=4 sw=4 et
