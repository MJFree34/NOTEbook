#!/bin/sh

brew install swiftlint
swiftlint lint $CI_WORKSPACE_PATH
