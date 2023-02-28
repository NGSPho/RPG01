# Changelog Management

### How & When to create partial changelog
#### - When
After creating your merge request and jumping on your newly created branch you should create your changelog entry and edit it.
Only create a changelog entry when the feature/fix you are working on is relevant for the release changelog. For example, it's important to have an entry for user facing feature or feature other team should use.

#### - How
`changelog-manager add "Feature title"`
Then follow instructions to complete the template.
It will generate a file named `#MR-feature-title.yml` under `changelogs/unreleased`.
```
---
title: Feature title
type: added
merge_request: 205
```
You can now edit this file to add a short description for your feature.
Use | to preserve line break and don't forget the empty line between the title and the description.
```
---
title: |
  Feature title

  This is a short description for my very cool feature.  
type: added
merge_request: 205
```

```
changelog-manager add [title] [args]

Options:
 -d, --dry-run        option to prevent actually writing or committing anything
                                                                      [boolean]
 -m, --merge-request  option to automatically fill in the merge_request[string]
 -t, --type           set the type
       [string] [choices: "added", "fixed", "changed", "deprecated", "removed",
                                            "security", "performance", "other"]
 -a, --amend          use last git commit as default for title and ammend
                      generated file to previous commit               [boolean]
 -u, --git-username   option to automatically fill in the author value with
                      your configured Git user.name                   [boolean]
 -f, --force          overwrite an existing changelog entry if it already
                      exists                                          [boolean]
 -h                   Show help                                       [boolean]
 ```

### How To generate changelog for a release
`changelog-manager release`
Then follow instructions (input version number, ...).
This will update `changelogs/CHANGELOG.md` by merging unreleased or selected file to it with the new version number you choosed.
The manager then delete YAML file that where already merged.
```
changelog-manager release [options]

Options:
  -d, --dry-run      option to prevent actually writing or deleting anything.
                     Prints content to stdout                          [boolean]
  -o, --out          file name where to write the output (realtive to
                     released-dir)            [string] [default: "CHANGELOG.md"]
  -s, --strip-link   omit links to merge request                       [boolean]
  -n, --no-warnings  do not print warnings if variables in a template cannot be
                     replaced                                          [boolean]
  --fail             stop and exist with non zero status code if variables in
                     template cannot be replaced                       [boolean]
  --ci               disable interactive mode (by default all YAML files will be
                     used)                                             [boolean]
  --release-version  prefill release version                            [string]
  -h                 Show help                                         [boolean]
```

### HowTo install changelog-manager
- First, you need to install nodejs.
On windows there is a MSI installer
https://nodejs.org/en/download/
On debian style linux you can use the official node PPA:
https://nodejs.org/en/download/package-manager/

- You can then install changelog-manager itself using npm:
https://www.npmjs.com/package/changelog-manager
`npm install changelog-manager -g`
