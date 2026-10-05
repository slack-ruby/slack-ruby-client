# Contributor guidance

Read [CONTRIBUTING.md](CONTRIBUTING.md) first for setup, tests, lint, changelog, pull request, and API patch instructions. Keep those instructions there rather than duplicating them here.

- Preserve the supported-Ruby test matrix when changing lint dependencies.
- When upgrading lint tooling, review safe corrections and baseline only remaining unrelated offenses.
- Exception message corrections can change public error strings. Update matching specs, including handwritten specs under `spec/slack/web/api/endpoints/custom/`.
- Use lowercase exception messages without a trailing period, including messages passed to `super` in error constructors; the exception-message cops may not detect that form. Preserve upstream Slack error codes and dynamically supplied messages.
- Load RuboCop extensions through `plugins:`. When upgrading an extension, migrate renamed cops and obsolete parameters, review safe corrections, and preserve existing behavior rather than blindly applying unsafe fixes.
- Do not edit the API-reference submodule or include existing submodule changes unless requested.
- The API update task pulls the latest reference and can generate unrelated changes. Verify the patch against both the latest and pinned reference; keep unrelated generated updates out of a focused PR. Custom endpoint specs are handwritten despite their location under `endpoints/`.
- Do not suppress environment warnings in application code or tests. Report local validation limitations explicitly; CLI specs compare subprocess output and can fail when Bundler emits unrelated warnings.
