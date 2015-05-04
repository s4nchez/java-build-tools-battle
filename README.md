# The Battle of Java Build Tools

This is a playground project to compare different java build tools.

## The project

The project is a standalone webapp (using jetty and [utterlyidle](https://github.com/bodar/utterlyidle)). The build should:

* Download dependencies
* Compile source code
* Create executable fatjar

### Make + shavenmaven

Building:
```bash
make all
```

Testing:
```bash
java -jar out/java-playground.jar
```

### Gradle

Building:
```bash
gradle shadowJar
```

Testing:
```bash
java -jar build/libs/java-playground-1.0-all.jar
```

### Maven

Building:
```bash
make install
```

Testing:
```bash
java -jar target/java-playground-1.0.0-SNAPSHOT.jar
```
