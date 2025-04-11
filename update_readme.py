import os

keybinds = []
map_definitions = ['map(', 'map2(', 'vim.api.nvim_set_keymap', 'vim.keymap.set']

def make_markdown_table(input_list):
    header = list(input_list[0].keys())
    table_string = "|"+"|".join(header)+"|\n"
    table_string += "|---"*(len(header))+"|\n"
    for keybind in input_list:
        row_string = "|"
        for header, cell in keybind.items():
            row_string += cell+"|"
        table_string += row_string+"\n"
    return table_string

def get_argument(inbetween: tuple, string):
    return string.split(inbetween[0], 1)[1].rsplit(inbetween[1], 1)[0]

def format_keybind(line):
    params = get_argument(('(', ')'), line)
    mode, keybind, function = params.split(',')[:3]
    if 'desc' in params:
        try:
            description = get_argument(('\'', '\''), params.split('desc')[1])
        except:
            description = get_argument(('\"', '\"'), params.split('desc')[1])
    else:
        description = ''
    return {'mode': fix_string(mode), 'keybind': fix_string(keybind), 'function': fix_string(function), 'description': fix_string(description)}

def fix_string(string):
    return string.strip().strip('\'').strip('\"').replace('<', '').replace('>', ' ')

for root, _, config_files in os.walk('.'):
    for file in [file for file in config_files if file.endswith('.lua')]:
        try:
            with open(os.path.join(root, file), 'r') as lf:
                contents = lf.readlines()
        except:
            continue
        else:
            mapping_lines = [line for line in contents if any(line.startswith(x) for x in map_definitions)]
            for line in mapping_lines:
                keybinds.append(format_keybind(line))

keybind_table = make_markdown_table(keybinds)
with open("README.md", 'r', encoding='utf-8') as readme_file:
    readme = readme_file.read()

readme_without_keybinds = readme.split("# Keybinds")[0]
try:
    readme_after_keybinds = '# ' + readme.split('# Keybinds')[1].split('# ')[1]
except:
    readme_after_keybinds = ''
new_readme = readme_without_keybinds + "# Keybinds\n" + keybind_table

with open('README.md', 'w', encoding='utf-8') as readme_file:
    readme_file.write(new_readme)
