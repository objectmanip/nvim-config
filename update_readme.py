import os

map_definitions = ['map(', 'map2(', 'vim.api.nvim_set_keymap', 'vim.keymap.set', "["]
not_a_mode = ['mode']

def make_markdown_table(input_list):
    header = list(input_list[0].keys())
    table_string = "\n|"+"|".join(header)+"|\n"
    table_string += "|---"*(len(header))+"|\n"
    for keybind in input_list:
        row_string = "|"
        for header, cell in keybind.items():
            row_string += cell+"|"
        table_string += row_string+"\n"
    return table_string

def get_argument(inbetween: tuple, string, alt_inbetween = None):
    try:
        return string.split(inbetween[0], 1)[1].rsplit(inbetween[1], 1)[0]
    except IndexError as e:
        if alt_inbetween is None:
            return ""
        else:
            try:
                return string.split(alt_inbetween[0], 1)[1].rsplit(alt_inbetween[1], 1)[0]
            except IndexError as e:
                return ''

def get_keybind_description(params):
    if 'desc' in params:
        print('getting description from', params)
        description = get_argument(('\'', '\''), params.split('desc')[1], ('\"', '\"'))
    else:
        description = ''
    return description

def format_keybind(line):
    params = get_argument(('(', ')'), line)
    try:
        mode, keybind, function = params.split(',')[:3]
        if mode.strip() in not_a_mode:
            return None
    except IndexError:
        return None
    except ValueError:
        return None
    description = get_keybind_description(params)
    return {'mode': fix_string(mode), 'keybind': fix_string(keybind), 'function': fix_string(function), 'description': fix_string(description)}

def fix_string(string):
    return string.replace('<', ' \<').replace('>', '\> ').strip().strip('\'').strip('\"').replace('  ', ' ')

def empty_section(readme, heading):
    print(f'Emptying section \'{heading}\'')
    readme_without_heading = readme.split(f"# {heading}")[0]
    try:
        readme_after_heading = '\n# ' + readme.split(f'# {heading}')[1].split('\n# ')[1]
    except:
        print(f'Found no heading after \'{heading}\'')
        readme_after_heading = ''
    readme_to_heading = readme_without_heading + f"# {heading}\n"
    return readme_to_heading, readme_after_heading

def write_keybinds(readme):
    new_readme, readme_after_keybinds = empty_section(readme, 'Keybinds')
    for root, _, config_files in os.walk('./lua'):
        for file in [file for file in config_files if file.endswith('.lua')]:
            try:
                with open(os.path.join(root, file), 'r') as lf:
                    contents = lf.readlines()
            except:
                continue
            else:
                mapping_lines = [line for line in contents if any(line.strip().startswith(x) for x in map_definitions)]
                if mapping_lines:
                    print(f'Adding keybinds from {file}')
                    new_readme += f"## {file}\n"
                    keybinds = []
                    current_mode = "n"
                    for line in mapping_lines:
                        if line.strip().startswith('["'):
                            if line.endswith("= {"):
                                current_mode = line.split('"')[1]
                            else:
                                if current_mode.strip() in not_a_mode:
                                    continue
                                try:
                                    keybinds.append({'mode': current_mode,
                                                     'keybind': fix_string(line.split('"')[1]),
                                                     'function': fix_string(line.split('"')[3]),
                                                     'description': get_keybind_description(line)})
                                    print('Adding keybind switch: ', keybinds[-1])
                                except IndexError: continue
                        else:
                            keybind = format_keybind(line)
                            if keybind is None:
                                continue
                            keybinds.append(keybind)
                    try:
                        new_readme += make_markdown_table(keybinds) + "\n"
                    except:
                        print(f'No keybinds in {file}')
    new_readme += readme_after_keybinds
    return new_readme

def write_plugins(readme):
    new_readme, readme_after_plugins = empty_section(readme, 'Installed plugins')
    for i, file in enumerate(sorted([ file for file in os.listdir('./lua/plugins') if file.endswith('.lua') and not file.startswith('theme-')])):
        new_readme += f'- {file.rsplit(".")[0]}\n'
    new_readme += readme_after_plugins
    return new_readme

with open("README.md", 'r', encoding='utf-8') as readme_file:
    readme = readme_file.read()

new_readme = write_keybinds(readme)
new_readme = write_plugins(new_readme)

with open('README.md', 'w', encoding='utf-8') as readme_file:
    readme_file.write(new_readme)
