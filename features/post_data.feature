Feature: Post data
  As a hacker who likes to blog
  I want to be able to embed data into my posts
  In order to make the posts slightly dynamic

  Scenario: Use post.title variable
    Given I have a _posts directory
    And I have a _layouts directory
    And I have the following post:
      | title     | date      | layout | content                 |
      | Star Wars | 3/27/2009 | simple | Luke, I am your father. |
    And I have a simple layout that contains "Post title: {{ site.posts.first.title }}"
    When I run jekyll
    Then the _site directory should exist
    And I should see "Post title: Star Wars" in "_site/2009/03/27/star-wars.html"

  Scenario: Use post.url variable
    Given I have a _posts directory
    And I have a _layouts directory
    And I have the following post:
      | title     | date      | layout | content                 |
      | Star Wars | 3/27/2009 | simple | Luke, I am your father. |
    And I have a simple layout that contains "Post url: {{ site.posts.first.url }}"
    When I run jekyll
    Then the _site directory should exist
    And I should see "Post url: /2009/03/27/star-wars.html" in "_site/2009/03/27/star-wars.html"

  Scenario: Use post.date variable
    Given I have a _posts directory
    And I have a _layouts directory
    And I have the following post:
      | title     | date      | layout | content                 |
      | Star Wars | 3/27/2009 | simple | Luke, I am your father. |
    And I have a simple layout that contains "Post date: {{ site.posts.first.date }}"
    When I run jekyll
    Then the _site directory should exist
    And I should see "Post date: Fri Mar 27" in "_site/2009/03/27/star-wars.html"

  Scenario: Use post.id variable
    Given I have a _posts directory
    And I have a _layouts directory
    And I have the following post:
      | title     | date      | layout | content                 |
      | Star Wars | 3/27/2009 | simple | Luke, I am your father. |
    And I have a simple layout that contains "Post id: {{ site.posts.first.id }}"
    When I run jekyll
    Then the _site directory should exist
    And I should see "Post id: /2009/03/27/star-wars" in "_site/2009/03/27/star-wars.html"

  Scenario: Use post.content variable
    Given I have a _posts directory
    And I have a _layouts directory
    And I have the following post:
      | title     | date      | layout | content                 |
      | Star Wars | 3/27/2009 | simple | Luke, I am your father. |
    And I have a simple layout that contains "Post content: {{ site.posts.first.content }}"
    When I run jekyll
    Then the _site directory should exist
    And I should see "Post content: <p>Luke, I am your father.</p>" in "_site/2009/03/27/star-wars.html"

  Scenario: Use post.categories variable when category is in a folder
    Given I have a movies directory
    And I have a movies/_posts directory
    And I have a _layouts directory
    And I have the following post in "movies":
      | title     | date      | layout | content                 |
      | Star Wars | 3/27/2009 | simple | Luke, I am your father. |
    And I have a simple layout that contains "Post category: {{ site.posts.first.categories }}"
    When I run jekyll
    Then the _site directory should exist
    And I should see "Post category: movies" in "_site/movies/2009/03/27/star-wars.html"

  Scenario: Use post.categories variable when categories are in folders
    Given I have a movies directory
    And I have a movies/scifi directory
    And I have a movies/scifi/_posts directory
    And I have a _layouts directory
    And I have the following post in "movies/scifi":
      | title     | date      | layout | content                 |
      | Star Wars | 3/27/2009 | simple | Luke, I am your father. |
    And I have a simple layout that contains "Post categories: {{ site.posts.first.categories | array_to_sentence_string }}"
    When I run jekyll
    Then the _site directory should exist
    And I should see "Post categories: movies and scifi" in "_site/movies/scifi/2009/03/27/star-wars.html"

  Scenario: Use post.categories variable when category is in YAML
    Given I have a _posts directory
    And I have a _layouts directory
    And I have the following post:
      | title     | date      | layout | category | content                 |
      | Star Wars | 3/27/2009 | simple | movies   | Luke, I am your father. |
    And I have a simple layout that contains "Post category: {{ site.posts.first.categories }}"
    When I run jekyll
    Then the _site directory should exist
    And I should see "Post category: movies" in "_site/movies/2009/03/27/star-wars.html"

  Scenario: Use post.categories variable when categories are in YAML
    Given I have a _posts directory
    And I have a _layouts directory
    And I have the following post:
      | title     | date      | layout | categories          | content                 |
      | Star Wars | 3/27/2009 | simple | ['movies', 'scifi'] | Luke, I am your father. |
    And I have a simple layout that contains "Post categories: {{ site.posts.first.categories | array_to_sentence_string }}"
    When I run jekyll
    Then the _site directory should exist
    And I should see "Post categories: movies and scifi" in "_site/movies/scifi/2009/03/27/star-wars.html"

  Scenario: Use post.topics variable
    Given I have a _posts directory
    And I have a _posts/movies directory
    And I have a _posts/movies/scifi directory
    And I have a _layouts directory
    And I have the following post under "movies/scifi":
      | title     | date      | layout | content                 |
      | Star Wars | 3/27/2009 | simple | Luke, I am your father. |
    And I have a simple layout that contains "Post topics: {{ site.posts.first.topics | array_to_sentence_string }}"
    When I run jekyll
    Then the _site directory should exist
    And I should see "Post topics: movies and scifi" in "_site/2009/03/27/star-wars.html"

  Scenario: Disable a post from being published
    Given I have a _posts directory
    And I have an "index.html" file that contains "Published!"
    And I have the following post:
      | title     | date      | layout | published | content                 |
      | Star Wars | 3/27/2009 | simple | false     | Luke, I am your father. |
    When I run jekyll
    Then the _site directory should exist
    And the "_site/2009/03/27/star-wars.html" file should not exist
    And I should see "Published!" in "_site/index.html"

  Scenario: Use a custom variable
    Given I have a _posts directory
    And I have a _layouts directory
    And I have the following post:
      | title     | date      | layout | author      | content                 |
      | Star Wars | 3/27/2009 | simple | Darth Vader | Luke, I am your father. |
    And I have a simple layout that contains "Post author: {{ site.posts.first.author }}"
    When I run jekyll
    Then the _site directory should exist
    And I should see "Post author: Darth Vader" in "_site/2009/03/27/star-wars.html"

  Scenario: Previous and next posts title
    Given I have a _posts directory
    And I have a _layouts directory
    And I have the following posts:
      | title            | date      | layout  | author      | content                 |
      | Star Wars        | 3/27/2009 | ordered | Darth Vader | Luke, I am your father. |
      | Some like it hot | 4/27/2009 | ordered | Osgood      | Nobody is perfect.      |
      | Terminator       | 5/27/2009 | ordered | Arnold      | Sayonara, baby          |
    And I have a ordered layout that contains "Previous post: {{ page.previous.title }} and next post: {{ page.next.title }}"
    When I run jekyll
    Then the _site directory should exist
    And I should see "next post: Some like it hot" in "_site/2009/03/27/star-wars.html"
    And I should see "Previous post: Some like it hot" in "_site/2009/05/27/terminator.html"
