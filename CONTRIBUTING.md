# Contributing to Slack-Ruby-Client

This project is the work of [many contributors](https://github.com/slack-ruby/slack-ruby-client/graphs/contributors). You're encouraged to submit [pull requests](https://github.com/slack-ruby/slack-ruby-client/pulls) and to [propose features and discuss issues](https://github.com/slack-ruby/slack-ruby-client/issues).

In the examples below, substitute your GitHub username for `contributor` in URLs.

## Set Up

### Fork the Project

Fork the [project on GitHub](https://github.com/slack-ruby/slack-ruby-client) and check out your copy.

```bash
git clone https://github.com/contributor/slack-ruby-client.git
cd slack-ruby-client
git remote add upstream https://github.com/slack-ruby/slack-ruby-client.git
```

### Bundle Install and Test

Ensure that you can build the project and run tests. The gem supports Ruby 2.7 and newer.

```bash
bundle install
bundle exec rake
```

### Run Examples in Development

Sign up for Slack, create a private Slack workspace for yourself, then [create an app and obtain a token](https://docs.slack.dev/authentication/tokens/). To get a token, install the app in a workspace and use the "User OAuth Token" from the installed app settings.

Try running the examples in the [examples](examples) directory.

```bash
cd examples/hi_web
bundle install
SLACK_API_TOKEN=... bundle exec ruby hi.rb
```

## Contribute Code

### Create a Topic Branch

Make sure your fork is up to date and create a topic branch for your feature or bug fix.

```bash
git checkout master
git pull upstream master
git checkout -b my-feature-branch
```

### Write Tests

Try to write a test that reproduces the problem you're trying to fix or describes a feature that you want to build. Add tests to [spec](spec).

We definitely appreciate pull requests that highlight or reproduce a problem, even without a fix.

### Write Code

Implement your feature or bug fix.

Ruby style, Markdown, YAML, and spelling are enforced with [RuboCop](https://github.com/rubocop/rubocop), including [exception message conventions](https://github.com/dblock/rubocop-exception_messages), [rubocop-md](https://github.com/rubocop/rubocop-md), [rubocop-prose](https://github.com/dblock/rubocop-prose), [rubocop-spellcheck](https://github.com/dblock/rubocop-spellcheck), and [rubocop-yaml](https://github.com/dblock/rubocop-yaml). The main Gemfile includes lint dependencies only on Ruby 3.2 and newer so tests can continue running on older supported Ruby versions.

```bash
bundle install
bundle exec rake lint
```

Fix any style issues highlighted, auto-correcting safe issues with `bundle exec rubocop -a`. Exception message corrections require `-A`; review them and update message expectations in tests. Add reviewed project vocabulary, such as API names and contributor handles, to [.spellcheck.txt](.spellcheck.txt) rather than disabling spelling checks. To regenerate the baseline for generally ignored issues, including line lengths or code complexity metrics, run `bundle exec rubocop --auto-gen-config`.

The default `bundle exec rake` runs tests only. CI runs lint separately on Ruby 4.0.

### Run Benchmarks

Benchmarks in [benchmarks](benchmarks) measure iterations per second and allocations with [benchmark-ips](https://github.com/evanphx/benchmark-ips) and [benchmark-memory](https://github.com/michaelherold/benchmark-memory). Web client benchmarks answer requests in process with canned JSON, so they measure the client stack without network latency. Run them before and after a performance change and include the results in your pull request.

```bash
bundle exec rake benchmark
bundle exec ruby benchmarks/formatting.rb
BENCHMARK_TIME=5 bundle exec ruby benchmarks/web_client.rb
```

### Write Documentation

Document any external behavior in the [README](README.md). Keep each Markdown paragraph on a single line.

### Update Changelog

Add a line to [CHANGELOG](CHANGELOG.md) under the `(Next)` release, above `* Your contribution here.`, which must not be removed. Make it look like every other line, including a link to the pull request, your name, and a link to your GitHub account.

```markdown
* [#123](https://github.com/slack-ruby/slack-ruby-client/pull/123): Reticulated splines - [@contributor](https://github.com/contributor).
```

If you don't know the pull request number yet, open the pull request first, then amend the entry.

### Commit Changes

Make sure Git knows your name and email address.

```bash
git config --global user.name "Your Name"
git config --global user.email "contributor@example.com"
```

Writing good commit logs is important. A commit log should describe what changed and why.

```bash
git add ...
git commit
```

### Push

```bash
git push origin my-feature-branch
```

### Make a Pull Request

Go to `https://github.com/contributor/slack-ruby-client`, select your feature branch, and click the "Pull Request" button. Pull requests are usually reviewed within a few days.

### Rebase

If you've been working on a change for a while, rebase on `upstream/master` and amend your commit as needed.

```bash
git fetch upstream
git rebase upstream/master
git push origin my-feature-branch --force-with-lease
```

### Check on Your Pull Request

Go back to your pull request after a few minutes and check whether it passed CI. Everything should look green; otherwise, fix the issues and amend your commit as described above. Danger checks the changelog and the README table of contents and comments on the pull request when it finds problems.

### Be Patient

It's likely that your change will not be merged and that the nitpicky maintainers will ask you to do more, or fix seemingly benign problems. Hang in there! While you wait, you can help keep the Slack Web API up to date, see [below](#update-slack-web-api).

## Update Slack Web API

Please make sure to [create a separate branch](#create-a-topic-branch) for your changes.

The Slack Web API is generated from [slack-api-ref](https://github.com/slack-ruby/slack-api-ref), a maintained, machine-readable version of the Slack API documentation. The [Update API](.github/workflows/update_api.yml) workflow runs this weekly and opens a pull request. To update the Web API from the latest definition locally, run the following Rake task.

```bash
bundle exec rake slack:api:update
```

### Patching Slack Web API

Sometimes it's necessary to patch auto-generated Slack Web API methods. For example, we want to help clients with calling `to_json` on the `attachments` parameter sent to `chat_postMessage`. See [#20](https://github.com/slack-ruby/slack-ruby-client/issues/20).

The broad steps are:

1. Run `bundle exec rake slack:api:update` to check that existing patches are still valid. If you run into a `failed to apply patch` error, the auto-generated methods likely drifted from the last patch; follow the steps [below](#resolving-patch-errors). This may add new methods if the API has been updated; if so, please split them into separate pull requests.
2. Make a change to a generated file, for example `lib/slack/web/api/endpoints/chat.rb`.
3. Generate a patch with `git diff --no-color HEAD lib/slack/web/api/endpoints/chat.rb > lib/slack/web/api/patches/chat.added-support.patch`.
4. Run `bundle exec rake slack:api:update` to ensure that the patch is cleanly applied. Implement a test for the added or modified functionality and commit the patch file.

### Resolving Patch Errors

The auto-generated method files may drift over time, e.g. new arguments may be added or descriptions changed. Since previous patches were based on the older auto-generated files, Git may be unable to apply them to the new files. Resolving them requires some good ol' splicing:

1. Run `bundle exec rake slack:api:update SKIP_PATCH=true` to create the raw auto-generated files. Commit the files that you are updating, so you can run `git diff` later.
2. Go through the old patches for the files (e.g. `lib/slack/web/api/patches/chat.added-support.patch`), copying code into the new files. Run `git apply --reject path/to/patch-file.patch` to see hunks that couldn't be applied.
3. Continue with step 2 [above](#patching-slack-web-api).

## Thank You

Please do know that we really appreciate and value your time and work. We love you, really.
