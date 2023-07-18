import csv
import json
import os
script_dir = os.path.dirname(__file__) 
rel_path = "../assets/questions.json"
abs_file_path = os.path.join(script_dir, rel_path)

with open(abs_file_path, 'r') as json_file:
    questions_data = json.load(json_file)

csv_file = script_dir + '/questions.csv'

csv_headers = ['title', 'answer', 'c1', 'c2', 'c3', 'w1', 'w2', 'w3', 'explanation', 'link']

with open(csv_file, 'w', newline='') as file:
    writer = csv.DictWriter(file, fieldnames=csv_headers)

    writer.writeheader()

    for q in questions_data:
        writer.writerow({
            'title': q['body'],
            'answer': q['answer'],
            'c1': q['c1'],
            'c2': q['c2'],
            'c3': q['c3'],
            'w1': q['w1'],
            'w2': q['w2'],
            'w2': q['w3'],
            'explanation': q['explanation'],
            'link': q['link'],
        })

print(f"The questions have been successfully transformed and saved to {csv_file}.")
