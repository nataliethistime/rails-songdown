class HelpController < ApplicationController
  before_filter :authenticate_user, :except => []

  def index
  end

  def songdown_syntax
    # This may not be the best solution, but I'm lazy so who cares.
    @examples = [
      """
Each verse has three parts.

  - a header, ends in \"+\", \"-\", \":\"
  - chords, lyrics, or both
  - an end marker: \"---\"

This is a header:
This is a line of chords
This is a line of lyrics
Chords and lyrics alternate
---
      """,
      """
The following is a **chords verse**.
You can tell from the \"+\".

Chords verse+
This is a chords verse
Each line is treated as chords
Good for introductions or instrumentals
---
      """,
      """
The following is a **lyrics verse**.
You can tell from the \"-\".

Lyrics verse-
This is a lyrics verse
Each line is treated as lyrics
---
      """,
      """
Use \"->\" to indicate where to go.

-> Chorus
-> Instrumental x4
-> Bridge x10 (drop 'n' build)
      """,
      """
Text can be written outside verses.

It can also be formatted.

  - **bold**
  - *italic*
  - [url link](https://google.com)

Oooh, so fancy!
      """,
      """
Here's an example of everything working together.

**Stevie Wonder - Sir Duke**

Introduction+
C    Am    Ab7
C    Am    Ab7
---

Verse 1:
C                    Am
Music is a world within itself,
       Ab7                  G7
With a language we all understand.
C                  Am
With an equal opportunity,
           Ab7                        G7
For all to sing,
                     G7
dance and clap their hands.
---

Chorus (x2):
C                    Gbm
They can feel it all over
F                    Dm   G
They can feel it all over people
---

-> Riff

Verse 2-
Music knows it is and always will,
Be one of the things that life just won't quit.
But here are some of music's pioneers,
That time will not allow us to forget.
---

-> Chorus
-> Riff
-> Chorus x2

      """,
    ]
  end

  def faq
  end
end

