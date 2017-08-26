name := "Gini"

version := "0.1"

scalaVersion := "2.12.3"

assemblyJarName in assembly := "gini.jar"

// sbt 0.13.x
antlr4Settings

antlr4Version in Antlr4 := "4.7"

antlr4PackageName in Antlr4 := Some("org.glavo.gini.compiler")
