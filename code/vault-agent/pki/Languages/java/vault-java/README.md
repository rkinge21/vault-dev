Build Instructions:

- Install maven on your MAC: brew install maven
- In the project directory, mvn clean, mvn compile, then mvn package
- java -jar to the target jar

Jenkisfile is also available to run as part of your pipeline
<img alt="Demo!" src="http://g.recordit.co/0OCENniTf9.gif" />


Installation Required:

- Java
    -   choco install jdk8 -y
- maven
    -   choco install maven --version=3.6.3


Commands:

- mvn clean
- mvn compile
- mvn package
- java -jar target/java-client-example-1.0-SNAPSHOT-jar-with-dependencies.jar
- check certs/ folder :)