---
title: Onboarding Guide
layout: tutorial
---
The purpose of this guide is to quickly setup your workstation in order to work with the Developer Center source, make changes, test your changes and finally, push them to the live site.

<br>
### Repository access and GitHub Desktop

1. Attempt accessing [https://github.ibm.com/MFPSamples/mfpsamples.github.ibm.com/wiki](https://github.ibm.com/MFPSamples/mfpsamples.github.ibm.com/wiki).  
If you are unable to access it, request access to GitHub Enterprise from Nathan Hazout.

2. Once you are able to access the repository, install GitHut Desktop for Mac/Windows or any other Git client. Follow [these instructions](https://github.ibm.com/MFPSamples/Utils/wiki/Learn-Git,-GitHub-and-Git-clients) to be able to use it with GitHub Enterprise.

### Fork the repository, then clone it

1. In GHE, first change to the Jekyll branch: 
    <img src="{{site.baseurl}}/assets/onboarding/jekyll-branch.png" width="500px"/>
    
2. Click the fork button:  
    <img src="{{site.baseurl}}/assets/onboarding/fork.png" width="500px"/>

3. In the forked repository, click the "Clone in Desktop" button:  
    <img src="{{site.baseurl}}/assets/onboarding/clone.png" width="200px"/>

4. Now that you have the repository cloned in your workstation, make sure to switch to the _jekyll_ branch before making any changes.  
    <img src="{{site.baseurl}}/assets/onboarding/jekyll-branch-local.png" width="500px"/>
    
5. You can now start making changes to the source and content. However before pushing the changes to your cloned repository you must first **test them locally**.

### Setup Jekyll and test locally

Jekyll is software that takes the Developer Center source files and compiles them into the static HTML files that you see when visiting the site. Follow the below to setup Jekyll locally in order test your changes before pushing them to your repository in GHE, and from there back to the website by the admins. [Wiki page with instructions](https://github.ibm.com/MFPSamples/mfpsamples.github.ibm.com/wiki/Testing-locally).

#### Prerequisites

- **Git**: [https://github.ibm.com/MFPSamples/Utils/wiki/Learn-Git,-GitHub-and-Git-clients](https://github.ibm.com/MFPSamples/Utils/wiki/Learn-Git,-GitHub-and-Git-clients)
- **Ruby**: If you have a Mac, you've most likely already got Ruby. If you open up the Terminal application, and run the command `ruby --version` you can confirm this. Your Ruby version should be at least 2.0.0. If you've got that, you're all set. Otherwise, follow these instructions to install Ruby.
- **Bundler**: If you don't already have Bundler installed, you can install it by running the command gem install bundler.

#### Steps

1. Open Terminal and navigate to the root of the repository
2. Run `bundle install` (You may get errors the first time, read it, it may ask you to install other prerequisites)
3. Run `bundle exec jekyll server`
4. Wait... wait... wait...
5. Open your browser at [http://localhost:4000/MFPSamples/](http://localhost:4000/MFPSamples/)


### Commit, sync and pull

 Sync often. **Make sure your locally repository is always up-to-date!**

1. After changes are made you can commit them to your forked Jekyll branch with a descriptive text.
    <img src="{{site.baseurl}}/assets/onboarding/commit.png" width="500px"/>

2. Make a new pull request in GHE so that the admins will merge your changes, from your forked repository back into the Jekyll branch of the Developer Center's repository and from there to the live website (the master branch).
    <img src="{{site.baseurl}}/assets/onboarding/pull.png" width="500px"/>