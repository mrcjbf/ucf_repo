from re import compile, match

def get_unit_name(folders, unit_number):
    regex = compile(unit_number + '-*')
    unit = list(filter(regex.match, folders))
    return unit