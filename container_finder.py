import os

BARA_Dir = '.'
out_dir = './containers_down'

search = 'container'
containers = []
if len(os.listdir(BARA_Dir + '/modules')) > 1:
    for folder in os.listdir(BARA_Dir + '/modules'):
        for mod in os.listdir(BARA_Dir + '/modules' + '/' + folder):
            module = open(BARA_Dir + '/modules' + '/' + folder + '/' + mod, 'r')
            for line in module:
                if search in line:
                    containers.append(line)
            module.close()

cut_containers = []
for i in containers:
    k = i.split()
    con = k[1].strip("'")
    cut_containers.append(con)


containers = []

for i in cut_containers:
    if i in containers:
        pass
    else:
        containers.append(i)

commands = []

for cont in containers:
    command = 'singularity pull --dir ' + out_dir + ' docker://' + cont
    commands.append(command)


command = ' & '.join(commands)

text_file = open("singularity_pre_download.sh", "w")
n = text_file.write('mkdir containers_down & ' + command)
text_file.close()

os.system('chmod +x singularity_pre_download.sh')