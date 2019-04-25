from os import path, makedirs, listdir
from re import compile, match
from helpers.remove_ds_store import remove_ds_store_file
from helpers.get_unit_name import get_unit_name
from helpers.get_list_of_dirs import get_list_of_dirs

folders_to_make = [1, 2, 3, 'Homework']

path_to_units = '../DataViz-Lesson-Plans/01-Lesson-Plans/'

units = get_list_of_dirs(path_to_units)

unit_number = input('What number of the Unit? ')

unit = get_unit_name(units, unit_number)

if not path.exists(unit[0]):
    makedirs(unit[0])

for x in range(len(folders_to_make)):
    makedirs(unit[0] + '/' + str(folders_to_make[x]))
    open(unit[0] + '/' + str(folders_to_make[x]) + '/.gitkeep', 'w')
