Handouts:
* [checklist](/assets/files/05_Cloud&IaaS_checklist.pdf)
* [handout](/assets/files/05_Cloud&IaaS_handout.pdf)

# What is DigitalOcean?

* Is a cloud provider, offering a rnage of services. It's a infrastructure as a Service (IaaS), you can create VMs (droplet), DBs, load balancers, etrc
* Very easy to setup, and have been running Digital ocean for awhile, prefer it over Linode

* after creating the droplet, created ssh key, and ran the first few lines of the script [here](/scripts/DO_droplet_setup.sh)

# Deploy & run application artifact on droplet

* Build jar file > copy to droplet > run app on server

* from the projects folder, we run the following:

```console
gradle build
scp .\build\libs\TWN-java-react-example.jar root@161.35.81.246:/root
java -jar TWN-java-react-example.jar &
# the & runs the app in the background, and you can use netstat (via netools)
```

* after opening the specific port on teh droplet (7071), we can see the below when we go to the droplets Pub IP:

![react_example_droplet](/assets/images/react_example_droplet.PNG)

# Create & configure a linux user on a cloud server

* I did this already when I updated the server (habit), long story short, useradd & usermod -aG, it's also in teh droplet script