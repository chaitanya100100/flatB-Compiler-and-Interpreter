import os


test_files = os.listdir('../test-units')
print test_files

for test_file in test_files:
    print "\n", test_file
    os.system("./bcc " + os.path.join("../test-units", test_file))
    os.system("tail -n 1 bison_output.txt")
