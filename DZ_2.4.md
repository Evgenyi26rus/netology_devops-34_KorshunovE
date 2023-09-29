1. $ git show 85024d3
commit 85024d3100126de36331c6982bfaac02cdab9e76 (tag: v0.12.23)
2. 
2.1 $ git show b8d720^
commit 56cd7859e05c36c06b56d013b55a252d0bb7e158
Merge: 58dcac4b79 ffbcf55817
2.2 commit 56cd7859e05c36c06b56d013b55a252d0bb7e158
Merge: 58dcac4b79 ffbcf55817
2.3 git log --oneline v0.12.24 -20 (после выбрал коммиты из своего диапазона)
33ff1c03bb (tag: v0.12.24) v0.12.24
b14b74c493 [Website] vmc provider links
3f235065b9 Update CHANGELOG.md
6ae64e247b registry: Fix panic when server is unreachable
5c619ca1ba website: Remove links to the getting started guide's old location
06275647e2 Update CHANGELOG.md
d5f9411f51 command: Fix bug when using terraform login on Windows
4b6d06cc5d Update CHANGELOG.md
dd01a35078 Update CHANGELOG.md
225466bc3e Cleanup after v0.12.23 release
85024d3100 (tag: v0.12.23) v0.12.23
2.4 git grep "providerSource" 
git log -L :providerSource:provider_source.go
commit 8c928e83589d90a031f811fae52a81be7153e82f
Author: Martin Atkins <mart@degeneration.co.uk>
Date:   Thu Apr 2 18:04:39 2020 -0700
2.5 git grep "globalPluginDirs"
git log -L :globalPluginDirs:plugins.go
commit 8364383c359a6b738a436d1b7745ccdce178df47
commit 66ebff90cdfaa6938f26f908c7ebad8d547fea17
commit 41ab0aef7a0fe030e84018973a64135b11abcd70
commit 52dbf94834cb970b510f2fba853a5b49ad9b1a46
commit 78b12205587fe839f10d946ea3fdc06719decb05
2.6 git log -S synchronizedWriters (самый ранний комментарий, соответственно он автор)
Author: Martin Atkins <mart@degeneration.co.uk>
