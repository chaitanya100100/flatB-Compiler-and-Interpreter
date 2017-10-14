import os


test_files = os.listdir('../test-units')
print test_files

for test_file in test_files:
    print "\n\n", test_file, "\n\n"
    os.system("./bcc " + os.path.join("../test-units", test_file))
