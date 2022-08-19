# chowdsp-ergo

`ergo` is Chowdhury DSP's in-house regression testing framework. This repository
serves as an example for how `ergo` works, while also providing regression testing
for our open-source plugins.

## What is `ergo`

`ergo` is a regression testing framework, that runs audio through a plugin,
and makes sure that the audio is the same as audio that was processed by an
earlier version of the plugin. The idea is that when you install a new version
of your plugin, and then open a project that was using a previous version of
the plugin, the project should sound exactly the same. `ergo` is a tool that
helps to make sure that is always the case!

`ergo` is still a very rough work-in-progress, but we do have plans to share the
code for it somewhere down the line.
