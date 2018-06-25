#
# Issue with java jvm.dll appears to be wrong path
#
# Get current path
#
Sys.getenv("JAVA_HOME")
#
# Reset path
#
Sys.setenv("JAVA_HOME" = "C:\\Program Files\\Java\\jre1.8.0_151")
#
# Show new Path
#
Sys.getenv("JAVA_HOME")
#
# Now can load xlsx and rJava