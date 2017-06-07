# Contributing to IBM MobileFirst Foundation Developer Center
## Tutorials and samples
We've open sourced our tutorials and samples so that if you will find an error in a sample or the documentation, you'll have an easy way and to submit a correction by making a *pull request* or by opening a *new issue*. Contributing pull requests leads to better, more accurate and more helpful tutorials and samples.

* For sample applications, please use the [specific sample's repository](https://github.com/MobileFirst-Platform-Developer-Center) for opening issues and pull requests.  
* For product documentation, please use this very repository. The source files for product documentation or tutorials is in markdown.
* If you have a question about a sample or about the product, start a new question on [StackOverflow](https://stackoverflow.com/questions/ask) with the **ibm-mobilefirst** tag or join our [Slack community](https://mobilefirstplatform.ibmcloud.com/blog/2017/05/26/come-chat-with-us/).

#### Pull requests  
Make small pull requests. The smaller a change is, the easier it is to confirm and accept it. When submitting a pull reuqest, be descriptive - what did you change, and why did you make the change.

* Learn more about pull requests: [https://guides.github.com/introduction/flow/](https://guides.github.com/introduction/flow/).
* Before making a pull request, consider [testing your changes locally](onboarding.md).

## Blog posts
If you'd like to contribute a blog post about work you've done with IBM MobileFirst Foundation, follow these steps:

1. Fork the repository and clone it to your workstation.
2. Create a markdown (.md) file to author your blog post in it.
3. Place the .md file under `_posts/<year>/your-blogpost.md`.

    Your blog post should be named `YYY-MM-DD-your-lowercase-title.md`. For example `2016-09-10-my-new-blog-post.md`.

4. Make a pull request of your changes back to this repository.

At the very top of the .md file, add the following. For example:

```
---
title: 'my blog post title'
date: 2016-02-03 // date of the blog post publication
tags:
- MobileFirst_Foundation
- Additional_Tag
version:
- 8.0
author:
  name: Your name here
---
```

Add a description of your role in your company and which company you work for. For example:

> Idan Adar is a Developer at IBM, working on developer enablement for IBM MobileFirst Foundation.

Include a brief introduction that describes the purpose of your post, and explains how it will address a problem the reader might be having. For example, if you are writing about how to implement social log-in with MobileFirst Foundation, include a few words about why social log-in might be useful, and how MobileFirst Foundation makes life easier for the developer who wants to implement this. In other words, go a bit beyond the "How to" and include a bit of the "Why" what you are writing about is important.

### Code Snippets
#### One-line
In Markdown, to show a small piece of code such as `myFunction()` you use the backtik symbol (\`), like so:

```javascript
`myFunction()`
```

#### Multi-line
To include a code snippet, you can start your code with 3 backticks: ` ````` `, optionally followed by the language name (replace `xml` by the language of your choice - [see list](https://github.com/jneen/rouge/wiki/List-of-supported-languages-and-lexers)) :

    ```xml
    <?xml version="1.0" encoding="UTF-8"?>
    ...
    ...
    ```

### Images
#### Hosting
If the image is hosted externally, that's easy enough.

Syntax example:  
`![my-alt-text](http(s)://myexample.com/image-filename.png)`

But what if not? Where should I upload the image?  
We've decided on a standard to help keep track of the images:  

- Create a new folder in the **assets/blog** folder with the same name as your blog post.  
 For example, if you are working on `2016-09-10-my-new-blog-post.md`, create a new folder called `2016-09-10-my-new-blog-post`, at the same level.
- Put your images in this new folder (avoid spaces and special characters in the filenames).

Syntax example:  
`![my-alt-text]({{site.baseurl}}/assets/blog/your-blog-post-filename/image-filename.png)`

### Videos
To embed a video, use the following code snippet:

```html
<div class="sizer">
    <div class="embed-responsive embed-responsive-16by9">
        <iframe src="https://www.youtube.com/embed/E85hZZTnW2w"></iframe>
    </div>
</div>
```

Replace `E85hZZTnW2w` with your video's ID.
