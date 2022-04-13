import os

BARA_Dir = '/work/GitHub/BARA'
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

cut_containers = []
for i in containers:
    k = i.split()
    con = k[1].strip("'")
    cut_containers.append(con)


docker_containers = []
for i in cut_containers:
    if i.startswith('quay'):
        pass
    else:
    	if i in docker_containers:
    		pass
    	else:
    		docker_containers.append(i)

os.system("mkdir " + out_dir)

for cont in docker_containers:
    os.system('singularity pull --dir ' + out_dir + ' docker://' + cont)