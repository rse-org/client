from googletrans import Translator
import json
import codecs
import os

translator = Translator()

languages = [
    'es',
    'vi',
]

def translate_dict(data, dest_language):
    translated_dict = {}
    for key, value in data.items():
        if isinstance(value, dict):
            translated_dict[key] = translate_dict(value, dest_language)
        else:
            translated_dict[key] = translator.translate(value, src='en', dest=dest_language).text.title().title()
            print(translated_dict[key])
    return translated_dict

script_dir = os.path.dirname(__file__) 
rel_path = '../lib/l10n/app_en.arb'
abs_file_path = os.path.join(script_dir, rel_path)

for l in languages:
    with open(abs_file_path) as file:
        data = json.load(file)
        translated_data = translate_dict(data, l)

        with codecs.open(os.path.join(script_dir, '../lib/l10n/app_')  + l + '.arb', 'w', encoding='utf8') as f:
            json.dump(translated_data, f, ensure_ascii=False)

print('Successfully translated!')