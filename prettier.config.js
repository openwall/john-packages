module.exports = {
  // Overrides for Markdown
  // Change the defaults to JavaScript, since linters don't understand each other.
  overrides: [
    {
      files: ['**/*.md'],
      options: {
        proseWrap: 'always',
        printWidth: 120
      }
    },
    {
      files: ['**/*.js'],
      options: {
        semi: false,
        singleQuote: true,
        trailingComma: 'none'
      }
    }
  ]
}
