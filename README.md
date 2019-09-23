# DrTests
[![Build Status](https://travis-ci.org/juliendelplanque/DrTests.svg?branch=master)](https://travis-ci.org/juliendelplanque/DrTests)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/juliendelplanque/DrTests/master/LICENSE)
[![Pharo version](https://img.shields.io/badge/Pharo-8.0-%23aac9ff.svg)](https://pharo.org/download)

A extendable, plugins-based UI for testing Pharo projects.

*/!\ Development of DrTests happens on Pharo main repository but issues can be opened here.*

## Install

Load stable version:

```smalltalk
Metacello new
	repository: 'github://juliendelplanque/DrTests/src';
	baseline: 'DrTests';
	load
```


Load development version:

```smalltalk
Metacello new
	repository: 'github://juliendelplanque/DrTests:dev/src';
	baseline: 'DrTests';
	load
```

