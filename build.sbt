name := "Gini"

version := "0.1"

scalaVersion := "2.12.3"

assemblyJarName in assembly := "gini.jar"

antlr4Settings

antlr4Version in Antlr4 := "4.7"

antlr4PackageName in Antlr4 := Some("org.glavo.gini.compiler")

// https://mvnrepository.com/artifact/io.vavr/vavr
libraryDependencies += "io.vavr" % "vavr" % "0.9.0"

// https://mvnrepository.com/artifact/io.vavr/vavr-match
libraryDependencies += "io.vavr" % "vavr-match" % "0.9.0"
