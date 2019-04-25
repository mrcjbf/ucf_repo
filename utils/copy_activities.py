from os import listdir
from re import compile, match
from shutil import copytree, ignore_patterns, rmtree
# from helpers.get_unit_name import get_unit_name 
# from helpers.get_list_of_dirs import get_list_of_dirs

def get_unit_name(folders, unit_number):
    regex = compile(unit_number + '-*')
    unit = list(filter(regex.match, folders))
    return unit

def get_list_of_dirs(path):
    dirs = listdir(path)
    return dirs

path_to_units = '../DataViz-Lesson-Plans/01-Lesson-Plans/'

units = get_list_of_dirs(path_to_units)

which_to_copy = input('Do you want to copy the Unsolved or Solved? ')

unit_number = input('What number of the Unit? ')

unit = get_unit_name(units, unit_number)

folder_to_copy = input('What folder to copy? ')

path_to_copy = path_to_units + unit[0] + '/' + folder_to_copy + '/Activities'

if which_to_copy == 'Unsolved':
    copytree(path_to_copy, unit[0] + '/' + str(folder_to_copy) + '/Activities', ignore=ignore_patterns('Solved'))
else:
    rmtree(unit[0] + '/' + str(folder_to_copy) + '/Activities')
    copytree(path_to_copy, unit[0] + '/' + str(folder_to_copy) + '/Activities')
