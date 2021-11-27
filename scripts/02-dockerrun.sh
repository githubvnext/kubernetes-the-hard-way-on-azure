docker build -t k8sclienttools:azure .

#docker run -ti --name az-config k8sclienttools:azure  az login --use-device-code
docker run --rm -it -v %userprofile%\.azure:/root/.azure -v C:\sshkeys:/root/.ssh -v C:\Users\Abarnwal\source\repos\k8sazure\scripts:/root/scripts  k8sclienttools:azure /bin/bash
