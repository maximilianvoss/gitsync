# README

I was working on my private gitlab and I wanted to share the sources via github to the public. Therefor I needed a script which can be run periodically to fetch repos from my gitlab and push it to github.  
The script doing so can be found attached.

# Configuration

Put your configuration into: gitsync.config. It has to be in the working folder of gitsync.pl!  
Lines starting with a hash will be ignored

```
# Comments are marked with a Hash (#)
# 
# Config Syntax: 
# [id which is used for directory]: [src repo] -> [dest repo]
#
# Example:
# BeatTheWeight: git@git.voss.rocks:apps/BeatTheWeight.git -> git@github.com:maximilianvoss/BeatTheWeight.git

```