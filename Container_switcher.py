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



for folder in os.listdir(BARA_Dir + '/modules'):
        for mod in os.listdir(BARA_Dir + '/modules' + '/' + folder):
            new_file = ''
            module = open(BARA_Dir + '/modules' + '/' + folder + '/' + mod, 'r')
            for line in module:
                if any(word in line for word in containers):
                    new_line = 'if (workflow.containerEngine == \'singularity\'){ container \'./containers_down/' + con + '.sif\' } else { container \'' + con + '\' } /n'
                    new_file = new_file + new_line
                else:
                    new_file = new_file + line
            module.close()
            module_edit = open(BARA_Dir + '/modules' + '/' + folder + '/' + mod, 'w')
            module_edit.write(new_file)
            module_edit.close()



