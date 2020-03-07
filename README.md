# Songdown

Songdown is a web app for storing chord charts.

# Features

  - Transposing of songs
  - Search all songs
  - Add a YouTube video to a song
  - … and much more!

# Running

Requires Ruby version `2.6.5`

```bash
bundle install
rails bower:install # Ensure you have node, npm, and bower installed on your system
rails s
```

# Changes

## Versions

### 0.2.0

- Removed meme and Batman reference from home page.
- Fix editor page not working.
- Add loading indicator.
- Performance improvements (using Turbolinks).
- Added a warning for those using the site with JavaScript disabled.
- Fixed bug with the order of setlist items getting muddled.
- Made the notifications look nice.
- Other minor changes nobody will notice.

### 0.1.2

- Disabled Turbolinks cache.

### 0.1.1

- Fixed issue with Turbolinks and JavaScript not mixing well.

### 0.1.0

- Initial version of the app.

# Doing a Release

*(This is mostly for myself to remember how to do this)*

1. Check that working directory is clean.
2. Document changes in the README.
3. `git tag -a v0.5.3 -m "This is a cool release"`
4. `git push origin v0.5.3`
5. `cap production deploy`

# License

MIT

