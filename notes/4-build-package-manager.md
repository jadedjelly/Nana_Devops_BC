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
__NOTE:__ _Due to an issue, I am back working off windows, till I can resolve the issue on RHEL9 (changed from Ubuntu, to aid in RHCSA course)_

__NOTE:__ _I have created a script for windows that installs tools, like gradle, node, etc_

# Build an artifact

* Use a build tool
    * specific to the programming laguage:
        * Jave:
            * Maven, Gradle, Ant
        * Javascript:
            * Webpack, Vite, Parcel, Gulp
        * Python:
            * Setuptools, Poetry, Pybuilder
        * C/C++:
            * Make, CMake, Ninja
        * Rust:
            * Cargo
        * Go:
            * built-in (go build, go test, etc)
        * .Net/C#:
            * MSBuild, dotnet CLI
        * Haskell:
            * Cabal, Stack
        * Scala:
            * sbt (Simple build tool)

* these will install the dependencies
* Maven, uses XML
* gradle, uses groovy

* for Gradle, run the below:

```console
gradle build
```

* for Maven, run the below:

```console
mvn install
```
* with the above cmd, we get a new folder called "target", this will have the .jar file

# Build tools for development / Managing dependencies

* you need to have these apps installed locally, assuming you would need these installed on the likes of Jenkins (probably as a plugin)

* for maven, they are in a pom.xml file, see below for a snippet:

```xml
<dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
            <version>3.0.5</version>
        </dependency>

        <dependency>
            <groupId>junit</groupId>
            <artifactId>junit</artifactId>
            <version>4.13.2</version>
            <scope>test</scope>
        </dependency>
```

* for Gradle, they are in build.gradle file, a snippet below:

```gradle
    maven { url 'https://repo.spring.io/snapshot' }
}

dependencies {
    implementation 'org.springframework.boot:spring-boot-starter-web'
    implementation group: 'net.logstash.logback', name: 'logstash-logback-encoder', version: '7.3'
    testImplementation group: 'junit', name: 'junit', version: '4.13.2'
    implementation "javax.annotation:javax.annotation-api:1.3.2"
}

```

* these dependencies come from a repository used by maven & gradle, located at https://mvnrepository.com

# Need a lib for ElasticSearch connection
Flow:
1. Find a dependency with name & version
2. you add it to dependencies file (eg: pom.xml)
3. Gets downloaded locally (local maven repo)

Intellij, automatically downloaded the dependencies at 1st run (for maven), my vscode does it for certain languages

# Run the app

* to run the app locally, you run the below from the cmd:

```console
java -jar [path to .jar file]
```

# Build JS Applications

__NOTE:__ node-app has been uploaded to my own repo, for later testing

* JS doesnt have a special artifact type, so can be made into a ZIP or TAR file
* alternatives can be npm or yarn, still use package.json
    * I use npm for my website
* note: npm & yarn are _Package managers_ - like chocolatey (i assume)

* the below command installs the dependencies
```console
npm install
```

* npm & yarn have their repo (https://www.npmjs.com/package/mongodb (mongodb example))
* inc'd in the zip / tar, app code, not dependencies, you must install 1st, Unpack the zip/tar and run on the server
* you need to copy the artifact __&__ the package.json file to the server!!
* we run the below,
```console
npm pack
```

* npm packed all the files into a .tar file
* to run locally, we run the below:

```console
npm start
```

* for an app that has a front end and back end, viewing the tree for the react-nodejs-example, you can see the api (backend) and the js & css files in /my-app/src/
* Frontend code needs to be transpiled, code needs to be compressed
* Webpack is the most common, see below for an example:

![webpack](/assets/images/webpack.PNG)

* we run the following:

```console
npm install
npm run build
```

* a new file is created "server.bundle.js" which is heavily compressed

# dependencies for frontend code

* It's recommended to have the same package management tools for both front and back end

__NOTE:__ We'll explore more about these tools, with my own projects, esp with the WiT site using node & npm

# Publish an artifact

* mvn, gradle, etc have commands that can push the artifact to a server, however in teh real world, we dont do this anymore (local testing inc'd). We would push these to a repo (git) then pull down via docker or jenkins
    * The same way I did at the S/w dev firm for the firmware updates

# Build tools and Docker

* instead of having multiple types of artifact, we use just one, a Dockerfile, snippet below for the node app: (note, we go deeper later in the course)


```dockerfile
FROM node:10 AS ui-build
WORKDIR /usr/src/app
COPY my-app/ ./my-app/
RUN cd my-app && npm install && npm run build

FROM node:10 AS server-build
WORKDIR /root/
COPY --from=ui-build /usr/src/app/my-app/build ./my-app/build
COPY api/package*.json ./api/
RUN cd api && npm install
COPY api/server.js ./api/

EXPOSE 3080

CMD ["node", "./api/server.js"]
```

* we dont install dependencies on the server, everything gets done inside the image
* dockerimage is an alternative for all other artifact types
* You still need to build the apps! but it will end up being a dockerimage
* below is a dockerfile for the java-app

```dockerfile
FROM amazoncorretto:17-alpine-jdk

EXPOSE 8080

COPY ./build/libs/java-app-1.0-SNAPSHOT.jar /usr/app
WORKDIR /usr/app

ENTRYPOINT ["java", "-jar", "java-app-1.0-SNAPSHOT.jar"]
```

# Build tools for Devops Engineers

* while technically speaking, you probably don't need to know the build tools, from working in Ops, knowing what my devs were working with made it easier for me to understand what happens when these things break, as a Devops Eng, I suspect I'd need the same knowledge in order to better prepare any scripts that I might / will write to automate things. And lets face it, I want to know what the devs are using, so I can be a onestop shop!!!
* I also need to know how these apps are being compiled etc, in order ot configure CI/CD pipelines!
* Install dependencies > run tests > build/bundle app > push to repo
    * this would be the flow for a jenkins pipeline
* 