#!/usr/bin/env bash

cd "${GITHUB_WORKSPACE}" || exit 1
git config --global --add safe.directory "${GITHUB_WORKSPACE}" || exit 1

export REVIEWDOG_GITHUB_API_TOKEN="${INPUT_GITHUB_TOKEN}"

undercover-checkstyle \
  --lcov ${INPUT_LCOV} \
  --compare origin/${INPUT_REF} \
  | reviewdog \
      -f=checkstyle \
      -name="undercover" \
      -reporter="${INPUT_REPORTER:-github-pr-check}" \
      -filter-mode="${INPUT_FILTER_MODE}" \
      -fail-on-error="${INPUT_FAIL_ON_ERROR}" \
      -level="${INPUT_LEVEL}" \
      ${INPUT_REVIEWDOG_FLAGS} || EXIT_CODE=$?

exit ${EXIT_CODE}
