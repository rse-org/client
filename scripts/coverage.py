import csv
import os

script_dir = os.path.dirname(__file__) 
rel_path = "../coverage/test_cov_console.csv"
abs_file_path = os.path.join(script_dir, rel_path)
lis = list(csv.reader(open(abs_file_path)))
print('Coverage: ', lis[-1][3])
