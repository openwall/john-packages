module.exports = {
  extends: ['@commitlint/config-conventional'],
  helpUrl: 'https://www.conventionalcommits.org/',
  // See https://github.com/dependabot/dependabot-core/issues/2445
  ignores: [(msg) => /Signed-off-by: dependabot\[bot]/m.test(msg)],

  rules: {
    'body-case': [2, 'always', 'sentence-case'],
    'body-max-line-length': [1, 'always', 72],
    'header-max-length': [1, 'always', 52],
    'type-enum': [
      2,
      'always',
      [
        'build',
        'chore',
        'ci',
        'deprecate',
        'docs',
        'feat',
        'fix',
        'perf',
        'refactor',
        'remove',
        'revert',
        'security',
        'style',
        'test'
      ]
    ]
  }
}
