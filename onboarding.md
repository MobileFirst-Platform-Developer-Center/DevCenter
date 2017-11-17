## Working with the developer center
This document is an overview for experienced users of the technologies used to develop, build and run the DevCenter.  For more detailed instructions, please read the Onboarding Guide in our Github Wiki.

This website is power by several technologies: 

* Bootstrap for a responsive layout
* Jekyll and Liquid templating to compile and transform the source files into static HTML files
* Custom plug-ins in Ruby for optimized build performance and other functionalities (breadcrumbs, sidebar, ...)
* Various open source projects for enhanced functionalities (spinners, auto-links, ...)
* SASS (and SCSS) for CSS optimizations
* Markdown for writing tutorials and blog posts
* Disqus as the commenting platform
* Elasticsearch as the search platform
* Git for storing everything
* Travis CI to automate building and publishing (IBM internal)
* Bluemix as the hosting service (IBM internal)

If you'd like to contribute to this site as outlined in our [contribution guidelines](contribution.md), you can follow these steps to work locally and preview your work before submitting your pull request.

1. Fork this repository and clone your fork to your workstation.
2. Set up Jekyll and test locally.

  Jekyll is software that takes the Developer Center source files and compiles them into the static HTML files that you see when visiting the site. Follow the below to set up Jekyll locally in order test your changes.
  
  * Windows users can [follow this guide](https://jekyllrb.com/docs/windows/) by the Jekyll community.
  * Linux (Ubuntu) users, run these commands:

    ```bash
    sudo apt-get install jekyll
    sudo apt-get install bundler
    ```

  * Mac users:
    - **Ruby**: If you have a Mac, you've most likely already got Ruby. If you open up the Terminal application, and run the command `ruby --version` you can confirm this. Your Ruby version should be at least 2.0.0. If you've got that, you're all set. Otherwise, follow [these instructions](https://www.ruby-lang.org/en/downloads/) to install Ruby.
    - **Xcode command line tools**: http://quantgreeks.com/how-to-install-xcode-command-line-tools-in-osx-yosemite/
    - **RVM**: This is optional but recommended. [RVM](https://rvm.io/) is a Ruby Version Manager, it allows you, among other things, to easily switch between versions. Also, when using RVM you no longer need to use `sudo` before any of them `gem` commands.
    - **Bundler**: If you don't already have Bundler installed, you can install it by running the command `sudo gem install bundler`.  (If you installed `rvm`, don't `sudo`!)

With the environment ready, now:

1. Open Terminal and navigate to the root of the cloned repository
2. Run `bundle install` (You may get errors the first time, read it, it may ask you to install other prerequisites)
3. Run `bundle exec jekyll serve` (this will take about a minute) to generate the static HTML files and start a small web server.
4. Open your browser at [http://localhost:4000/](http://localhost:4000/)

Step 3 will take place upon each and every "save" operation done to content in the website's source files.

#### Faster building
If you feel like it's taking too long to build the site, there are workarounds for you.

#### Exclude

- Create a new file called `_customConfig.yml` at the root of the cloned repository.
- Add an `exclude` property; it takes an array of paths to ignore during the build stage.  

For example, if you are working on a blog post and don't need to generate the tutorials, add:

```
exclude:
- tutorials
```

From the command line, instead of the standard `serve` command described above use this one: `bundle exec jekyll serve --config _config.yml,_customConfig.yml`.

This will combine the default required configuration file and the custom configuration file into one. The custom configuration file **must not be committed** to the repository (if you use "_customConfig.yml", it's already .gitignored).

#### Incremental building
Jekyll will watch your files and trigger a build on any change. To make those subsequent builds faster, try the experimental option `--incremental`.

From the command line, instead of the standard `serve` command described above use this one: `bundle exec jekyll serve --incremental`.

> Note about the `--incremental` flag: due to its experimental nature, it may sometimes not work correctly (i.e. your changes are not seen after they are built. In which case run the [`clean` command](#tips).

You can also combine the two tricks above. Your final command should look like:  
`bundle exec jekyll serve --config _config.yml,_customConfig.yml --incremental`

#### Commit, sync and pull

1. After changes are made, you can commit them to your forked repository with a descriptive text.  
2. Make a new pull request so that the admins will merge your changes, from your forked repository back into the master branch of the Developer Center's repository.  

#### Enable others to load your site while running on your laptop

To allow people to access your Jekyll server via your IP address or Bonjour name, add "--host 0.0.0.0" when you start Jekyll (e.g. "bundle exec jekyll serve --incremental --host 0.0.0.0")

#### Keep your fork up to date!
To avoid conflicts it is very important to keep your fork up to date with the original upstream repository. _Don't create a Pull Request if you are not up to date_.

#### Tips

**Keep the Jekyll bundles up to date**  
It is good from time to time to update Jekyll with fixes. From the repository directory, run the command `bundle update`.

**Clear the Jekyll cache**  
The `--incremental` option mentioned above is experimental and so it may sometimes fail. Meaning, you make a change, Jekyll rebuilds the site but you do not see your change. Clearing the cache and re-building tends to help.

The command to use is: `bundle exec jekyll clean`

