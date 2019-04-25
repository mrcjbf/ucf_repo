from os import listdir
from re import compile, match
from shutil import copytree
from helpers.get_unit_name import get_unit_name
from helpers.get_list_of_dirs import get_list_of_dirs

path_to_homework = '../DataViz-Lesson-Plans/02-Homework/'

all_homeworks = get_list_of_dirs(path_to_homework)

homework_number = input('What number of the Unit Homework? ')

homework = get_unit_name(all_homeworks, homework_number)

which_to_copy = input('Do you want to copy Instructions or Solutions?  ')

path_to_copy = path_to_homework + homework[0] + '/' + which_to_copy

if which_to_copy == 'Instructions':
    copytree(path_to_copy, homework[0] + '/' + 'Homework/Instructions')
else:
    copytree(path_to_copy, homework[0] + '/' + 'Homework/Solutions')