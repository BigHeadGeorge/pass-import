<h1 align="center">Contribution</h1>

You want to contribute to `pass import`, **thank a lot for this.** You will find
in this page all the useful information needed to contribute to `pass-import`.

## How to run the tests?

`pass-import` has a complete test suite that provide functional and unit tests
for all the parts of the program. Moreover, it provides test coverage and code
health reports.

In order to run the tests, you need to install the following programs:
* [python-green][pgreen] as python test runner.
* [python-coverage][pcoverage] as code coverage system.

To run the tests, simply run: `make tests`


## How to contribute?

1. If you don't have git on your machine, [install it][git].
2. Fork this repo by clicking on the fork button on the top of this page.
3. Clone the repository and go to the directory:
```sh
git clone  https://github.com/this-is-you/pass-import.git
cd pass-import
```
4. Create a branch:
```sh
git checkout -b my_contribution
```
5. Make the changes and commit:
```sh
git add <files changed>
git commit -m "A message for sum up my contribution"
```
6. Push changes to GitHub:
```
git push origin my_contribution
```
7. Submit your changes for review: If you go to your repository on GitHub,
you'll see a Compare & pull request button, fill and submit the pull request.


## How to add the support for a new password manager?

1. Add your importer name and details in `pass_import.py`:
```python
importers = {
          ...
          'mymanager': ['MyManager', 'https://mymanager.com/'],
}
```

2. Add a `MyManager` class that inherits from one of the main importer class
`PasswordManagerXML` or `PasswordManagerCSV` (either you need to read XML or CSV
file) and write the necessary code and variables.
```python
class MyManager(PasswordManagerCSV):
      keys = {'title': 'title', 'password': 'password', 'login': 'login',
            'url': 'url', 'comments': 'comments', 'group': 'group'}
```

3. Add a file named `tests/db/mymanager[.csv,.xml]`. **No Contribution
will be accepted without this file.** This file must contain the exported data
from *your manager*. It has to be the exact export of the main test password
repository. This test data can be found in the `tests/exporteddb/.template.csv`.

4. Check the tests success, the coverage does not decrease and the code health.


## Data Organization

By definition, password-store does not impose any particular schema or type of
organisation of data. Nevertheless, `pass-import` respects the most common case
storing a single password per entry alongside with additional information like
emails, pseudo, URL and other sensitive data or metadata. Although the exact
list of data stored with the password can vary from entries in the password
store, the data imported always respects a simple `key: value` format at the
exception of the password that is always present in the first line.

`PasswordManager` is the main class that manage import from all the supported
password manager. `PasswordManagerXML` or `PasswordManagerCSV` inherit from it.
It manages data formatting from all the password manager.

Data are imported in PasswordManager.data, this is a list of ordered dict. Each
entry is a dictionary that contain the data for a password store entry. The
dictionary's key are divided in two sets:
1. The *standard keys*: `title`, `password`, `login`, `url`, `comments` and
`group`.
2. The *extra* keys that differ from password managers and contain the
description of any extra data we can find in the exported file.


[mt]: https://en.wikipedia.org/wiki/Mutation_testing
[pgreen]: https://github.com/CleanCut/green
[pcoverage]: http://nedbatchelder.com/code/coverage/
[git]: https://help.github.com/articles/set-up-git/
