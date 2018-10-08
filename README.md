# Delete "stray" git branches

## tl;dr

Run `git branch--delete--stray` to delete local "remote-tracking" branches for which the branch being tracked has been deleted on the remote.

## Background

Git has a default disposition of keeping data unless it's explicitly thrown away; this extends to _(unnecessarily)_ holding onto references to so-called local "remote-tracking" branches where the branch being tracked has long since been deleted on the remote itself.

This utility refers to these local branches as "stray" branches, and includes two git extensions: one for listing all "stray" branches, and a second one for _(selectively)_ deleting them.

In case of the [GitHub Flow](https://guides.github.com/introduction/flow/) for instance, a local branch would become "stray" after a pull request gets merged and the underlying remote branch gets deleted... after the next `git fetch` it would be possible to identify the "stray" branch with something akin to `git branch --list --merged`.

But that's not the only scenario that results in "stray" branches, which is why the various "solutions" you find on Stack Overflow don't typically cover all edge cases, whereas this utility does;  it also prefers git plumbing over git porcelain, and it implements most of its logic in a library, making it very easy indeed to implement even more git extensions for dealing with "stray" branches.

## What's in a name?

In the context of this utility, a branch is considered "stray" if it is what git calls a "remote-tracking" branch but one where the remote branch it was tracking no longer exists _(ie. where the branch it was tracking has been deleted on the remote, e.g. on GitHub or on Bitbucket)_.

The term "stray" was chosen to avoid confusion with existing git terminology like ''merged", "tracked" and even "orpaned".

Also, the names of the two git extensions implemented by this utility:

* `git-branch--list--stray`
* `git-branch--delete--stray`

... were chosen two mimic some existing `git branch` commands:

* `git branch --list --merged`
* `git branch --delete`

respectively.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'git-branch--stray'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install git-branch--stray

## Usage

After installing the gem, you will have two new git extensions in your environment: `git-branch--list--stray` will list all stray branches, whereas `git-branch--delete--stray` will iterate over the list and - after prompting for confirmation - delete any stray branches in your git workarea.

Because they will be in your local `$PATH` you can run them as so-called git subcommands as follows:

```
git branch--list--stray
git branch--delete-stray
```

Most likely, though, you will want to create some [git aliases](https://git-scm.com/book/en/v2/Git-Basics-Git-Aliases) to make it easier to work with the two utility scripts:

```
git config --global alias.bls branch--list--stray
git config --global alias.bds branch--delete--stray
```

Alternatively, a similar approach can be used to add either of the scripts to your existing git aliases and/or git utility scripts.

## Pruning

The two git extensions work best if your git workflow includes regular pruning of remote-tracking references that no longer exist on the remote, either by running `git fetch --prune` when syncing with the remote in question, or else configuring [git's pruning behaviour](https://git-scm.com/docs/git-fetch#_pruning) for your environment.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/pvdb/git-branch--stray.
