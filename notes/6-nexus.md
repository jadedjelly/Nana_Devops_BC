Handouts:
* [checklist](/assets/files/06_nexus_checklist.pdf)
* [handout](/assets/files/06_nexus_handout.pdf)

* Nexus suppots multiple types of artifacts (npm, docker, maven, etc)
* Can be used as a proxy repo
  * linked to a remote repo, checks locally if a plugin exists of not its retrived & and stored locally
* Also has a rest API
    - list all repos available
  ```  curl -u user:pwd -X GET 'http://{host}:8081/service/rest/v1 repositories'```
    - list all components in specific repository
  ```   curl -u user:pwd -X GET 'http://{host}:8081/service/rest/v1/components?repository=<INSERT_REPO>'  ```
    - list all assets for specific component
  ``` curl -u user:pwd -X GET 'http://6{host}:8081/service/rest/v1/components/<ID>'  ```

* It also has multi tenancy support what means you can create multiple repositories for different users. This is very useful when you have multiple teams that use the same nexus repository.

* You can also limit access to the repositories by using roles and users. This is very useful when you want to limit access to the repositories.

* You can also run Nexus inside a docker container. This is very useful when you want to run Nexus inside a container. And this is also very useful when you want to run Nexus inside a Kubernetes cluster.

# Install and Run Nexus on a cloud server 

__MIN Spec:__
* 4GB RAM / 2 CPUs

* after some script modifications, nexus is up and running on the droplet

![nexus running](/assets/notes_images/06-nexus-running.PNG)

# Nexus UI tour

* inside /opt/sonatype-work/nexus3 contains the admin.password 

# Publish artifact to repo

* uploading Maven & gradle projects to nexus

1. creating a repo user called Nexus
  * Settings > Security > Users > "Create local user"
    * Generally, you would do this via LDAP
      * _will attempt to connecxt to FreeIPA domain later_
2. We create a role for the nexus user, the "nx-anonymous" was given as a placeholder while we create a new role
  * Settings > Security > Roles > "Create role"
    * like any system, it was a list of predefined roles that can be added to the role, obvs use best practices as you would creating a user "least privlidge"
  * we add the "nx-repository-view-maven2-maven-snapshots-*"
  * we go back and add the correct role to the user
3. Add the below to the build.gradle file within the java-app

```console
apply plugin: 'maven-publish'

publishing {
    publications {
        maven(MavenPublication) {
            artifact("build/libs/my-app-$version" + ".jar"){
                extension 'jar'
            }
        }
    }

    repositories {
        maven {
            name 'nexus'
            url "http://46.101.161.66:8081/repository/maven-snapshots/"
            allowInsecureProtocol = true
            credentials {
                username project.repoUser
                password project.repoPassword
            }
        }
    }
}
```

4. add a gradle.properties, this is where we add the credentials for the nexus user

```console
repoUser = john
repoPassword = dA454FQDsjrggX#8
```

__NOTE:__ got a "'artifact' cannot be applied to '(groovy.lang.GString, groovy.lang.Closure)'" error for the artifact location, going to File > Invalidate caches and resatrt fixed the issue (seems to be a known issue with gradle & jetbeans)

* adding "allowInsecureProtocol = true" allows the user of http

5. Run build command for gradle (gradle build)
6. from the terminal within the root of the projects directory, we run _gradle publish_

![06-gradle-publish](/assets/notes_images/06-gradle-publish.PNG)

7. Browse > maven-snapshots, and we can see the jar file, as below:

![06-nexus-maven-snapshot](/assets/notes_images/06-nexus-maven-snapshot.PNG)

## Maven Project: Configure with Nexus

1. Added Repo url info

```console
    <distributionManagement>
        <snapshotRepository>
            <id>nexus-snapshots</id>
            <url>http://46.101.161.66:8081/repository/maven-snapshots/</url>
        </snapshotRepository>
    </distributionManagement>
```

2. we configure credentials for Maven via the .m2 folder located in ~/.m2
  * created a file called settings.xml, with the below:

```console
<settings>
    <servers>
        <server>
        <id>nexus-snapshots</id>
        <username>john</username>
        <password>dA454FQDsjrggX#8</password>
        </server>
    </servers>
</settings>
```

3. run _mvn package_
4. then run _mvn deploy_

![06-mvn-deploy](/assets/notes_images/06-mvn-deploy.PNG)

![06-nexus-mvn-repo](/assets/notes_images/06-nexus-mvn-repo.PNG)

