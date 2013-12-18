# Introduction
This Vagrant build provides basic support for Scala and friends.

Note that while an attempt is being made to keep this machine generically useful, there may be packages installed which are specific to my use cases.  Be sure to take a look at the Puppet manifest before using this in your own projects.

# What's On This Box
- SBT - 0.13.1
- Java - 1.7
- Git - 1.7.9.5

# I Thought This Was a Scala Box?
Through SBT you can define the Scala version dependency of your project, and SBT will helpfully fetch and install the appropriate Scala version.  This is the most flexible way to handle multiple Scala projects in a development environment, and it has the added benefit of being easy to set up.

For an actual production box where you are likely to be deploying precompiled code and not running SBT, some other strategy will obviously be necessary to ensure that the appropriate Scala packages are installed.

See the [SBT documentation](http://www.scala-sbt.org/release/docs/Getting-Started/Basic-Def.html#how-build-sbt-defines-settings) for more details on setting your project's Scala version depdendency.
