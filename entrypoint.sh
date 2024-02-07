#!/usr/bin/env bash

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
