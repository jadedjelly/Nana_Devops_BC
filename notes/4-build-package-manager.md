Handouts:
* [checklist](assets/files/04_Build_Tools_Checklist.pdf)
* [handout](assets/files/04_Build_Tools_Handout.pdf)


# What is a artifact?

A artifact is a file that is produced by a build process.
It is a binary or source code that is used to deploy an application.
For example a jar file is a artifact.
Java can produce a jar file or a war file.

# What is inside a jar file?

A jar file is a zip file that contains a manifest file and the classes and resources of the application.
The manifest file contains information about the application like the main class and the dependencies.
For example (Java)maven uses the pom.xml as it manifest file.
Node uses the package.json as it manifest file.

# What is a artifactory and why do we need it?

A artifactory is a repository that stores artifacts.
Nexus is a example of a artifactory. It stores the builded artifacts and the dependencies.
You can also push for example docker images to a artifactory as Nexus.

# Why Docker

It makes the process universal. You can run the same docker image on any machine. And you have less types of artifacts
to
manage. It also make the easier because you can use the same docker image for development, testing and production.

# Examples of artifact repos

* Nexus
* JFrog

# Installing

- Installed Intellij Community edtion locally using snap:

```bash
sudo snap install intellij-idea-community --classic
```

- To install npm, gradle etc I wrote a 2x scripts, one to install (_checks whether the apps exist or not_) all the tools, and the other to remove and cleanup, both available here:

* __Linux scripts__
* [Installer](../scripts/twn-04-installer.sh)
* [cleaner](../scripts/twn-04-cleanup.sh)

* __Windows Scripts__
* [Installer](../scripts/twn-04-installer.bat)
* [cleaner](../scripts/twn-04-cleanup.bat)


- all the plugins & dependencies have been downloaded by Intellij
- I had already installed Java SDK previously so I did not see any red warnings under variables, but if I had, I would have done the steps inside of Intellij to install the version of Java SDK we need (in this case 17)

- File > Project structure > clicked the drop down for SDK and selected "Downlaod JDK"

- click the green triangle, and select "run applciation.main(), intellig builds and runs the app

- In windows you need to add Java to the Env variables, Linux is intelligent enough to do it on install.
    - Simply open Env variables from the start menu, edit Path (under system), and add the full path of the Java app in here.

- I run _mvn package_ and mvn downloads and builds the app, as seen below

![mvn-build-success](/assets/notes_images/04-mvn-Build-succ.png)

# Setup Java Gradle Project in intellij

![gradle installed](/assets/notes_images/04-gradleetc-installed.png)

- I cloned Nanas repo and pushed a version to my own repo (for later testing & practice) [here](https://github.com/jadedjelly/TWN-java-app.git)

- Intellij downloaded all the dependencies & plugins automatically
- Again pressing the green triangle to ensure the app builds correctly, and after a little while I got the "Started app" output

- I run the following in intellijs terminal

```bash
gradle build
```

- It builds successfully, as below:

![gradle build](/assets/notes_images/04-gradlebuild.png)

- It's good to note, that there are 2x environments where we can build apps, one is inside the intellijs env, and the other is locally on the terminal (physically on the system)

# Setup Node Project in Intellij

- I have cloned the react-nodejs repo to my own repo, for later testing and practicing
- npm & nodejs are already installed on my device, via the script
- npm works the same as I do for the Wit site, running _npm install_ it will go off and download dependencies
- __note__: you have to execute _nvm install_ inside the directory that holds the _package.json_ file
- We then run the _node server_ command, which runs the node applciation, on port 3080, as per the line:

```javescript
app.listen(port, () => {
    console.log(`Server listening on the port::${port}`);
});
```

# Build an artifact