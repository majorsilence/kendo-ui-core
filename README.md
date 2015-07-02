---
title: Test Documentation Repo
publish: false
---

This repository contains sample files for generating a documentation site.

The site uses Jekyll (http://jekyllrb.com), a static site generator.   It uses plugins and is thus not compatible with github pages. For hosting it yourself, see [Setting up a local copy of the website](#setting-up-a-local-copy-of-the-website).

Contributing to the website
---------------------------

**Note:** Major issues or feature requests should be filed on the [issue tracker](https://github.com/DeveloperName/ProjectName) first, so we can discuss the implications.

If you want to edit a page, the easiest way is to click the __Edit page on GitHub__ link under the page title on the website.

This will open the source file on GitHub where you can click the __pencil button__ to start editing.

GitHub's editor shows you both the __Markdown__ source as well as a preview of the rendered page.
__Code editor__

After you've finished your changes, enter a proper summary and description and click the __Propose file change__ button to open a pull request.

Setting up a local copy of the website
--------------------------------------

* Clone the repo
* Install virtualbox
* Install vagrant
* Open a command window in the base cloned folder and run
    * vagrant up
* vagrant ssh
* cp -R /documentation /root/tmp/documentation
* jekyll build --source /root/tmp/documentation --destination /var/www/documentation.majorsilence.com

You can now view the site from your computer by browsing to localhost:4080


Repository structure
--------------------

 - `_includes` - *special folder* contains snippets that can be included via `{% include file.html %}` in other pages
 - `_layouts` - *special folder* contains the layouts that are shared between pages. Layouts can be inherited, the root layout is `index.html`.
 - `_site` - the output of the generated site is stored here by default, this folder only exists after Jekyll built the site
 - `_assets` - contains the main stylesheet and javascript
 - `images` - stores the images used in pages

* Any other folders are most likely user created content


Createing new Content
--------------------
* Find a folder that matches what you want to write
* Create a new markdown document
* Edit _config.yml navagation section to add your new markdown file or folder
* Send a pull request with your change for review.
